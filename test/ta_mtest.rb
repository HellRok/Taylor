module MTest
  class Unit
    def _run args = []
      $ok_test   ||= 0
      $ko_test   ||= 0
      $kill_test ||= 0
      $buildkite_test_analytics = []

      _run_tests

      @test_count ||= 0
      @test_count > 0 ? failures + errors : nil
    end

    def _run_suite(suite)
      header = "test_suite_header"
      puts send(header, suite) if respond_to? header

      assertions = suite.send("test_methods").map do |method|
        inst = suite.new method
        inst._assertions = 0

        print "#{suite}##{method} = " if @verbose

        @start_time = Time.now
        result = inst.run self
        time = Time.now - @start_time

        print sprintf("%.2f s = ", time) if @verbose
        print result[:message]
        puts if @verbose

        $buildkite_test_analytics << {
          "scope": suite,
          "name": method,
          "identifier": "#{suite}##{method}",
          "location": "SOME FILE NAME AND LINE NUMBER HERE",
          "file_name": "SOME FILE NAME HERE",
          "result": (result[:passed] ? "passed" : (result[:message] == "S" ? "skipped" : "failed")),
          "failure_reason": (result[:message] unless result[:passed]),
          "history": {
            "duration": "%.6f" % [time]
          }
        }

        inst._assertions
      end

      return assertions.size, assertions.inject(0) { |sum, n| sum + n }
    end

    def _run_tests
      suites = TestCase.send "test_suites"
      return if suites.empty?

      start = Time.now

      puts
      puts "# Running tests:"
      puts

      results = _run_suites suites

      t = Time.now - start

      puts
      puts
      puts sprintf("Finished tests in %.6fs, %.4f tests/s, %.4f assertions/s.",
        t, test_count / t, assertion_count / t)

      report.each_with_index do |msg, i|
        puts sprintf("\n%3d) %s", i+1, msg)
      end

      puts

      status

      upload_buildkite_test_analytics
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

    class TestCase
      def run runner
        result = {
          passed: nil,
          message: nil,
        }

        begin
          @passed = nil
          self.setup
          self.run_setup_hooks
          self.__send__ self.__name__
          result = "." unless io?
          @passed = true
          result = {
            passed: @passed,
            message: ("." unless io?)
          }
        rescue Exception => e
          @passed = false
          result = {
            passed: @passed,
            message: runner.puke(self.class, self.__name__, e),
          }
        ensure
          begin
            self.run_teardown_hooks
            self.teardown
          rescue Exception => e
            result = {
              passed: @passed,
              message: runner.puke(self.class, self.__name__, e),
            }
          end
        end

        result
      end
    end
  end
end
