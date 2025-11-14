class Monitor
  # @return [Integer]
  attr_reader :id

  # Returns how many monitors are attached to the computer.
  #
  # @example Basic usage
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   puts Monitor.count
  #   # => 2
  #
  # @return [Integer]
  # @raise [Window::NotReadyError] If called before opening the Window
  def self.count
    # mrb_Monitor_count
    # src/mruby_integration/models/monitor.cpp
    2
  end

  # Returns the {Monitor} that the {Window} is currently on.
  #
  # @example Basic usage
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   puts Monitor.current
  #   # => 0
  #
  # @return [Monitor]
  # @raise [Window::NotReadyError] If called before opening the Window
  def self.current
    # mrb_Monitor_current
    # src/mruby_integration/models/monitor.cpp
    Monitor[0]
  end

  # Do not use this method directly, instead use {Monitor.[]}
  #
  # @param id [Integer]
  # @return [Monitor]
  def initialize(id:)
    # mrb_Monitor_initialize
    # src/mruby_integration/models/monitor.cpp
  end

  # Returns the position of the {Monitor} as a {Vector2}.
  #
  # @example Basic usage
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   puts Monitor.current.position
  #   # => #<Vector2:0x558eed361650 x:0.0 y:0.0>
  #
  # @return [Vector2]
  # @raise [Window::NotReadyError] If called before opening the Window
  def position
    # mrb_Monitor_position
    # src/mruby_integration/models/monitor.cpp
    Vector2[0, 0]
  end

  # Returns the width of the {Monitor} in pixels.
  #
  # @example Basic usage
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   puts Monitor.current.width
  #   # => 1920
  #
  # @return [Integer]
  # @raise [Window::NotReadyError] If called before opening the Window
  def width
    # mrb_Monitor_width
    # src/mruby_integration/models/monitor.cpp
    1920
  end

  # Returns the height of the {Monitor} in pixels.
  #
  # @example Basic usage
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   puts Monitor.current.height
  #   # => 1080
  #
  # @return [Integer]
  # @raise [Window::NotReadyError] If called before opening the Window
  def height
    # mrb_Monitor_height
    # src/mruby_integration/models/monitor.cpp
    1080
  end

  # Returns the refresh rate of the {Monitor}.
  #
  # @example Basic usage
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   puts Monitor.current.refresh_rate
  #   # => 60
  #
  # @return [Integer]
  # @raise [Window::NotReadyError] If called before opening the Window
  def refresh_rate
    # mrb_Monitor_refresh_rate
    # src/mruby_integration/models/monitor.cpp
    60
  end

  # Returns the name of the {Monitor}.
  #
  # @example Basic usage
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   puts Monitor.current.name
  #   # => DisplayPort-2
  #
  # @return [String]
  # @raise [Window::NotReadyError] If called before opening the Window
  def name
    # mrb_Monitor_name
    # src/mruby_integration/models/monitor.cpp
    "DisplayPort-2"
  end
end
