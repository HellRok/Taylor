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

  # Do not use this method directly, instead use {Monitor.[]}
  #
  # @params id [Integer]
  # @return [Monitor]
  def initialize(id:)
    # mrb_Monitor_count
    # src/mruby_integration/models/monitor.cpp
    2
  end
end
