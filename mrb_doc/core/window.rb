# Sets the monitor for the current window.
# @param monitor [Integer]
# @return [nil]
def set_window_monitor(monitor)
  # mrb_set_window_monitor
  # src/mruby_integration/core/window.cpp
  nil
end

# Gets the scale of the window.
# @return [Vector2]
def get_window_scale_dpi
  # mrb_get_window_scale_dpi
  # src/mruby_integration/core/window.cpp
  Vector2.new(1, 1)
end
