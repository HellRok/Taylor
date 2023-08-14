# Initialises a window for rendering
# @param width [Integer]
# @param height [Integer]
# @param title [String]
# @return [nil]
def init_window(width, height, title)
  # mrb_init_window
  # src/mruby_integration/core/window.cpp
  nil
end

# Has the user pressed ESC or the close button?
# @return [Boolean]
def window_should_close?
  # mrb_window_should_close
  # src/mruby_integration/core/window.cpp
  false
end

# Close the open window
# @return [nil]
def close_window
  # mrb_close_window
  # src/mruby_integration/core/window.cpp
  nil
end

# Has the window been initialised and ready for rendering?
# @return [Boolean]
def window_ready?
  # mrb_window_ready
  # src/mruby_integration/core/window.cpp
  true
end

# Checks if the window has the state set, to pass in multiple you can do so like:
#   `window_state?(FLAG_WINDOW_ALWAYS_RUN | FLAG_WINDOW_HIDDEN)`
# @param flags [Integer]
# @return [Boolean]
def window_state?(flags)
  # mrb_window_state
  # src/mruby_integration/core/window.cpp
  true
end

# Sets the specified states on the window, to pass in multiple you can do so like:
#   `set_window_state(FLAG_WINDOW_ALWAYS_RUN | FLAG_WINDOW_HIDDEN)`
# @param flags [Integer]
# @return [nil]
def set_window_state(flags)
  # mrb_clear_window_state
  # src/mruby_integration/core/window.cpp
  nil
end

# Checks if the window has the FLAG_FULLSCREEN_MODE state set
# @return [Boolean]
def window_fullscreen?
  # mrb_window_fullscreen
  # src/mruby_integration/core/window.cpp
  true
end

# Checks if the window has the FLAG_WINDOW_HIDDEN state set
# @return [Boolean]
def window_hidden?
  # mrb_window_hidden
  # src/mruby_integration/core/window.cpp
  false
end

# Checks if the window has the FLAG_WINDOW_MINIMISED state set
# @return [Boolean]
def window_minimised?
  # mrb_window_minimised
  # src/mruby_integration/core/window.cpp
  false
end

# Checks if the window has the FLAG_WINDOW_MAXIMISED state set
# @return [Boolean]
def window_maximised?
  # mrb_window_maximised
  # src/mruby_integration/core/window.cpp
  true
end

# Checks if the window has focus
# @return [Boolean]
def window_focused?
  # mrb_window_focused
  # src/mruby_integration/core/window.cpp
  true
end

# Checks if the window was resized since the last frame
# @return [Boolean]
def window_resized?
  # mrb_window_resized
  # src/mruby_integration/core/window.cpp
  false
end

# Clears the specified states on the window, to pass in multiple you can do so like:
#   `clear_window_state(FLAG_WINDOW_ALWAYS_RUN | FLAG_WINDOW_HIDDEN)`
# @param flags [Integer]
# @return [nil]
def clear_window_state(flags)
  # mrb_clear_window_state
  # src/mruby_integration/core/window.cpp
  nil
end

# Toggles the fullscreen state
# @return [nil]
def toggle_fullscreen
  # mrb_toggle_fullscreen
  # src/mruby_integration/core/window.cpp
  nil
end

# Maximises the window
# @return [nil]
def maximise_window
  # mrb_maximise_window
  # src/mruby_integration/core/window.cpp
  nil
end

# Minimises the window
# @return [nil]
def minimise_window
  # mrb_minimise_window
  # src/mruby_integration/core/window.cpp
  nil
end

# Restores the window from being maximised or minimised
# @note I don't think it currently works for restoring from minimised
# @return [nil]
def restore_window
  # mrb_restore_window
  # src/mruby_integration/core/window.cpp
  nil
end

# Sets the icon for the current window
# @param image [Image]
# @return [nil]
def set_window_icon(image)
  # mrb_set_window_icon
  # src/mruby_integration/core/window.cpp
  nil
end

# Sets the title for the current window
# @param title [String]
# @return [nil]
def set_window_title(title)
  # mrb_set_window_title
  # src/mruby_integration/core/window.cpp
  nil
end

# Sets the position for the current window
# @param x [Integer]
# @param y [Integer]
# @return [nil]
def set_window_position(x, y)
  # mrb_set_window_position
  # src/mruby_integration/core/window.cpp
  nil
end

# Sets the monitor for the current window
# @param monitor [Integer]
# @return [nil]
def set_window_monitor(monitor)
  # mrb_set_window_monitor
  # src/mruby_integration/core/window.cpp
  nil
end

# Sets the minimum allowed size for the current window
# @param width [Integer]
# @param height [Integer]
# @return [nil]
def set_window_min_size(width, height)
  # mrb_set_window_min_size
  # src/mruby_integration/core/window.cpp
  nil
end

# Sets the size for the current window
# @param width [Integer]
# @param height [Integer]
# @return [nil]
def set_window_size(width, height)
  # mrb_set_window_size
  # src/mruby_integration/core/window.cpp
  nil
end

# Gets the width of the window
# @return [Integer]
def get_screen_width
  # mrb_get_screen_width
  # src/mruby_integration/core/window.cpp
  640
end

# Gets the height of the window
# @return [Integer]
def get_screen_height
  # mrb_get_screen_height
  # src/mruby_integration/core/window.cpp
  480
end

# Gets the total number of monitors the user has
# @return [Integer]
def get_monitor_count
  # mrb_get_monitor_count
  # src/mruby_integration/core/window.cpp
  2
end

# Gets the id of the current monitor
# @return [Integer]
def get_current_monitor
  # mrb_get_current_monitor
  # src/mruby_integration/core/window.cpp
  0
end

# Gets the position of the specified monitor
# @param monitor [Integer]
# @return [Vector2]
def get_monitor_position(monitor)
  # mrb_get_monitor_position
  # src/mruby_integration/core/window.cpp
  Vector2.new(0, 0)
end

# Gets the width of the specified monitor
# @param monitor [Integer]
# @return [Integer]
def get_monitor_width(monitor)
  # mrb_get_monitor_width
  # src/mruby_integration/core/window.cpp
  1920
end

# Gets the height of the specified monitor
# @param monitor [Integer]
# @return [Integer]
def get_monitor_height(monitor)
  # mrb_get_monitor_height
  # src/mruby_integration/core/window.cpp
  1080
end

# Gets the refresh rate of the specified monitor
# @param monitor [Integer]
# @return [Integer]
def get_monitor_refresh_rate(monitor)
  # mrb_get_monitor_refresh_rate
  # src/mruby_integration/core/window.cpp
  60
end

# Gets the position of the window
# @return [Vector2]
def get_window_position
  # mrb_get_window_position
  # src/mruby_integration/core/window.cpp
  Vector2.new(10, 10)
end

# Gets the scale of the window
# @return [Vector2]
def get_window_scale_dpi
  # mrb_get_window_scale_dpi
  # src/mruby_integration/core/window.cpp
  Vector2.new(1, 1)
end
