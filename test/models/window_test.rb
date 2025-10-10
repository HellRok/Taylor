@unit.describe "Window#open" do
  Given "the window is not already open" do
    Taylor::Raylib.mock_call("IsWindowReady", "false")
  end

  When "we open the window" do
    Window.open(
      width: 1,
      height: 2,
      title: "Some title"
    )
  end

  Then "we set the title and opacity" do
    expect(Window.title).to_equal("Some title")
    expect(Window.opacity).to_equal(1.0)
  end

  But "if the window is already open" do
    Taylor::Raylib.mock_call("IsWindowReady", "true")
  end

  Then "raise an error" do
    expect {
      Window.open(
        width: 1,
        height: 2,
        title: "Some title"
      )
    }.to_raise(
      Window::AlreadyOpenError,
      "You can only open one Window at a time"
    )
  end
end

@unit.describe "Window#close" do
  Given "the window is already open" do
    Taylor::Raylib.mock_call("IsWindowReady", "true")
  end

  When "we close the window" do
    Window.close
  end

  Then "we clear all the class variables" do
    expect(Window.minimum_resolution).to_equal(Vector2[0, 0])
    expect(Window.class_variable_get(:@@title)).to_be_nil
    expect(Window.class_variable_get(:@@opacity)).to_be_nil
  end

  But "if the window is not open" do
    Taylor::Raylib.mock_call("IsWindowReady", "false")
  end

  Then "raise an error" do
    expect {
      Window.close
    }.to_raise(
      Window::NotReadyError,
      "You must call Window.open before Window.close"
    )
  end
end

@unit.describe "Window.close?" do
  Given "we haven't been asked to close the window" do
    Taylor::Raylib.mock_call("WindowShouldClose", "false")
  end

  Then "return false" do
    expect(Window.close?).to_be_false
  end

  Given "we haven been asked to close the window" do
    Taylor::Raylib.mock_call("WindowShouldClose", "true")
  end

  Then "return false" do
    expect(Window.close?).to_be_true
  end

  But "if we call it before the window is open" do
    Taylor::Raylib.mock_call("IsWindowReady", "false")
  end

  Then "raise an error" do
    expect {
      Window.close?
    }.to_raise(
      Window::NotReadyError,
      "You must call Window.open before Window.close?"
    )
  end
end

@unit.describe "Window.ready?" do
  Given "the window is open" do
    Taylor::Raylib.mock_call("IsWindowReady", "true")
  end

  Then "return true" do
    expect(Window.ready?).to_be_true
  end

  Given "the window is not open" do
    Taylor::Raylib.mock_call("IsWindowReady", "false")
  end

  Then "return true" do
    expect(Window.ready?).to_be_false
  end
end

@unit.describe "Window.begin_drawing" do
  When "we call begin_drawing" do
    Window.begin_drawing
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(BeginDrawing) { }"
      ]
    )
  end
end

@unit.describe "Window.end_drawing" do
  When "we call end_drawing" do
    Window.end_drawing
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(EndDrawing) { }"
      ]
    )
  end
end

@unit.describe "Window.draw" do
  When "we call draw" do
    Window.draw do
      Window.clear(colour: Colour[1, 0, 0, 0])
    end
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(IsWindowReady) { }",
        "(BeginDrawing) { }",
        "(IsWindowReady) { }",
        "(ClearBackground) { color: { r: 1 g: 0 b: 0 a: 0 } }",
        "(EndDrawing) { }"
      ]
    )
  end

  But "when there's an error in the block" do
    Window.draw do
      Window.clear(colour: Colour[2, 0, 0, 0])
      raise StandardError, "Oops!"
      Window.clear(colour: Colour[3, 0, 0, 0]) # standard:disable Lint/UnreachableCode
    end
  rescue => error
    expect(error.message).to_equal("Oops!")
  end

  Then "make sure we call end_drawing" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(IsWindowReady) { }",
        "(BeginDrawing) { }",
        "(IsWindowReady) { }",
        "(ClearBackground) { color: { r: 2 g: 0 b: 0 a: 0 } }",
        "(EndDrawing) { }"
      ]
    )
  end

  But "we try to draw without the window open" do
    Taylor::Raylib.mock_call("IsWindowReady", "false")
  end

  Then "raise an error" do
    expect {
      Window.draw {}
    }.to_raise(
      Window::NotReadyError,
      "You must call Window.open before Window.draw"
    )
  end
end

@unit.describe "Window.begin_blending" do
  When "we call begin_blending" do
    Window.begin_blending(Window::Blend::ADDITIVE)
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(BeginBlendMode) { mode: 1 }"
      ]
    )
  end

  But "when called with a mode below 0, raise an error" do
    expect {
      Window.begin_blending(-1)
    }.to_raise(
      ArgumentError,
      "Blend mode must be within (0..5)"
    )
  end

  Or "when called with a mode above 5" do
    expect {
      Window.begin_blending(6)
    }.to_raise(
      ArgumentError,
      "Blend mode must be within (0..5)"
    )
  end
end

@unit.describe "Window.end_blending" do
  When " we call end_blending" do
    Window.end_blending
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(EndBlendMode) { }"
      ]
    )
  end
end

@unit.describe "Window.blend" do
  When "we call blend" do
    Window.blend(Window::Blend::ALPHA) do
      Window.clear(colour: Colour[1, 0, 0, 0])
    end
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(IsWindowReady) { }",
        "(BeginBlendMode) { mode: 0 }",
        "(IsWindowReady) { }",
        "(ClearBackground) { color: { r: 1 g: 0 b: 0 a: 0 } }",
        "(EndBlendMode) { }"
      ]
    )
  end

  But "when the block contains an error" do
    Window.blend(Window::Blend::MULTIPLIED) do
      Window.clear(colour: Colour[2, 0, 0, 0])
      raise StandardError, "Oops!"
      Window.clear(colour: Colour[3, 0, 0, 0]) # standard:disable Lint/UnreachableCode
    end
  rescue => error
    expect(error.message).to_equal("Oops!")
  end

  Then "make sure we call end_drawing" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(IsWindowReady) { }",
        "(BeginBlendMode) { mode: 2 }",
        "(IsWindowReady) { }",
        "(ClearBackground) { color: { r: 2 g: 0 b: 0 a: 0 } }",
        "(EndBlendMode) { }"
      ]
    )
  end

  But "we try to draw without the window open" do
    Taylor::Raylib.mock_call("IsWindowReady", "false")
  end

  Then "raise an error" do
    expect {
      Window.blend(Window::Blend::MULTIPLIED) {}
    }.to_raise(
      Window::NotReadyError,
      "You must call Window.open before Window.blend"
    )
  end
end

@unit.describe "Window.width" do
  Given "we have opened a 800x480 resolution window" do
    Taylor::Raylib.mock_call("GetScreenWidth", "800")
    Taylor::Raylib.mock_call("IsWindowReady", "false")
    Window.open(width: 800)
    Taylor::Raylib.reset_calls
  end

  Then "the width is 800" do
    expect(Window.width).to_equal(800)
  end

  But "if we call it before we open the window" do
    Taylor::Raylib.mock_call("IsWindowReady", "false")
  end

  Then "raise an error" do
    expect { Window.width }.to_raise(
      Window::NotReadyError,
      "You must call Window.open before Window.width"
    )
  end
end

@unit.describe "Window.height" do
  Given "we have opened a 800x480 resolution window" do
    Taylor::Raylib.mock_call("GetScreenHeight", "480")
    Taylor::Raylib.mock_call("IsWindowReady", "false")
    Window.open(height: 480)
    Taylor::Raylib.reset_calls
  end

  Then "the height is 480" do
    expect(Window.height).to_equal(480)
  end

  But "if we call it before we open the window" do
    Taylor::Raylib.mock_call("IsWindowReady", "false")
  end

  Then "raise an error" do
    expect { Window.height }.to_raise(
      Window::NotReadyError,
      "You must call Window.open before Window.height"
    )
  end
end

@unit.describe "Window.title" do
  Given "we have opened a window with a title" do
    Taylor::Raylib.mock_call("IsWindowReady", "false")
    Window.open(title: "My Cool Game")
    Taylor::Raylib.reset_calls
  end

  Then "the title is set" do
    expect(Window.title).to_equal("My Cool Game")
  end

  But "if we call it before we open the window" do
    Taylor::Raylib.mock_call("IsWindowReady", "false")
  end

  Then "raise an error" do
    expect { Window.title }.to_raise(
      Window::NotReadyError,
      "You must call Window.open before Window.title"
    )
  end
end

@unit.describe "Window.title=" do
  Given "we have opened a window with a title" do
    Taylor::Raylib.mock_call("IsWindowReady", "false")
    Window.open(title: "My Bad Game")
    Taylor::Raylib.reset_calls
  end

  Then "the title is set" do
    expect(Window.title).to_equal("My Bad Game")
  end

  When "we update the title" do
    Window.title = "My Super Cool Game"
  end

  Then "the title is set" do
    expect(Window.title).to_equal("My Super Cool Game")
  end

  But "if we call it before we open the window" do
    Taylor::Raylib.mock_call("IsWindowReady", "false")
  end

  Then "raise an error" do
    expect { Window.title = "oh no" }.to_raise(
      Window::NotReadyError,
      "You must call Window.open before Window.title="
    )
  end
end

@unit.describe "Window.flags=" do
  When "we set the flags" do
    Window.flags = Window::Flag::FULLSCREEN
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(IsWindowReady) { }",
        "(SetWindowState) { flags: 2 }"
      ]
    )
  end

  But "if the window isn't open" do
    Taylor::Raylib.mock_call("IsWindowReady", "false")
  end

  Then "raise an error" do
    expect {
      Window.flags = Window::Flag::FULLSCREEN
    }.to_raise(
      Window::NotReadyError,
      "You must call Window.open before Window.flags="
    )
  end
end

@unit.describe "Window.config=" do
  Given "we haven't opened a window" do
    Taylor::Raylib.mock_call("IsWindowReady", "false")
  end

  When "we set the config" do
    Window.config = Window::Flag::MSAA_4X_HINT
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(IsWindowReady) { }",
        "(SetConfigFlags) { flags: 32 }"
      ]
    )
  end

  But "if the window is open" do
    Taylor::Raylib.mock_call("IsWindowReady", "true")
  end

  Then "raise an error" do
    expect {
      Window.config = Window::Flag::MSAA_4X_HINT
    }.to_raise(
      Window::AlreadyOpenError,
      "You must call Window.open after Window.config="
    )
  end
end

@unit.describe "Window.clear_flag" do
  When "we clear a flag" do
    Window.clear_flag(Window::Flag::UNDECORATED)
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(ClearWindowState) { flags: 8 }"
      ]
    )
  end
end

@unit.describe "Window.flag?" do
  When "the flag is set" do
    Taylor::Raylib.mock_call("IsWindowState", "true")
  end

  Then "return true" do
    expect(Window.flag?(Window::Flag::FULLSCREEN)).to_be_true
  end

  And "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(IsWindowState) { flag: #{Window::Flag::FULLSCREEN} }"
      ]
    )
  end

  When "the flag is not set" do
    Taylor::Raylib.mock_call("IsWindowState", "false")
  end

  Then "return false" do
    expect(Window.flag?(Window::Flag::FULLSCREEN)).to_be_false
  end

  And "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(IsWindowState) { flag: #{Window::Flag::FULLSCREEN} }"
      ]
    )
  end

  When "we call the specific state check methods" do
    7.times {
      Taylor::Raylib.mock_call("IsWindowState", "false")
      Taylor::Raylib.mock_call("IsWindowState", "true")
    }
    Taylor::Raylib.mock_call("IsWindowState", "false")

    expect(Window.fullscreen?).to_be_false
    expect(Window.resizable?).to_be_true
    expect(Window.undecorated?).to_be_false
    expect(Window.transparent?).to_be_true
    expect(Window.msaa_4x_hinted?).to_be_false
    expect(Window.vsync_hinted?).to_be_true
    expect(Window.hidden?).to_be_false
    expect(Window.always_run?).to_be_true
    expect(Window.minimised?).to_be_false
    expect(Window.maximised?).to_be_true
    expect(Window.unfocused?).to_be_false
    expect(Window.focused?).to_be_false # it's !unfocused?
    expect(Window.always_on_top?).to_be_false
    expect(Window.high_dpi?).to_be_true
    expect(Window.interlaced_hinted?).to_be_false
  end

  And "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
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
    )
  end
end

@unit.describe "Window.exit_key=" do
  When "we set the exit key" do
    Window.exit_key = Key::PERIOD
    Window.exit_key = Key::ESCAPE
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(IsWindowReady) { }",
        "(SetExitKey) { key: 46 }",
        "(IsWindowReady) { }",
        "(SetExitKey) { key: 256 }"
      ]
    )
  end

  But "if the window isn't open" do
    Taylor::Raylib.mock_call("IsWindowReady", "false")
  end

  Then "raise an error" do
    expect {
      Window.exit_key = Key::PERIOD
    }.to_raise(
      Window::NotReadyError,
      "You must call Window.open before Window.exit_key="
    )
  end
end

@unit.describe "Window.resized?" do
  When "the window has been resized" do
    Taylor::Raylib.mock_call("IsWindowResized", "true")
  end

  Then "return true" do
    expect(Window.resized?).to_be_true
  end

  When "the window has not been resized" do
    Taylor::Raylib.mock_call("IsWindowResized", "false")
  end

  Then "return false" do
    expect(Window.resized?).to_be_false
  end

  But "if the window isn't open" do
    Taylor::Raylib.mock_call("IsWindowReady", "false")
  end

  Then "raise an error" do
    expect {
      Window.resized?
    }.to_raise(
      Window::NotReadyError,
      "You must call Window.open before Window.resized?"
    )
  end
end

@unit.describe "Window.toggle_fullscreen" do
  When "we toggle fullscreen" do
    Window.toggle_fullscreen
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(IsWindowReady) { }",
        "(ToggleFullscreen) { }"
      ]
    )
  end

  But "if the window isn't open" do
    Taylor::Raylib.mock_call("IsWindowReady", "false")
  end

  Then "raise an error" do
    expect {
      Window.toggle_fullscreen
    }.to_raise(
      Window::NotReadyError,
      "You must call Window.open before Window.toggle_fullscreen"
    )
  end
end

@unit.describe "Window.maximise" do
  When "we maximise" do
    Window.maximise
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(IsWindowReady) { }",
        "(MaximizeWindow) { }"
      ]
    )
  end

  But "if the window isn't open" do
    Taylor::Raylib.mock_call("IsWindowReady", "false")
  end

  Then "raise an error" do
    expect {
      Window.maximise
    }.to_raise(
      Window::NotReadyError,
      "You must call Window.open before Window.maximise"
    )
  end
end

@unit.describe "Window.minimise" do
  When "we minimise" do
    Window.minimise
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(IsWindowReady) { }",
        "(MinimizeWindow) { }"
      ]
    )
  end

  But "if the window isn't open" do
    Taylor::Raylib.mock_call("IsWindowReady", "false")
  end

  Then "raise an error" do
    expect {
      Window.minimise
    }.to_raise(
      Window::NotReadyError,
      "You must call Window.open before Window.minimise"
    )
  end
end

@unit.describe "Window.restore" do
  When "we restore" do
    Window.restore
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(IsWindowReady) { }",
        "(RestoreWindow) { }"
      ]
    )
  end

  But "if the window isn't open" do
    Taylor::Raylib.mock_call("IsWindowReady", "false")
  end

  Then "raise an error" do
    expect {
      Window.restore
    }.to_raise(
      Window::NotReadyError,
      "You must call Window.open before Window.restore"
    )
  end
end

@unit.describe "Window.icon=" do
  Given "we have an image" do
    Taylor::Raylib.mock_call("GenImageColor", Image.mock_return(width: 1, height: 2, mipmaps: 3, format: 4))
    @image = Image.generate(width: 1, height: 2)
    Taylor::Raylib.reset_calls
  end

  When "we set the icon" do
    Window.icon = @image
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(IsWindowReady) { }",
        "(SetWindowIcon) { image: { width: 1 height: 2 mipmaps: 3 format: 4 } }"
      ]
    )
  end

  But "if the window is not open" do
    Taylor::Raylib.mock_call("IsWindowReady", "false")
  end

  Then "raise an error" do
    expect {
      Window.icon = @image
    }.to_raise(
      Window::NotReadyError,
      "You must call Window.open before Window.icon="
    )
  end
end

@unit.describe "Window.resolution=" do
  When "we set the resolution" do
    expect {
      Window.resolution = Vector2[1280, 800]
    }.to_equal(Vector2[1280, 800])
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(IsWindowReady) { }",
        "(SetWindowSize) { width: 1280 height: 800 }"
      ]
    )
  end

  But "when the window isn't open" do
    Taylor::Raylib.mock_call("IsWindowReady", "false")
  end

  Then "raise an error" do
    expect {
      Window.resolution = Vector2[1, 1]
    }.to_raise(
      Window::NotReadyError,
      "You must call Window.open before Window.resolution="
    )
  end
end

@unit.describe "Window.resolution" do
  Given "we have opened a window" do
    Taylor::Raylib.mock_call("IsWindowReady", "true")
    Taylor::Raylib.mock_call("GetScreenWidth", "800")
    Taylor::Raylib.mock_call("GetScreenHeight", "480")
  end

  Then "return the resolution" do
    expect(Window.resolution).to_equal(Vector2[800, 480])
  end

  But "when we don't have a window" do
    Taylor::Raylib.mock_call("IsWindowReady", "false")
  end

  Then "raise an error" do
    expect {
      Window.resolution
    }.to_raise(
      Window::NotReadyError,
      "You must call Window.open before Window.resolution"
    )
  end
end

@unit.describe "Window.position" do
  Given "we have opened a window" do
    Taylor::Raylib.mock_call("IsWindowReady", "true")
    Taylor::Raylib.mock_call("GetWindowPosition", Vector2.mock_return(x: 10, y: 11))
  end

  Then "return the position" do
    expect(Window.position).to_equal(Vector2[10, 11])
  end

  But "when we don't have a window" do
    Taylor::Raylib.mock_call("IsWindowReady", "false")
  end

  Then "raise an error" do
    expect {
      Window.position
    }.to_raise(
      Window::NotReadyError,
      "You must call Window.open before Window.position"
    )
  end
end

@unit.describe "Window.position=" do
  When "we set the position" do
    expect {
      Window.position = Vector2[1, 2]
    }.to_equal(Vector2[1, 2])
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(IsWindowReady) { }",
        "(SetWindowPosition) { x: 1 y: 2 }"
      ]
    )
  end

  But "when the window is not open" do
    Taylor::Raylib.mock_call("IsWindowReady", "false")
  end

  Then "raise an error" do
    expect {
      Window.position = Vector2[1, 1]
    }.to_raise(
      Window::NotReadyError,
      "You must call Window.open before Window.position="
    )
  end
end

@unit.describe "Window.minimum_resolution=" do
  When "we set the minimum_resolution" do
    expect {
      Window.minimum_resolution = Vector2[3, 4]
    }.to_equal(Vector2[3, 4])
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(IsWindowReady) { }",
        "(SetWindowMinSize) { width: 3 height: 4 }"
      ]
    )
  end

  But "when the window is not open" do
    Taylor::Raylib.mock_call("IsWindowReady", "false")
  end

  Then "raise an error" do
    expect {
      Window.minimum_resolution = Vector2[1, 1]
    }.to_raise(
      Window::NotReadyError,
      "You must call Window.open before Window.minimum_resolution="
    )
  end
end

@unit.describe "Window.minimum_resolution" do
  When "called without being set return 0, 0" do
    expect(Window.minimum_resolution).to_equal(Vector2[0, 0])
  end

  And "we set a minimum resolution" do
    Window.minimum_resolution = Vector2[5, 6]
  end

  Then "it's updated" do
    expect(Window.minimum_resolution).to_equal(Vector2[5, 6])
  end

  But "without a window open" do
    Taylor::Raylib.mock_call("IsWindowReady", "false")
  end

  Then "raise an error" do
    expect {
      Window.minimum_resolution
    }.to_raise(
      Window::NotReadyError,
      "You must call Window.open before Window.minimum_resolution"
    )
  end
end

@unit.describe "Window.opacity" do
  Given "we have a window open" do
    Taylor::Raylib.mock_call("IsWindowReady", "false")
    Window.open
  end

  When "called without being set return 1.0" do
    expect(Window.opacity).to_equal(1.0)
  end

  And "we set a opacity resolution" do
    Window.opacity = 0.5
  end

  Then "it's updated" do
    expect(Window.opacity).to_equal(0.5)
  end

  But "without a window open" do
    Taylor::Raylib.mock_call("IsWindowReady", "false")
  end

  Then "raise an error" do
    expect {
      Window.opacity
    }.to_raise(
      Window::NotReadyError,
      "You must call Window.open before Window.opacity"
    )
  end
end

@unit.describe "Window.opacity=" do
  When "we set the opacity" do
    expect { Window.opacity = 0.5 }.to_equal(0.5)
  end

  Then "it is updated" do
    expect(Window.opacity).to_equal(0.5)
  end

  And "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(IsWindowReady) { }",
        "(SetWindowOpacity) { opacity: 0.500000 }",
        "(IsWindowReady) { }"
      ]
    )
  end

  But "when no window is open" do
    Taylor::Raylib.mock_call("IsWindowReady", "false")
  end

  Then "raise an error" do
    expect {
      Window.opacity = 0.5
    }.to_raise(
      Window::NotReadyError,
      "You must call Window.open before Window.opacity="
    )
  end

  But "when setting opacity less than 0.0, raise an error" do
    expect {
      Window.opacity = -0.1
    }.to_raise(
      ArgumentError,
      "Opacity must be within (0.0..1.0)"
    )
  end

  Or "when setting opacity greater than 1.0" do
    expect {
      Window.opacity = 1.1
    }.to_raise(
      ArgumentError,
      "Opacity must be within (0.0..1.0)"
    )
  end
end

@unit.describe "Window.to_image" do
  Given "we have a window setup" do
    Taylor::Raylib.mock_call("LoadImageFromScreen", Image.mock_return(width: 2, height: 3, mipmaps: 4, format: 5))
  end

  When "we call to_image" do
    @image = Window.to_image
  end

  Then "it returns an image" do
    expect(@image).to_be_a(Image)
    expect(@image.width).to_equal(2)
    expect(@image.height).to_equal(3)
    expect(@image.mipmaps).to_equal(4)
    expect(@image.format).to_equal(5)
  end

  But "when the window isn't ready" do
    Taylor::Raylib.mock_call("IsWindowReady", "false")
  end

  Then "raise an error" do
    expect {
      Window.to_image
    }.to_raise(
      Window::NotReadyError,
      "You must call Window.open before Window.to_image"
    )
  end
end

class Test
  class Models
    class Window_Test
      def test_monitor
        Taylor::Raylib.mock_call("GetCurrentMonitor", "2")

        monitor = Window.monitor

        assert_kind_of Monitor, monitor
        assert_equal 2, monitor.id

        assert_called [
          "(IsWindowReady) { }",
          "(IsWindowReady) { }",
          "(GetCurrentMonitor) { }"
        ]
      end

      def test_monitor_without_window_ready
        Taylor::Raylib.mock_call("IsWindowReady", "false")

        assert_raise_with_message(Window::NotReadyError, "You must call Window.open before Window.monitor") {
          Window.monitor
        }

        assert_called [
          "(IsWindowReady) { }"
        ]
      end

      def test_monitor=
        Taylor::Raylib.mock_call("GetMonitorCount", "2")
        monitor = Monitor.all.last
        Taylor::Raylib.reset_calls

        Window.monitor = monitor

        assert_called [
          "(IsWindowReady) { }",
          "(SetWindowMonitor) { monitor: 1 }"
        ]
      end

      def test_monitor_equals_without_window_ready
        Taylor::Raylib.mock_call("IsWindowReady", "false")

        assert_raise_with_message(Window::NotReadyError, "You must call Window.open before Window.monitor=") {
          Window.monitor = Monitor.new(id: 0)
        }

        assert_called [
          "(IsWindowReady) { }"
        ]
      end

      def test_scale
        Taylor::Raylib.mock_call("GetWindowScaleDPI", Vector2.mock_return(x: 1, y: 2))

        scale = Window.scale
        assert_kind_of Vector2, scale
        assert_equal 1, scale.x
        assert_equal 2, scale.y

        assert_called [
          "(IsWindowReady) { }",
          "(GetWindowScaleDPI) { }"
        ]
      end

      def test_scale_without_window_ready
        Taylor::Raylib.mock_call("IsWindowReady", "false")

        assert_raise_with_message(Window::NotReadyError, "You must call Window.open before Window.scale") {
          Window.scale
        }

        assert_called [
          "(IsWindowReady) { }"
        ]
      end

      def test_clear
        Window.clear

        assert_called [
          "(IsWindowReady) { }",
          "(ClearBackground) { color: { r: 0 g: 0 b: 0 a: 255 } }"
        ]
      end

      def test_clear_with_colour
        Window.clear(colour: Colour[4, 0, 0, 0])

        assert_called [
          "(IsWindowReady) { }",
          "(ClearBackground) { color: { r: 4 g: 0 b: 0 a: 0 } }"
        ]
      end

      def test_clear_without_window_ready
        Taylor::Raylib.mock_call("IsWindowReady", "false")

        assert_raise_with_message(Window::NotReadyError, "You must call Window.open before Window.clear") {
          Window.clear
        }

        assert_called [
          "(IsWindowReady) { }"
        ]
      end

      def test_screenshot
        Window.screenshot("screenshot.png")

        assert_called [
          "(IsWindowReady) { }",
          "(TakeScreenshot) { fileName: 'screenshot.png' }"
        ]
      end

      def test_screenshot_without_window_ready
        Taylor::Raylib.mock_call("IsWindowReady", "false")

        assert_raise_with_message(Window::NotReadyError, "You must call Window.open before Window.screenshot") {
          Window.screenshot("screenshot.png")
        }

        assert_called [
          "(IsWindowReady) { }"
        ]
      end

      def test_target_frame_rate=
        Window.target_frame_rate = 60

        assert_called [
          "(SetTargetFPS) { fps: 60 }"
        ]
      end

      def test_frame_rate
        Taylor::Raylib.mock_call("GetFPS", "120")
        Taylor::Raylib.mock_call("GetFPS", "119")

        assert_equal 120, Window.frame_rate
        assert_equal 119, Window.frame_rate

        assert_called [
          "(GetFPS) { }",
          "(GetFPS) { }"
        ]
      end

      def test_frame_time
        Taylor::Raylib.mock_call("GetFrameTime", "0.5")
        Taylor::Raylib.mock_call("GetFrameTime", "1.0")

        assert_equal 0.5, Window.frame_time
        assert_equal 1.0, Window.frame_time

        assert_called [
          "(GetFrameTime) { }",
          "(GetFrameTime) { }"
        ]
      end

      def test_seconds_open
        Taylor::Raylib.mock_call("GetTime", "1.5")
        Taylor::Raylib.mock_call("GetTime", "128.0")

        assert_equal 1.5, Window.seconds_open
        assert_equal 128.0, Window.seconds_open

        assert_called [
          "(GetTime) { }",
          "(GetTime) { }"
        ]
      end

      def test_draw_frame_rate
        Window.draw_frame_rate

        assert_called [
          "(IsWindowReady) { }",
          "(DrawFPS) { posX: 10 posY: 10 }"
        ]
      end

      def test_draw_frame_rate_with_arguments
        Window.draw_frame_rate(x: 10, y: 20)
        Window.draw_frame_rate(x: 20, y: 30)

        assert_called [
          "(IsWindowReady) { }",
          "(DrawFPS) { posX: 10 posY: 20 }",
          "(IsWindowReady) { }",
          "(DrawFPS) { posX: 20 posY: 30 }"
        ]
      end

      def test_draw_frame_rate_without_window_ready
        Taylor::Raylib.mock_call("IsWindowReady", "false")

        assert_raise_with_message(Window::NotReadyError, "You must call Window.open before Window.draw_frame_rate") {
          Window.draw_frame_rate
        }

        assert_called [
          "(IsWindowReady) { }"
        ]
      end
    end
  end
end
