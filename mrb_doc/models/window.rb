class Window
  # Initialises the {Window} for rendering.
  #
  # @example Basic usage
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  # @param width [Integer] The width of the window in pixels
  # @param height [Integer] The height of the window in pixels
  # @param title [String] The title of the window
  # @return [nil]
  # @raise [Window::AlreadyOpenError] If called more than once without closing the other {Window}
  def self.open(width: 800, height: 480, title: "Taylor Game")
    # mrb_Window_open
    # src/mruby_integration/models/window.cpp
    nil
  end

  # Closes the {Window}.
  #
  # @example Basic usage
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   #... later
  #
  #   Window.close
  #
  # @return [nil]
  # @raise [Window::NotReadyError] If called before opening the Window
  def self.close
    # mrb_Window_close
    # src/mruby_integration/models/window.cpp
    nil
  end

  # Has the {Window} been initialised and is it ready for drawing?
  #
  # @example Basic usage
  #   puts Window.ready?
  #   # => false
  #
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   puts Window.ready?
  #   # => true
  #
  #   #... later
  #
  #   Window.close
  #
  #   puts Window.ready?
  #   # => false
  #
  # @return [Boolean]
  def self.ready?
    # mrb_Window_ready
    # src/mruby_integration/models/window.cpp
    true
  end

  # Gets the width of the {Window}.
  #
  # @example Basic usage
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   puts Window.width
  #   # => 1920
  #
  # @return [Integer]
  # @raise [Window::NotReadyError] If called before opening the Window
  def self.width
    # mrb_Window_width
    # src/mruby_integration/models/window.cpp
    800
  end

  # Gets the height of the {Window}.
  #
  # @example Basic usage
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   puts Window.height
  #   # => 1080
  #
  # @return [Integer]
  # @raise [Window::NotReadyError] If called before opening the Window
  def self.height
    # mrb_Window_height
    # src/mruby_integration/models/window.cpp
    480
  end

  # Sets the title for the {Window}.
  #
  # @example Basic usage
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   puts Window.title
  #   # => "My super cool game!"
  #
  #   Window.title = "A cool new title :)"
  #
  #   puts Window.title
  #   # => "A cool new title :)"
  #
  # @param title [String]
  # @return [String]
  # @raise [Window::NotReadyError] If called before opening the Window
  def self.title=(title)
    # mrb_Window_set_title
    # src/mruby_integration/models/window.cpp
    title
  end

  # Checks if the user has asked the {Window} to close since last frame.
  #
  # @example Basic usage
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   until Window.close?
  #     drawing do
  #       # Render your stuff here
  #     end
  #   end
  #
  # @return [Boolean]
  # @raise [Window::NotReadyError] If called before opening the Window
  def self.close?
    # mrb_Window_close_question
    # src/mruby_integration/models/window.cpp
    false
  end

  # Checks if the flag or config for the {Window} has been set.
  #
  # @example Basic usage
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   puts Window.fullscreen?
  #   # => false
  #
  #   Window.flags = Window::Flag::FULLSCREEN
  #
  #   puts Window.fullscreen?
  #   # => true
  #
  # @param flag [Integer] The flag to check for, check {Window::Flag} for valid options.
  # @return [Boolean]
  def self.flag?(flag)
    # mrb_Window_flag_question
    # src/mruby_integration/models/window.cpp
    true
  end

  # Sets the flags for the {Window}.
  #
  # @example Basic usage
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   puts Window.fullscreen?
  #   # => false
  #   puts Window.resizable?
  #   # => false
  #
  #   Window.flags = Window::Flag::RESIZABLE | Window::Flag::FULLSCREEN
  #
  #   puts Window.fullscreen?
  #   # => true
  #   puts Window.resizable?
  #   # => true
  #
  # @param flag [Integer] The flag to set, check {Window::Flag} for valid options.
  # @return [nil]
  def self.flags=(flag)
    # mrb_Window_flags_equal
    # src/mruby_integration/models/window.cpp
    nil
  end

  # Sets the configuration for the {Window} before you open it.
  #
  # @example Basic usage
  #   Window.config = Window::Flag::MSAA_4X_HINT
  #
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   puts Window.msaa_4x_hinted?
  #   # => true
  #
  # @param flag [Integer] The flag to set, check {Window::Flag} for valid options.
  # @return [nil]
  def self.config=(flag)
    # mrb_Window_config_equals
    # src/mruby_integration/models/window.cpp
    nil
  end

  # Clears the flag for the {Window}.
  #
  # @example Basic usage
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   puts Window.resizable?
  #   # => false
  #
  #   Window.flags = Window::Flag::RESIZABLE
  #
  #   puts Window.resizable?
  #   # => true
  #
  #   Window.clear_flag = Window::Flag::RESIZABLE
  #
  #   puts Window.resizable?
  #   # => false
  #
  # @param flag [Integer] The flag to check for, check {Window::Flag} for valid options.
  # @return [nil]
  def self.clear_flag(flag)
    # mrb_Window_clear_flag
    # src/mruby_integration/models/window.cpp
    nil
  end

  # Sets the key that {Window.close?} listens for.
  #
  # @example Basic usage
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   puts Window.close?
  #   # => false
  #
  #   # Player presses 'q'
  #
  #   puts Window.close?
  #   # => false
  #
  #   Window.exit_key = KEY::Q
  #   # Player presses 'q'
  #
  #   puts Window.close?
  #   # => true
  #
  # @param key [Integer] The key to listen for to close the window
  # @return [Integer]
  # @raise [Window::NotReadyError] If called before opening the Window
  def self.exit_key=(key)
    # mrb_Window_set_exit_key
    # src/mruby_integration/models/window.cpp
    key
  end

  # Returns `true` if the {Window} has been resized since the last frame.
  #
  # @example Basic usage
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   puts Window.resized?
  #   # => false
  #
  #   # Player resizes the window by going full screen
  #
  #   puts Window.resized?
  #   # => true
  #
  # @return [Boolean]
  # @raise [Window::NotReadyError] If called before opening the Window
  def self.resized?
    # mrb_Window_resized
    # src/mruby_integration/models/window.cpp
    True
  end

  # If the {Window} is not fullscreen, fullscreens it. If the {Window} is
  # fullscreen, it turns it back into a window.
  #
  # @example Basic usage
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   puts Window.fullscreen?
  #   # => false
  #
  #   Window.toggle_fullscreen
  #
  #   puts Window.fullscreen?
  #   # => true
  #
  #   Window.toggle_fullscreen
  #
  #   puts Window.fullscreen?
  #   # => false
  #
  # @return [nil]
  # @raise [Window::NotReadyError] If called before opening the Window
  def self.toggle_fullscreen
    # mrb_Window_toggle_fullscreen
    # src/mruby_integration/models/window.cpp
    nil
  end

  # Maximises the {Window} on the current screen.
  #
  # @example Basic usage
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   puts Window.maximised?
  #   # => false
  #
  #   Window.maximise
  #
  #   puts Window.maximised?
  #   # => true
  #
  # @return [nil]
  # @raise [Window::NotReadyError] If called before opening the Window
  def self.maximise
    # mrb_Window_maximise
    # src/mruby_integration/models/window.cpp
    nil
  end

  # Minimises the {Window}.
  #
  # @example Basic usage
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   puts Window.minimised?
  #   # => false
  #
  #   Window.minimise
  #
  #   puts Window.minimised?
  #   # => true
  #
  # @return [nil]
  # @raise [Window::NotReadyError] If called before opening the Window
  def self.minimise
    # mrb_Window_minimise
    # src/mruby_integration/models/window.cpp
    nil
  end

  # Restores a minimised {Window}.
  #
  # @example Basic usage
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   puts Window.minimised?
  #   # => false
  #
  #   Window.minimise
  #
  #   puts Window.minimised?
  #   # => true
  #
  #   Window.restore
  #
  #   puts Window.minimised?
  #   # => false
  #
  # @return [nil]
  # @raise [Window::NotReadyError] If called before opening the Window
  def self.restore
    # mrb_Window_restore
    # src/mruby_integration/models/window.cpp
    nil
  end

  # Sets the icon for the {Window}.
  #
  # @example Basic usage
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   icon = Image.new("./assets/my_cool_icon.png")
  #   Window.icon = icon
  #
  # @param icon [Image]
  # @return [Image]
  # @raise [Window::NotReadyError] If called before opening the Window
  def self.icon=(icon)
    # mrb_Window_set_icon
    # src/mruby_integration/models/window.cpp
    icon
  end

  # Gets the position of the {Window} on the screen.
  #
  # @example Basic usage
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   Window.position = Vector2[100, 200]
  #
  #   puts Window.position
  #   # => Vector2[100, 100]
  #
  # @return [Vector2]
  # @raise [Window::NotReadyError] If called before opening the Window
  def self.position
    # mrb_Window_position
    # src/mruby_integration/models/window.cpp
    Vector2[10, 10]
  end

  # Sets the position of the {Window} on the screen.
  #
  # @example Basic usage
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   Window.position = Vector2[100, 200]
  #
  # @param position [Vector2]
  # @return [Vector2]
  # @raise [Window::NotReadyError] If called before opening the Window
  def self.position=(position)
    # mrb_Window_set_position
    # src/mruby_integration/models/window.cpp
    position
  end

  # Sets the resolution of the {Window}.
  #
  # @example Basic usage
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   Window.resolution = Vector2[1280, 720]
  #
  # @param resolution [Vector2]
  # @return [Vector2]
  # @raise [Window::NotReadyError] If called before opening the Window
  def self.resolution=(resolution)
    # mrb_Window_set_resolution
    # src/mruby_integration/models/window.cpp
    resolution
  end

  # Sets the minimum resolution the {Window} is allowed to be.
  #
  # @example Basic usage
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   Window.minimum_resolution = Vector2[1280, 720]
  #
  # @param position [Vector2]
  # @return [Vector2]
  # @raise [Window::NotReadyError] If called before opening the Window
  def self.minimum_resolution=(resolution)
    # mrb_Window_set_minimum_resolution
    # src/mruby_integration/models/window.cpp
    resolution
  end

  # Sets the opacity of the {Window}.
  #
  # @example Basic usage
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   Window.opacity = 0.75
  #
  # @param opacity [Float] A value between 0.0 and 1.0.
  # @return [Float]
  # @raise [ArgumentError] Raised when passing an invalid opacity.
  def self.opacity=(opacity)
    # mrb_Window_set_opacity
    # src/mruby_integration/models/window.cpp
    opacity
  end

  # Returns an {Image} of the current state of the {Window}.
  #
  # @example Basic usage
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   p Window.to_image
  #   # => #<Image:0x5594c40fce60>
  #
  # @return [Image]
  # @raise [NotReadyError] Raised when passing an invalid opacity.
  def self.to_image
    # mrb_Window_to_image
    # src/mruby_integration/models/window.cpp
    Image.new
  end
end
