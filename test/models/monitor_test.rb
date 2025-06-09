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

      def test_position
        Taylor::Raylib.mock_call("GetMonitorPosition", "1 2")
        monitor = Monitor[0]
        Taylor::Raylib.reset_calls

        assert_equal Vector2[1, 2], monitor.position

        assert_called [
          "(IsWindowReady) { }",
          "(GetMonitorPosition) { monitor: 0 }"
        ]
      end

      def test_position_without_window_ready
        monitor = Monitor[0]
        Taylor::Raylib.mock_call("IsWindowReady", "false")
        Taylor::Raylib.reset_calls

        assert_raise_with_message(Window::NotReadyError, "You must call Window.open before Monitor#position") {
          monitor.position
        }

        assert_called [
          "(IsWindowReady) { }"
        ]
      end

      def test_width
        Taylor::Raylib.mock_call("GetMonitorCount", "2")
        Taylor::Raylib.mock_call("GetMonitorWidth", "3")
        monitor = Monitor[1]
        Taylor::Raylib.reset_calls

        assert_equal 3, monitor.width

        assert_called [
          "(IsWindowReady) { }",
          "(GetMonitorWidth) { monitor: 1 }"
        ]
      end

      def test_width_without_window_ready
        monitor = Monitor[0]
        Taylor::Raylib.mock_call("IsWindowReady", "false")
        Taylor::Raylib.reset_calls

        assert_raise_with_message(Window::NotReadyError, "You must call Window.open before Monitor#width") {
          monitor.width
        }

        assert_called [
          "(IsWindowReady) { }"
        ]
      end

      def test_height
        Taylor::Raylib.mock_call("GetMonitorCount", "3")
        Taylor::Raylib.mock_call("GetMonitorHeight", "4")
        monitor = Monitor[2]
        Taylor::Raylib.reset_calls

        assert_equal 4, monitor.height

        assert_called [
          "(IsWindowReady) { }",
          "(GetMonitorHeight) { monitor: 2 }"
        ]
      end

      def test_height_without_window_ready
        Taylor::Raylib.mock_call("GetMonitorCount", "2")
        monitor = Monitor[1]
        Taylor::Raylib.mock_call("IsWindowReady", "false")
        Taylor::Raylib.reset_calls

        assert_raise_with_message(Window::NotReadyError, "You must call Window.open before Monitor#height") {
          monitor.height
        }

        assert_called [
          "(IsWindowReady) { }"
        ]
      end

      def test_resolution
        Taylor::Raylib.mock_call("GetMonitorCount", "4")
        Taylor::Raylib.mock_call("GetMonitorWidth", "5")
        Taylor::Raylib.mock_call("GetMonitorHeight", "6")
        monitor = Monitor[3]
        Taylor::Raylib.reset_calls

        assert_equal Vector2[5, 6], monitor.resolution

        assert_called [
          "(IsWindowReady) { }",
          "(IsWindowReady) { }",
          "(GetMonitorWidth) { monitor: 3 }",
          "(IsWindowReady) { }",
          "(GetMonitorHeight) { monitor: 3 }"
        ]
      end

      def test_resolution_without_window_ready
        monitor = Monitor[0]
        Taylor::Raylib.mock_call("IsWindowReady", "false")
        Taylor::Raylib.reset_calls

        assert_raise_with_message(Window::NotReadyError, "You must call Window.open before Monitor#resolution") {
          monitor.resolution
        }

        assert_called [
          "(IsWindowReady) { }"
        ]
      end

      def test_refresh_rate
        Taylor::Raylib.mock_call("GetMonitorCount", "5")
        Taylor::Raylib.mock_call("GetMonitorRefreshRate", "7")
        monitor = Monitor[4]
        Taylor::Raylib.reset_calls

        assert_equal 7, monitor.refresh_rate

        assert_called [
          "(IsWindowReady) { }",
          "(GetMonitorRefreshRate) { monitor: 4 }"
        ]
      end

      def test_refresh_rate_without_window_ready
        monitor = Monitor[0]
        Taylor::Raylib.mock_call("IsWindowReady", "false")
        Taylor::Raylib.reset_calls

        assert_raise_with_message(Window::NotReadyError, "You must call Window.open before Monitor#refresh_rate") {
          monitor.refresh_rate
        }

        assert_called [
          "(IsWindowReady) { }"
        ]
      end

      def test_name
        Taylor::Raylib.mock_call("GetMonitorCount", "6")
        Taylor::Raylib.mock_call("*GetMonitorName", "monitor-name")
        monitor = Monitor[5]
        Taylor::Raylib.reset_calls

        assert_equal "monitor-name", monitor.name

        assert_called [
          "(IsWindowReady) { }",
          "(*GetMonitorName) { monitor: 5 }"
        ]
      end

      def test_name_without_window_ready
        monitor = Monitor[0]
        Taylor::Raylib.mock_call("IsWindowReady", "false")
        Taylor::Raylib.reset_calls

        assert_raise_with_message(Window::NotReadyError, "You must call Window.open before Monitor#name") {
          monitor.name
        }

        assert_called [
          "(IsWindowReady) { }"
        ]
      end
    end
  end
end
