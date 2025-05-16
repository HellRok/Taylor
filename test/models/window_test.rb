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
        Window.minimum_size = Vector2[1, 1]
        Taylor::Raylib.reset_calls

        Window.close

        assert_nil Window.minimum_size, "it clears the minimum size"

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

      def test_title=
        Window.open(title: "test title")
        Taylor::Raylib.reset_calls

        assert_equal "test title", Window.title

        assert_equal "My cool new title", (
          Window.title = "My cool new title"
        ), "it returns the set title"

        assert_equal "My cool new title", Window.title, "It has updated @title"
        assert_called [
          "(SetWindowTitle) { title: 'My cool new title' }"
        ]
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

      def test_toggle_fullscreen
        Window.toggle_fullscreen

        assert_called [
          "(ToggleFullscreen) { }"
        ]
      end

      def test_maximise
        Window.maximise

        assert_called [
          "(MaximizeWindow) { }"
        ]
      end

      def test_minimise
        Window.minimise

        assert_called [
          "(MinimizeWindow) { }"
        ]
      end

      def test_restore
        Window.restore

        assert_called [
          "(RestoreWindow) { }"
        ]
      end

      def test_icon=
        Taylor::Raylib.mock_call("GenImageColor", Image.mock_return(width: 1, height: 2, mipmaps: 3, format: 4))
        image = Image.generate(width: 1, height: 2)
        Taylor::Raylib.reset_calls

        Window.icon = image

        assert_called [
          "(SetWindowIcon) { image: { width: 1 height: 2 mipmaps: 3 format: 4 } }"
        ]
      end

      def test_position=
        assert_equal Vector2[1, 2], (
          Window.position = Vector2[1, 2]
        ), "it returns the set position"

        assert_called [
          "(IsWindowReady) { }",
          "(SetWindowPosition) { x: 1 y: 2 }"
        ]
      end

      def test_position_equals_without_window_ready
        Taylor::Raylib.mock_call("IsWindowReady", "false")

        assert_raise(Window::NotReadyError) {
          Window.position = Vector2[1, 1]
        }

        assert_called [
          "(IsWindowReady) { }"
        ]
      end

      def test_minimum_size=
        assert_equal Vector2[3, 4], (
          Window.minimum_size = Vector2[3, 4]
        ), "it returns the set minimum size"

        assert_equal Vector2[3, 4], Window.minimum_size, "it retains the set minimum size"

        assert_called [
          "(IsWindowReady) { }",
          "(SetWindowMinSize) { width: 3 height: 4 }"
        ]
      end

      def test_minimum_size_equals_without_window_ready
        Taylor::Raylib.mock_call("IsWindowReady", "false")

        assert_raise(Window::NotReadyError) {
          Window.minimum_size = Vector2[1, 1]
        }

        assert_nil Window.minimum_size, "it has not set the cvar"

        assert_called [
          "(IsWindowReady) { }"
        ]
      end

      def test_minimum_size
        assert_nil Window.minimum_size, "it is nil before it's set"

        Window.minimum_size = Vector2[5, 6]

        assert_equal Vector2[5, 6], Window.minimum_size, "it is updated after being set"
      end
    end
  end
end
