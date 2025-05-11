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

      def test_close
        Window.open
        Taylor::Raylib.reset_calls

        Window.close

        assert_called [
          "(CloseWindow) { }"
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

      def test_width
        # Yes, this is the right method, for some reason it's called 'Screen' here?
        Taylor::Raylib.mock_call("GetScreenWidth", "2")
        Window.open(width: 2)
        Taylor::Raylib.reset_calls

        assert_equal 2, Window.width

        assert_called [
          "(GetScreenWidth) { }"
        ]
      end

      def test_height
        # Yes, this is the right method, for some reason it's called 'Screen' here?
        Taylor::Raylib.mock_call("GetScreenHeight", "3")
        Window.open(height: 3)
        Taylor::Raylib.reset_calls

        assert_equal 3, Window.height

        assert_called [
          "(GetScreenHeight) { }"
        ]
      end

      def test_title
        Window.open(title: "test title")
        Taylor::Raylib.reset_calls

        assert_equal "test title", Window.title

        assert_no_calls
      end

      def test_flags=
        Window.flags = Window::Flag::FULLSCREEN

        assert_called [
          "(SetWindowState) { flags: 2 }"
        ]
      end

      def test_config=
        Window.config = Window::Flag::RESIZABLE

        assert_called [
          "(SetConfigFlags) { flags: 4 }"
        ]
      end

      def test_clear_flag
        Window.clear_flag(Window::Flag::UNDECORATED)

        assert_called [
          "(ClearWindowState) { flags: 8 }"
        ]
      end

      def test_window_state_checks
        8.times {
          Taylor::Raylib.mock_call("IsWindowState", "false")
          Taylor::Raylib.mock_call("IsWindowState", "true")
        }

        Window.flag?(Window::Flag::FULLSCREEN)
        Window.fullscreen?
        Window.resizable?
        Window.undecorated?
        Window.transparent?
        Window.msaa_4x_hinted?
        Window.vsync_hinted?
        Window.hidden?
        Window.always_run?
        Window.minimised?
        Window.maximised?
        Window.unfocused?
        Window.focused?
        Window.always_on_top?
        Window.high_dpi?
        Window.interlaced_hinted?

        assert_called [
          "(IsWindowState) { flag: #{Window::Flag::FULLSCREEN} }",
          "(IsWindowState) { flag: #{Window::Flag::FULLSCREEN} }",
          "(IsWindowState) { flag: #{Window::Flag::RESIZABLE} }",
          "(IsWindowState) { flag: #{Window::Flag::UNDECORATED} }",
          "(IsWindowState) { flag: #{Window::Flag::TRANSPARENT} }",
          "(IsWindowState) { flag: #{Window::Flag::MSAA_4X_HINT} }",
          "(IsWindowState) { flag: #{Window::Flag::VSYNC_HINT} }",
          "(IsWindowState) { flag: #{Window::Flag::HIDDEN} }",
          "(IsWindowState) { flag: #{Window::Flag::ALWAYS_RUN} }",
          "(IsWindowState) { flag: #{Window::Flag::MINIMISED} }",
          "(IsWindowState) { flag: #{Window::Flag::MAXIMISED} }",
          "(IsWindowState) { flag: #{Window::Flag::UNFOCUSED} }",
          "(IsWindowState) { flag: #{Window::Flag::UNFOCUSED} }",
          "(IsWindowState) { flag: #{Window::Flag::ALWAYS_ON_TOP} }",
          "(IsWindowState) { flag: #{Window::Flag::HIGH_DPI} }",
          "(IsWindowState) { flag: #{Window::Flag::INTERLACED_HINT} }"
        ]
      end

      def test_exit_key=
        Window.exit_key = Key::PERIOD
        Window.exit_key = Key::ESCAPE

        assert_called [
          "(SetExitKey) { key: 46 }",
          "(SetExitKey) { key: 256 }"
        ]
      end

      def test_resized?
        Taylor::Raylib.mock_call("IsWindowResized", "false")
        Taylor::Raylib.mock_call("IsWindowResized", "true")

        assert_false Window.resized?
        assert_true Window.resized?

        assert_called [
          "(IsWindowResized) { }",
          "(IsWindowResized) { }"
        ]
      end
    end
  end
end
