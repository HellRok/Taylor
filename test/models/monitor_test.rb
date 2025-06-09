class Test
  class Models
    class Monitor_Test < Test::Base
      def test_count
        Taylor::Raylib.mock_call("GetMonitorCount", "2")

        assert_equal 2, Monitor.count

        assert_called [
          "(IsWindowReady) { }",
          "(GetMonitorCount) { }"
        ]
      end

      def test_count_without_window_ready
        Taylor::Raylib.mock_call("IsWindowReady", "false")

        assert_raise_with_message(Window::NotReadyError, "You must call Window.open before Monitor.count") {
          Monitor.count
        }

        assert_called [
          "(IsWindowReady) { }"
        ]
      end

      def test_initialize
        monitor = Monitor.new(id: 1)

        assert_kind_of Monitor, monitor

        assert_no_calls
      end

      def test_brackets
        monitor = Monitor[0]

        assert_kind_of Monitor, monitor

        assert_called [
          "(IsWindowReady) { }",
          "(IsWindowReady) { }",
          "(GetMonitorCount) { }"
        ]
      end

      def test_brackets_too_low
        Taylor::Raylib.mock_call("GetMonitorCount", "2")

        assert_raise_with_message(ArgumentError, "Must be an integer in (0..1)") {
          Monitor[-1]
        }

        assert_called [
          "(IsWindowReady) { }",
          "(IsWindowReady) { }",
          "(GetMonitorCount) { }"
        ]
      end

      def test_brackets_too_high
        Taylor::Raylib.mock_call("GetMonitorCount", "3")

        assert_raise_with_message(ArgumentError, "Must be an integer in (0..2)") {
          Monitor[3]
        }

        assert_called [
          "(IsWindowReady) { }",
          "(IsWindowReady) { }",
          "(GetMonitorCount) { }"
        ]
      end

      def test_brackets_without_window_ready
        Taylor::Raylib.mock_call("IsWindowReady", "false")

        assert_raise_with_message(Window::NotReadyError, "You must call Window.open before Monitor[]") {
          Monitor[0]
        }

        assert_called [
          "(IsWindowReady) { }"
        ]
      end

      def test_all
        Taylor::Raylib.mock_call("GetMonitorCount", "2")

        monitors = Monitor.all

        assert_equal 2, monitors.size
        assert_kind_of Monitor, monitors[0]
        assert_equal 0, monitors[0].id
        assert_kind_of Monitor, monitors[1]
        assert_equal 1, monitors[1].id

        assert_called [
          "(IsWindowReady) { }",
          "(IsWindowReady) { }",
          "(GetMonitorCount) { }"
        ]
      end

      def test_all_without_window_ready
        Taylor::Raylib.mock_call("IsWindowReady", "false")

        assert_raise_with_message(Window::NotReadyError, "You must call Window.open before Monitor.all") {
          Monitor.all
        }

        assert_called [
          "(IsWindowReady) { }"
        ]
      end

      def test_current
        Taylor::Raylib.mock_call("GetCurrentMonitor", "3")

        monitor = Monitor.current

        assert_kind_of Monitor, monitor
        assert_equal 3, monitor.id

        assert_called [
          "(IsWindowReady) { }",
          "(GetCurrentMonitor) { }"
        ]
      end

      def test_current_without_window_ready
        Taylor::Raylib.mock_call("IsWindowReady", "false")

        assert_raise_with_message(Window::NotReadyError, "You must call Window.open before Monitor.current") {
          Monitor.current
        }

        assert_called [
          "(IsWindowReady) { }"
        ]
      end
    end
  end
end
