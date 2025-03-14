# Checks if the window was resized since the last frame.
# @return [Boolean]
def window_resized?
  # mrb_window_resized
  # src/mruby_integration/core/window.cpp
  false
end

# Toggles the fullscreen state.
# @return [nil]
def toggle_fullscreen
  # mrb_toggle_fullscreen
  # src/mruby_integration/core/window.cpp
  nil
end

# Maximises the window.
# @return [nil]
def maximise_window
  # mrb_maximise_window
  # src/mruby_integration/core/window.cpp
  nil
end

# Minimises the window.
# @return [nil]
def minimise_window
  # mrb_minimise_window
  # src/mruby_integration/core/window.cpp
  nil
end

# Restores the window from being maximised or minimised.
# @note I don't think it currently works for restoring from minimised.
# @return [nil]
def restore_window
  # mrb_restore_window
  # src/mruby_integration/core/window.cpp
  nil
end

# Sets the icon for the current window.
# @param image [Image]
# @return [nil]
def set_window_icon(image)
  # mrb_set_window_icon
  # src/mruby_integration/core/window.cpp
  nil
end

# Sets the title for the current window.
# @param title [String]
# @return [nil]
def set_window_title(title)
  # mrb_set_window_title
  # src/mruby_integration/core/window.cpp
  nil
end

# Sets the position for the current window.
# @param x [Integer]
# @param y [Integer]
# @return [nil]
def set_window_position(x, y)
  # mrb_set_window_position
  # src/mruby_integration/core/window.cpp
  nil
end

# Sets the monitor for the current window.
# @param monitor [Integer]
# @return [nil]
def set_window_monitor(monitor)
  # mrb_set_window_monitor
  # src/mruby_integration/core/window.cpp
  nil
end

# Sets the minimum allowed size for the current window.
# @param width [Integer]
# @param height [Integer]
# @return [nil]
def set_window_min_size(width, height)
  # mrb_set_window_min_size
  # src/mruby_integration/core/window.cpp
  nil
end

# Sets the size for the current window.
# @param width [Integer]
# @param height [Integer]
# @return [nil]
def set_window_size(width, height)
  # mrb_set_window_size
  # src/mruby_integration/core/window.cpp
  nil
end

# Gets the total number of monitors the user has.
# @return [Integer]
def get_monitor_count
  # mrb_get_monitor_count
  # src/mruby_integration/core/window.cpp
  2
end

# Gets the id of the current monitor.
# @return [Integer]
def get_current_monitor
  # mrb_get_current_monitor
  # src/mruby_integration/core/window.cpp
  0
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

# Gets the position of the window.
# @return [Vector2]
def get_window_position
  # mrb_get_window_position
  # src/mruby_integration/core/window.cpp
  Vector2.new(10, 10)
end

# Gets the scale of the window.
# @return [Vector2]
def get_window_scale_dpi
  # mrb_get_window_scale_dpi
  # src/mruby_integration/core/window.cpp
  Vector2.new(1, 1)
end
