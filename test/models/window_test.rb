class Test
  class Models
    class Window_Test < Test::Base
      def test_open
        Taylor::Raylib.mock_call("IsWindowReady", "false")

        Window.open(
          width: 1,
          height: 2,
          title: "Some title"
        )

        assert_equal "Some title", Window.title, "It sets the title"
        assert_equal 1.0, Window.opacity, "It sets the opacity"

        assert_called [
          "(IsWindowReady) { }",
          "(InitWindow) { width: 1 height: 2 title: 'Some title' }",
          "(IsWindowReady) { }",
          "(IsWindowReady) { }"
        ]
      end

      def test_open_with_window_already_open
        Taylor::Raylib.mock_call("IsWindowReady", "true")

        assert_raise_with_message(Window::AlreadyOpenError, "You can only open one Window at a time") {
          Window.open(
            width: 1,
            height: 2,
            title: "Some title"
          )
        }

        assert_called [
          "(IsWindowReady) { }"
        ]
      end

      def test_close
        Window.minimum_size = Vector2[1, 1]
        Window.title = "some title"
        Taylor::Raylib.reset_calls

        Window.close

        assert_equal Vector2[0, 0], Window.minimum_size, "it clears the minimum size"
        assert_nil Window.class_variable_get(:@@title), "it clears the title"
        assert_nil Window.class_variable_get(:@@opacity), "it clears the opacity"

        assert_called [
          "(IsWindowReady) { }",
          "(CloseWindow) { }",
          "(IsWindowReady) { }"
        ]
      end

      def test_close_without_window_ready
        Taylor::Raylib.mock_call("IsWindowReady", "false")

        assert_raise_with_message(Window::NotReadyError, "You must call Window.open before Window.close") {
          Window.close
        }

        assert_called [
          "(IsWindowReady) { }"
        ]
      end

      def test_close?
        Taylor::Raylib.mock_call("WindowShouldClose", "false")
        Taylor::Raylib.mock_call("WindowShouldClose", "true")

        assert_equal false, Window.close?
        assert_equal true, Window.close?

        assert_called [
          "(IsWindowReady) { }",
          "(WindowShouldClose) { }",
          "(IsWindowReady) { }",
          "(WindowShouldClose) { }"
        ]
      end

      def test_close_question_without_window_ready
        Taylor::Raylib.mock_call("IsWindowReady", "false")

        assert_raise_with_message(Window::NotReadyError, "You must call Window.open before Window.close?") {
          Window.close?
        }

        assert_called [
          "(IsWindowReady) { }"
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
        Taylor::Raylib.mock_call("IsWindowReady", "false")
        Window.open(width: 2)
        Taylor::Raylib.reset_calls

        assert_equal 2, Window.width

        assert_called [
          "(IsWindowReady) { }",
          "(GetScreenWidth) { }"
        ]
      end

      def test_width_without_window_ready
        Taylor::Raylib.mock_call("IsWindowReady", "false")

        assert_raise_with_message(
          Window::NotReadyError,
          "You must call Window.open before Window.width"
        ) { Window.width }

        assert_called [
          "(IsWindowReady) { }"
        ]
      end

      def test_height
        # Yes, this is the right method, for some reason it's called 'Screen' here?
        Taylor::Raylib.mock_call("GetScreenHeight", "3")
        Taylor::Raylib.mock_call("IsWindowReady", "false")
        Window.open(height: 3)
        Taylor::Raylib.reset_calls

        assert_equal 3, Window.height

        assert_called [
          "(IsWindowReady) { }",
          "(GetScreenHeight) { }"
        ]
      end

      def test_height_without_window_ready
        Taylor::Raylib.mock_call("IsWindowReady", "false")

        assert_raise_with_message(
          Window::NotReadyError,
          "You must call Window.open before Window.height"
        ) { Window.height }

        assert_called [
          "(IsWindowReady) { }"
        ]
      end

      def test_title
        Taylor::Raylib.mock_call("IsWindowReady", "false")
        Window.open(title: "test title")
        Taylor::Raylib.reset_calls

        assert_equal "test title", Window.title

        assert_called [
          "(IsWindowReady) { }"
        ]
      end

      def test_title_without_window_ready
        Taylor::Raylib.mock_call("IsWindowReady", "false")

        assert_raise_with_message(Window::NotReadyError, "You must call Window.open before Window.title") {
          Window.title
        }

        assert_called [
          "(IsWindowReady) { }"
        ]
      end

      def test_title=
        Taylor::Raylib.mock_call("IsWindowReady", "false")
        Window.open(title: "test title")
        Taylor::Raylib.reset_calls

        assert_equal "test title", Window.title

        assert_equal "My cool new title", (
          Window.title = "My cool new title"
        ), "it returns the set title"

        assert_equal "My cool new title", Window.title, "It has updated @title"
        assert_called [
          "(IsWindowReady) { }",
          "(IsWindowReady) { }",
          "(SetWindowTitle) { title: 'My cool new title' }",
          "(IsWindowReady) { }"
        ]
      end

      def test_title_equals_without_window_ready
        Taylor::Raylib.mock_call("IsWindowReady", "false")

        assert_raise_with_message(Window::NotReadyError, "You must call Window.open before Window.title=") {
          Window.title = "Bad title"
        }

        assert_called [
          "(IsWindowReady) { }"
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
          "(IsWindowReady) { }",
          "(SetExitKey) { key: 46 }",
          "(IsWindowReady) { }",
          "(SetExitKey) { key: 256 }"
        ]
      end

      def test_exit_key_equals_without_window_ready
        Taylor::Raylib.mock_call("IsWindowReady", "false")

        assert_raise_with_message(Window::NotReadyError, "You must call Window.open before Window.exit_key=") {
          Window.exit_key = Key::PERIOD
        }

        assert_called [
          "(IsWindowReady) { }"
        ]
      end

      def test_resized?
        Taylor::Raylib.mock_call("IsWindowResized", "false")
        Taylor::Raylib.mock_call("IsWindowResized", "true")

        assert_false Window.resized?
        assert_true Window.resized?

        assert_called [
          "(IsWindowReady) { }",
          "(IsWindowResized) { }",
          "(IsWindowReady) { }",
          "(IsWindowResized) { }"
        ]
      end

      def test_resized_question_without_window_ready
        Taylor::Raylib.mock_call("IsWindowReady", "false")

        assert_raise_with_message(Window::NotReadyError, "You must call Window.open before Window.resized?") {
          Window.resized?
        }

        assert_called [
          "(IsWindowReady) { }"
        ]
      end

      def test_toggle_fullscreen
        Window.toggle_fullscreen

        assert_called [
          "(IsWindowReady) { }",
          "(ToggleFullscreen) { }"
        ]
      end

      def test_toggle_fullscreen_without_window_ready
        Taylor::Raylib.mock_call("IsWindowReady", "false")

        assert_raise_with_message(Window::NotReadyError, "You must call Window.open before Window.toggle_fullscreen") {
          Window.toggle_fullscreen
        }

        assert_called [
          "(IsWindowReady) { }"
        ]
      end

      def test_maximise
        Window.maximise

        assert_called [
          "(IsWindowReady) { }",
          "(MaximizeWindow) { }"
        ]
      end

      def test_maximise_without_window_ready
        Taylor::Raylib.mock_call("IsWindowReady", "false")

        assert_raise_with_message(Window::NotReadyError, "You must call Window.open before Window.maximise") {
          Window.maximise
        }

        assert_called [
          "(IsWindowReady) { }"
        ]
      end

      def test_minimise
        Window.minimise

        assert_called [
          "(IsWindowReady) { }",
          "(MinimizeWindow) { }"
        ]
      end

      def test_minimise_without_window_ready
        Taylor::Raylib.mock_call("IsWindowReady", "false")

        assert_raise_with_message(Window::NotReadyError, "You must call Window.open before Window.minimise") {
          Window.minimise
        }

        assert_called [
          "(IsWindowReady) { }"
        ]
      end

      def test_restore
        Window.restore

        assert_called [
          "(IsWindowReady) { }",
          "(RestoreWindow) { }"
        ]
      end

      def test_restore_without_window_ready
        Taylor::Raylib.mock_call("IsWindowReady", "false")

        assert_raise_with_message(Window::NotReadyError, "You must call Window.open before Window.restore") {
          Window.restore
        }

        assert_called [
          "(IsWindowReady) { }"
        ]
      end

      def test_icon=
        Taylor::Raylib.mock_call("GenImageColor", Image.mock_return(width: 1, height: 2, mipmaps: 3, format: 4))
        image = Image.generate(width: 1, height: 2)
        Taylor::Raylib.reset_calls

        Window.icon = image

        assert_called [
          "(IsWindowReady) { }",
          "(SetWindowIcon) { image: { width: 1 height: 2 mipmaps: 3 format: 4 } }"
        ]
      end

      def test_icon_equals_without_window_ready
        Taylor::Raylib.mock_call("IsWindowReady", "false")
        image = Image.generate(width: 1, height: 2)
        Taylor::Raylib.reset_calls

        assert_raise_with_message(Window::NotReadyError, "You must call Window.open before Window.icon=") {
          Window.icon = image
        }

        assert_called [
          "(IsWindowReady) { }"
        ]
      end

      def test_size=
        assert_equal Vector2[6, 7], (
          Window.size = Vector2[6, 7]
        ), "it returns the set size"

        assert_called [
          "(IsWindowReady) { }",
          "(SetWindowSize) { width: 6 height: 7 }"
        ]
      end

      def test_size_equals_without_window_ready
        Taylor::Raylib.mock_call("IsWindowReady", "false")

        assert_raise_with_message(Window::NotReadyError, "You must call Window.open before Window.size=") {
          Window.size = Vector2[1, 1]
        }

        assert_called [
          "(IsWindowReady) { }"
        ]
      end

      def test_size
        Taylor::Raylib.mock_call("GetScreenWidth", "8")
        Taylor::Raylib.mock_call("GetScreenHeight", "9")

        assert_equal Vector2[8, 9], Window.size, "it returns the window size"

        assert_called [
          "(IsWindowReady) { }",
          "(IsWindowReady) { }",
          "(GetScreenWidth) { }",
          "(IsWindowReady) { }",
          "(GetScreenHeight) { }"
        ]
      end

      def test_size_without_window_ready
        Taylor::Raylib.mock_call("IsWindowReady", "false")

        assert_raise_with_message(Window::NotReadyError, "You must call Window.open before Window.size") {
          Window.size
        }

        assert_called [
          "(IsWindowReady) { }"
        ]
      end

      def test_position
        Taylor::Raylib.mock_call("GetWindowPosition", Vector2.mock_return(x: 10, y: 11))

        assert_equal Vector2[10, 11], Window.position, "it returns the window position"

        assert_called [
          "(IsWindowReady) { }",
          "(GetWindowPosition) { }"
        ]
      end

      def test_position_without_window_ready
        Taylor::Raylib.mock_call("IsWindowReady", "false")

        assert_raise_with_message(Window::NotReadyError, "You must call Window.open before Window.position") {
          Window.position
        }

        assert_called [
          "(IsWindowReady) { }"
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

        assert_raise_with_message(Window::NotReadyError, "You must call Window.open before Window.position=") {
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
          "(SetWindowMinSize) { width: 3 height: 4 }",
          "(IsWindowReady) { }"
        ]
      end

      def test_minimum_size_equals_without_window_ready
        Taylor::Raylib.mock_call("IsWindowReady", "false")

        assert_raise_with_message(Window::NotReadyError, "You must call Window.open before Window.minimum_size=") {
          Window.minimum_size = Vector2[1, 1]
        }

        assert_nil Window.class_variable_get(:@@minimum_size), "it has not set the cvar"

        assert_called [
          "(IsWindowReady) { }"
        ]
      end

      def test_minimum_size
        assert_equal Vector2[0, 0], Window.minimum_size, "it is 0, 0 before it's set"

        Window.minimum_size = Vector2[5, 6]

        assert_equal Vector2[5, 6], Window.minimum_size, "it is updated after being set"

        assert_called [
          "(IsWindowReady) { }",
          "(IsWindowReady) { }",
          "(SetWindowMinSize) { width: 5 height: 6 }",
          "(IsWindowReady) { }"
        ]
      end

      def test_minimum_size_without_window_ready
        Taylor::Raylib.mock_call("IsWindowReady", "false")

        assert_raise_with_message(Window::NotReadyError, "You must call Window.open before Window.minimum_size") {
          Window.minimum_size
        }

        assert_called [
          "(IsWindowReady) { }"
        ]
      end

      def test_opacity
        Taylor::Raylib.mock_call("IsWindowReady", "false")
        Window.open
        Taylor::Raylib.reset_calls

        assert_equal 1.0, Window.opacity

        assert_called [
          "(IsWindowReady) { }"
        ]
      end

      def test_opacity_without_window_ready
        Taylor::Raylib.mock_call("IsWindowReady", "false")

        assert_raise_with_message(Window::NotReadyError, "You must call Window.open before Window.opacity") {
          Window.opacity
        }

        assert_called [
          "(IsWindowReady) { }"
        ]
      end

      def test_opacity=
        Taylor::Raylib.mock_call("IsWindowReady", "false")
        Window.open
        Taylor::Raylib.reset_calls

        assert_equal 1.0, Window.opacity

        assert_equal 0.5, (Window.opacity = 0.5)

        assert_equal 0.5, Window.opacity

        assert_called [
          "(IsWindowReady) { }",
          "(IsWindowReady) { }",
          "(SetWindowOpacity) { opacity: 0.500000 }",
          "(IsWindowReady) { }"
        ]
      end

      def test_opacity_equals_without_window_ready
        Taylor::Raylib.mock_call("IsWindowReady", "false")

        assert_raise_with_message(Window::NotReadyError, "You must call Window.open before Window.opacity=") {
          Window.opacity = 0.5
        }

        assert_nil Window.class_variable_get(:@@opacity), "it has not set the cvar"

        assert_called [
          "(IsWindowReady) { }"
        ]
      end

      def test_opacity_equals_too_low
        assert_raise_with_message(ArgumentError, "Opacity must be within (0.0..1.0)") {
          Window.opacity = -0.1
        }

        assert_nil Window.class_variable_get(:@@opacity), "it has not set the cvar"

        assert_called [
          "(IsWindowReady) { }"
        ]
      end

      def test_opacity_equals_too_high
        assert_raise_with_message(ArgumentError, "Opacity must be within (0.0..1.0)") {
          Window.opacity = 1.1
        }

        assert_nil Window.class_variable_get(:@@opacity), "it has not set the cvar"

        assert_called [
          "(IsWindowReady) { }"
        ]
      end
    end
  end
end
