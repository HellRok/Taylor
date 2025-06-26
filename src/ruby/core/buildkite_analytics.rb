# Monkey patching {MTest} so we can have analytics
module MTest
  # Monkey patching {MTest::Unit}
  class Unit
    # An extension of {MTest::Unit::TestCase} that tracks analytics for build
    # systems.
    class TestCaseWithAnalytics < MTest::Unit::TestCase
      # @return [String]
      attr_accessor :result

      # Monkey patched from {MTest}
      def run runner
        @start_time = Time.now
        @result = ""
        begin
          @passed = nil
          setup
          run_setup_hooks
          __send__ __name__
          @result = "." unless io?
          @passed = true
        rescue Exception => e
          @passed = false
          @result = runner.puke self.class, __name__, e
        ensure
          begin
            run_teardown_hooks
            teardown
          rescue Exception => e
            @result = runner.puke self.class, __name__, e
          end
        end
        @result
      end

      # Tries its best to get the file location
      def location
        return "Could not find file" unless File.exist?(file_name)

        File.read(file_name).each_line.with_index { |line, index|
          return "#{file_name}:#{index + 1}" if line =~ /^\s*def\s*#{__name__}(.*)/
        }
      end

      # Tries its best to get the file name
      def file_name
        best_guess = self.class.to_s.split("::").map(&:downcase)
        second_guess = best_guess.reject { |name| name == "test" }
        best_guess_path = "#{File.join(best_guess)}.rb"
        second_guess_path = "#{File.join(second_guess)}.rb"

        if File.exist?(best_guess_path)
          best_guess_path
        elsif File.exist?(second_guess_path)
          second_guess_path
        else
          "Could not find file for #{self.class} assumed #{best_guess}."
        end
      end

      # Adds the analytics for this test
      def add_analytics
        $buildkite_test_analytics ||= []

        $buildkite_test_analytics << {
          scope: self.class,
          name: __name__,
          identifier: "#{self.class}##{__name__}",
          location: location,
          file_name: file_name,
          result: (if @passed
                     "passed"
                   else
                     ((@result == "S") ? "skipped" : "failed")
                   end),
          failure_reason: (@result unless @passed),
          history: {
            duration: "%.6f" % [Time.now - @start_time]
          }
        }
      end
    end
  end
end

# Upload the analytics to Buildkite
def upload_buildkite_test_analytics
  return unless ENV["BUILDKITE_TEST_ANALYTICS_KEY"]
  puts
  puts "Found a Buildkite test analytics key, let's upload our results!"
  puts "..."

  client = SimpleHttp.new("https", "analytics-api.buildkite.com", 443)
  response = client.request(
    "POST",
    "/v1/uploads",
    {
      "Authorization" => "Token token=\"#{ENV["BUILDKITE_TEST_ANALYTICS_KEY"]}\"",
      "Content-Type" => "application/json",
      "Body" => {
        format: "json",
        run_env: {
          "CI" => "buildkite",
          "key" => ENV["BUILDKITE_BUILD_ID"],
          "number" => ENV["BUILDKITE_BUILD_NUMBER"],
          "job_id" => ENV["BUILDKITE_JOB_ID"],
          "branch" => ENV["BUILDKITE_BRANCH"],
          "commit_sha" => ENV["BUILDKITE_COMMIT"],
          "message" => ENV["BUILDKITE_MESSAGE"],
          "url" => ENV["BUILDKITE_BUILD_URL"]
        },
        data: $buildkite_test_analytics
      }.to_json
    }
  )

  response_data = JSON.parse(response.body)
  puts "ID: #{response_data["id"]}"
  puts "Run ID: #{response_data["run_id"]}"
  puts "Queued: #{response_data["queued"]}"

  puts "Done!"
end

# Save the analytics to a file
def persist_buildkite_test_analytics
  output = File.open("test-analytics.json", "w")
  output.write($buildkite_test_analytics.to_json)
  output.close
end
