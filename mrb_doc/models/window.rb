class Window
  # Initialises a window for rendering.
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
end
