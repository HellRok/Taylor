# Sets the monitor for the current window.
# @param monitor [Integer]
# @return [nil]
def set_window_monitor(monitor)
  # mrb_set_window_monitor
  # src/mruby_integration/core/window.cpp
  nil
end

# Gets the position of the specified monitor.
# @param monitor [Integer]
# @return [Vector2]
def get_monitor_position(monitor)
  # mrb_get_monitor_position
  # src/mruby_integration/core/window.cpp
  Vector2.new(0, 0)
end

# Gets the width of the specified monitor.
# @param monitor [Integer]
# @return [Integer]
def get_monitor_width(monitor)
  # mrb_get_monitor_width
  # src/mruby_integration/core/window.cpp
  1920
end

# Gets the height of the specified monitor.
# @param monitor [Integer]
# @return [Integer]
def get_monitor_height(monitor)
  # mrb_get_monitor_height
  # src/mruby_integration/core/window.cpp
  1080
end

# Gets the refresh rate of the specified monitor.
# @param monitor [Integer]
# @return [Integer]
def get_monitor_refresh_rate(monitor)
  # mrb_get_monitor_refresh_rate
  # src/mruby_integration/core/window.cpp
  60
end

# Gets the scale of the window.
# @return [Vector2]
def get_window_scale_dpi
  # mrb_get_window_scale_dpi
  # src/mruby_integration/core/window.cpp
  Vector2.new(1, 1)
end
