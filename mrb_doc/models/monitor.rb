class Monitor
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
  # @params id [Integer]
  # @return [Monitor]
  def initialize(id:)
    # mrb_Monitor_count
    # src/mruby_integration/models/monitor.cpp
    Monitor[0]
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
end
