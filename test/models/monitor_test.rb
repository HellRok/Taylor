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
    end
  end
end
