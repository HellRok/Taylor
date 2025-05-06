class Test
  class Models
    class Window_Test < Test::Base
      def test_open
        Window.open(
          width: 1,
          height: 2,
          title: "Some title"
        )

        assert_called [
          "(InitWindow) { width: 1 height: 2 title: 'Some title' }"
        ]
      end

      def test_close?
        Taylor::Raylib.mock_call("WindowShouldClose", "false")
        Taylor::Raylib.mock_call("WindowShouldClose", "true")

        assert_equal false, Window.close?
        assert_equal true, Window.close?

        assert_called [
          "(WindowShouldClose) { }",
          "(WindowShouldClose) { }"
        ]
      end

      def test_ready?
        Taylor::Raylib.mock_call("IsWindowReady", "false")
        Taylor::Raylib.mock_call("IsWindowReady", "true")

        assert_false Window.ready?
        assert_true Window.ready?

        assert_called [
          "(IsWindowReady) { }",
          "(IsWindowReady) { }"
        ]
      end

      def test_window_states
        8.times {
          Taylor::Raylib.mock_call("IsWindowState", "false")
          Taylor::Raylib.mock_call("IsWindowState", "true")
        }

        assert_false Window.flag?(Window::Flag::FULLSCREEN)
        assert_true Window.fullscreen?
        assert_false Window.minimised?
        assert_true Window.hidden?
        assert_false Window.maximised?
        assert_true Window.always_run?
        assert_false Window.resizable?
        assert_true Window.always_on_top?
        assert_false Window.undecorated?
        assert_true Window.vsync_hinted?
        assert_false Window.msaa_4x_hinted?
        assert_true Window.interlaced_hinted?
        assert_false Window.unfocused?
        assert_false Window.focused? # It's backwards
        assert_false Window.transparent?
        assert_true Window.high_dpi?

        assert_called [
          "(IsWindowState) { flag: 2 }",
          "(IsWindowState) { flag: 2 }",
          "(IsWindowState) { flag: 512 }",
          "(IsWindowState) { flag: 128 }",
          "(IsWindowState) { flag: 1024 }",
          "(IsWindowState) { flag: 256 }",
          "(IsWindowState) { flag: 4 }",
          "(IsWindowState) { flag: 4096 }",
          "(IsWindowState) { flag: 8 }",
          "(IsWindowState) { flag: 64 }",
          "(IsWindowState) { flag: 32 }",
          "(IsWindowState) { flag: 65536 }",
          "(IsWindowState) { flag: 2048 }",
          "(IsWindowState) { flag: 2048 }",
          "(IsWindowState) { flag: 16 }",
          "(IsWindowState) { flag: 8192 }"
        ]
      end
    end
  end
end
