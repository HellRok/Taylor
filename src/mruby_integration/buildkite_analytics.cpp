#include "mruby.h"
#include "mruby/compile.h"

void append_buildkite_analytics(mrb_state *mrb) {
  mrb_load_string(mrb, R"(
    module MTest
      class Unit
        class TestCaseWithAnalytics < MTest::Unit::TestCase
          def run(runner)
            @result = super
          end

          def setup
            @start_time = Time.now
          end

          def location
            return 'Could not find file' unless File.exist?(file_name)

            File.read(file_name).each_line.with_index { |line, index|
              return "#{file_name}:#{index + 1}" if line =~ /^\s*def\s*#{self.__name__}(.*)/
            }
          end

          def file_name
            best_guess = self.class.to_s.split('::').map(&:downcase)
            best_guess.reject! { _1 == 'test' }
            best_guess = "#{File.join(best_guess)}.rb"

            if File.exist?(best_guess)
              best_guess
            else
              "Could not find file for #{self.class} assumed #{best_guess}."
            end
          end

          def teardown
            $buildkite_test_analytics ||= []

            $buildkite_test_analytics << {
              "scope": self.class,
              "name": self.__name__,
              "identifier": "#{self.class}##{self.__name__}",
              "location": self.location,
              "file_name": self.file_name,
              "result": (@passed ? "passed" : (@result == "S" ? "skipped" : "failed")),
              "failure_reason": (@result unless @passed),
              "history": {
                "duration": "%.6f" % [Time.now - @start_time]
              }
            }
          end
        end
      end
    end

    def upload_buildkite_test_analytics
      return unless ENV['BUILDKITE_TEST_ANALYTICS_KEY']
      puts
      puts "Found a Buildkite test analytics key, let's upload our results!"
      puts "..."

      client = SimpleHttp.new('https', 'analytics-api.buildkite.com', 443)
      response = client.request(
        "POST",
        '/v1/uploads',
        {
          'Authorization' => "Token token=\"#{ENV['BUILDKITE_TEST_ANALYTICS_KEY']}\"",
          'Content-Type' => 'application/json',
          'Body' => {
            format: 'json',
            run_env: {
              "CI" => "buildkite",
              "key" => ENV['BUILDKITE_BUILD_ID'],
              "number" => ENV['BUILDKITE_BUILD_NUMBER'],
              "job_id" => ENV['BUILDKITE_JOB_ID'],
              "branch" => ENV['BUILDKITE_BRANCH'],
              "commit_sha" => ENV['BUILDKITE_COMMIT'],
              "message" => ENV['BUILDKITE_MESSAGE'],
              "url" => ENV['BUILDKITE_BUILD_URL']
            },
            data: $buildkite_test_analytics
          }.to_json
        }
      )

      puts "Done!"
    end
  )");
}
