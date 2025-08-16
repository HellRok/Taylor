class Test
  class Models
    class Logging_Test < Test::Base
      def test_level=
        assert_equal Logging::ALL, Logging.level

        Logging.level = Logging::TRACE
        assert_equal Logging::TRACE, Logging.level

        Logging.level = Logging::WARNING
        assert_equal Logging::WARNING, Logging.level

        assert_called [
          "(SetTraceLogLevel) { logLevel: 1 }",
          "(SetTraceLogLevel) { logLevel: 4 }"
        ]
      end

      def test_level_equals_with_bad_values
        Logging.level = Logging::TRACE
        assert_equal Logging::TRACE, Logging.level

        assert_raise_with_message(ArgumentError, "Logging level must be within (0..7)") {
          Logging.level = -1
        }
        assert_equal Logging::TRACE, Logging.level

        assert_raise_with_message(ArgumentError, "Logging level must be within (0..7)") {
          Logging.level = 8
        }

        assert_equal Logging::TRACE, Logging.level

        assert_called [
          "(SetTraceLogLevel) { logLevel: 1 }"
        ]
      end

      def test_log
        Logging.log(message: "Hello!")
        Logging.log(level: Logging::FATAL, message: "Oops :(")

        assert_called [
          "(TraceLog) { logLevel: 1 text: 'Hello!' }",
          "(TraceLog) { logLevel: 6 text: 'Oops :(' }"
        ]
      end

      def test_log_with_bad_values
        assert_raise_with_message(ArgumentError, "Logging level must be within (0..7)") {
          Logging.log(level: -1, message: "!")
        }

        assert_raise_with_message(ArgumentError, "Logging level must be within (0..7)") {
          Logging.log(level: 8, message: "!")
        }

        assert_no_calls
      end
    end
  end
end
