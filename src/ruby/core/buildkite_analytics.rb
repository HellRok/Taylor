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

  # Save the analytics to a file
  def self.persist_buildkite_test_analytics
    analytics_json = $buildkite_test_analytics.to_json

    if Taylor::Platform.browser?
      puts "ANALYTICS: #{analytics_json}"
    else
      output = File.open("test-analytics.json", "w")
      output.write(analytics_json)
      output.close
    end
  rescue NoMethodError => error
    puts "Failed to generate JSON, continuing without failing the job"
    puts "Error: #{error.message}"
  end
end
