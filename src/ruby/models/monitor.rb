# This class is used for retrieving information about the monitors attached to
# the computer.
class Monitor
  # @return [Integer]
  attr_reader :id

  # Returns the requested {Monitor}.
  #
  # @example Basic usage
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   puts Monitor[0]
  #   # => #<Monitor:0x55bb73db1ca0>
  #
  # @return [Monitor]
  # @raise [Window::NotReadyError] If called before opening the Window
  def self.[](id)
    raise Window::NotReadyError, "You must call Window.open before Monitor[]" unless Window.ready?

    monitor_count = Monitor.count

    raise ArgumentError, "Must be an integer in (0..#{monitor_count - 1})" if id < 0 || id >= monitor_count

    new(id: id)
  end

  # Returns all {Monitor} attached to the computer.
  #
  # @example Basic usage
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   p Monitor.all
  #   # => [
  #     #<Monitor:0x55bb73db1ca0>
  #   ]
  #
  # @return [Array<Monitor>]
  # @raise [Window::NotReadyError] If called before opening the Window
  def self.all
    raise Window::NotReadyError, "You must call Window.open before Monitor.all" unless Window.ready?

    (0..(Monitor.count - 1)).map { |id| new(id: id) }
  end

  # Returns the resolution of the {Monitor} as a {Vector2}.
  #
  # @example Basic usage
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   p Monitor.current.resolution
  #   # => #<Vector2:0x55bb73db1ca0 x:1920 y:1080>
  #
  # @return [Vector2]
  # @raise [Window::NotReadyError] If called before opening the Window
  def resolution
    raise Window::NotReadyError, "You must call Window.open before Monitor#resolution" unless Window.ready?

    Vector2[width, height]
  end
end
