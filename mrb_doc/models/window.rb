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
  def self.height
    # mrb_Window_height
    # src/mruby_integration/models/window.cpp
    480
  end

  # Gets the title of the {Window}.
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
  # @return [String]
  def self.title
    # mrb_Window_Title
    # src/mruby_integration/models/window.cpp
    "Taylor Game"
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
end
