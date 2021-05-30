# Set to try enabling V-Sync on GPU
FLAG_VSYNC_HINT         = 0x00000040
# Set to run program in fullscreen
FLAG_FULLSCREEN_MODE    = 0x00000002
# Set to allow resizable window
FLAG_WINDOW_RESIZABLE   = 0x00000004
# Set to disable window decoration (frame and buttons)
FLAG_WINDOW_UNDECORATED = 0x00000008
# Set to hide window
FLAG_WINDOW_HIDDEN      = 0x00000080
# Set to minimize window (iconify)
FLAG_WINDOW_MINIMISED   = 0x00000200
# Set to maximize window (expanded to monitor)
FLAG_WINDOW_MAXIMISED   = 0x00000400
# Set to window non focused
FLAG_WINDOW_UNFOCUSED   = 0x00000800
# Set to window always on top
FLAG_WINDOW_TOPMOST     = 0x00001000
# Set to allow windows running while minimized
FLAG_WINDOW_ALWAYS_RUN  = 0x00000100
# Set to allow transparent framebuffer
FLAG_WINDOW_TRANSPARENT = 0x00000010
# Set to support HighDPI
FLAG_WINDOW_HIGHDPI     = 0x00002000
# Set to try enabling MSAA 4X
FLAG_MSAA_4X_HINT       = 0x00000020
# Set to try enabling interlaced video format (for V3D)
FLAG_INTERLACED_HINT    = 0x00010000

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
def window_should_close?()
  # mrb_window_should_close
  # src/mruby_integration/core/window.cpp
  false
end

# Close the open window
# @return [nil]
def close_window()
  # mrb_close_window
  # src/mruby_integration/core/window.cpp
  nil
end

# Has the window been initialised and ready for rendering?
# @return [Boolean]
def is_window_ready?()
  # mrb_is_window_ready
  # src/mruby_integration/core/window.cpp
  true
end

# Checks if the window has the state set, to pass in multiple you can do so like:
#   `is_window_state?(FLAG_WINDOW_ALWAYS_RUN | FLAG_WINDOW_HIDDEN)`
# @param flags [Integer]
# @return [Boolean]
def is_window_state?(flags)
  # mrb_is_window_state
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
def is_window_fullscreen?()
  # mrb_is_window_fullscreen
  # src/mruby_integration/core/window.cpp
  true
end

# Checks if the window has the FLAG_WINDOW_HIDDEN state set
# @return [Boolean]
def is_window_hidden?()
  # mrb_is_window_hidden
  # src/mruby_integration/core/window.cpp
  false
end

# Checks if the window has the FLAG_WINDOW_MINIMISED state set
# @return [Boolean]
def is_window_minimised?()
  # mrb_is_window_minimised
  # src/mruby_integration/core/window.cpp
  false
end

# Checks if the window has the FLAG_WINDOW_MAXIMISED state set
# @return [Boolean]
def is_window_maximised?()
  # mrb_is_window_maximised
  # src/mruby_integration/core/window.cpp
  true
end

# Checks if the window has focus
# @return [Boolean]
def is_window_focused?()
  # mrb_is_window_focused
  # src/mruby_integration/core/window.cpp
  true
end

# Checks if the window was resized since the last frame
# @return [Boolean]
def is_window_resized?()
  # mrb_is_window_resized
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
def toggle_fullscreen()
  # mrb_toggle_fullscreen
  # src/mruby_integration/core/window.cpp
  nil
end

# Maximises the window
# @return [nil]
def maximise_window()
  # mrb_maximise_window
  # src/mruby_integration/core/window.cpp
  nil
end

# Minimises the window
# @return [nil]
def minimise_window()
  # mrb_minimise_window
  # src/mruby_integration/core/window.cpp
  nil
end

# Restores the window from being maximised or minimised
# @note I don't think it currently works for restoring from minimised
# @return [nil]
def restore_window()
  # mrb_restore_window
  # src/mruby_integration/core/window.cpp
  nil
end

# Sets the icon for the current window
# @param image [Image]
# @return [nil]
def set_window_icon()
  # mrb_set_window_icon
  # src/mruby_integration/core/window.cpp
  nil
end

# Sets the titel for the current window
# @param title [String]
# @return [nil]
def set_window_title()
  # mrb_set_window_title
  # src/mruby_integration/core/window.cpp
  nil
end

# Gets the width of the window
# @return [Integer]
def get_screen_width()
  # mrb_get_screen_width
  # src/mruby_integration/core/window.cpp
  640
end

# Gets the height of the window
# @return [Integer]
def get_screen_height()
  # mrb_get_screen_height
  # src/mruby_integration/core/window.cpp
  480
end

# Gets the total number of monitors the user has
# @return [Integer]
def get_monitor_count()
  # mrb_get_monitor_count
  # src/mruby_integration/core/window.cpp
  2
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

# Gets the id of the current monitor
# @return [Integer]
def get_current_monitor()
  # mrb_get_current_monitor
  # src/mruby_integration/core/window.cpp
  0
end
