# Left mouse button
MOUSE_LEFT_BUTTON = 0
# Right mouse button
MOUSE_RIGHT_BUTTON = 1
# Middle mouse button (scrollwheel)
MOUSE_MIDDLE_BUTTON = 2

# Mouse cursor default
MOUSE_CURSOR_DEFAULT       = 0
# Mouse cursor arrow
MOUSE_CURSOR_ARROW         = 1
# Mouse cursor ibeam
MOUSE_CURSOR_IBEAM         = 2
# Mouse cursor crosshair
MOUSE_CURSOR_CROSSHAIR     = 3
# Mouse cursor pointing_hand
MOUSE_CURSOR_POINTING_HAND = 4
# Mouse cursor horizontal resize/move
MOUSE_CURSOR_RESIZE_EW     = 5
# Mouse cursor vertical resize/move
MOUSE_CURSOR_RESIZE_NS     = 6
# Mouse cursor top-left to bottom-right diagonal resize/move
MOUSE_CURSOR_RESIZE_NWSE   = 7
# Mouse cursor top-right to bottom-left diagonal resize/move
MOUSE_CURSOR_RESIZE_NESW   = 8
# Mouse cursor omni-directional resize/move
MOUSE_CURSOR_RESIZE_ALL    = 9
# Mouse cursor not allowed
MOUSE_CURSOR_NOT_ALLOWED   = 10

# Is the specified mouse button pressed?
# @param button [Integer]
# @return [Boolean]
def is_mouse_button_pressed?(button)
  # mrb_is_mouse_button_pressed
  # src/mruby_integration/core/input/mouse.cpp
  true
end

# Is the specified mouse button down?
# @param button [Integer]
# @return [Boolean]
def is_mouse_button_down?(button)
  # mrb_is_mouse_button_down
  # src/mruby_integration/core/input/mouse.cpp
  true
end

# Has the specified mouse button been released?
# @param button [Integer]
# @return [Boolean]
def is_mouse_button_released?(button)
  # mrb_is_mouse_button_released
  # src/mruby_integration/core/input/mouse.cpp
  false
end

# Is the specified mouse button not down?
# @param button [Integer]
# @return [Boolean]
def is_mouse_button_up?(button)
  # mrb_is_mouse_button_up
  # src/mruby_integration/core/input/mouse.cpp
  false
end

# Returns the current mouse x position in the window
# @return [Integer]
def get_mouse_x()
  # mrb_get_mouse_x
  # src/mruby_integration/core/input/mouse.cpp
  64
end

# Returns the current mouse y position in the window
# @return [Integer]
def get_mouse_y()
  # mrb_get_mouse_y
  # src/mruby_integration/core/input/mouse.cpp
  64
end

# Returns the current mouse position in the window
# @return [Vector2]
def get_mouse_position()
  # mrb_get_mouse_position
  # src/mruby_integration/core/input/mouse.cpp
  Vector2.new
end

# Sets the position of the muose
# @param x [Integer]
# @param y [Integer]
# @return [nil]
def set_mouse_position(x, y)
  # mrb_set_mouse_position
  # src/mruby_integration/core/input/mouse.cpp
  nil
end

# Sets the offset for all mouse position functions
# @param x [Integer]
# @param y [Integer]
# @return [nil]
def set_mouse_offset(x, y)
  # mrb_set_mouse_offset
  # src/mruby_integration/core/input/mouse.cpp
  nil
end

# Sets the scaling for all mouse position functions
# @param x [Float]
# @param y [Float]
# @return [nil]
def set_mouse_scale(x, y)
  # mrb_set_mouse_scale
  # src/mruby_integration/core/input/mouse.cpp
  nil
end

# Returns the movement of the mouse wheel since last frame
# @return [Float]
def get_mouse_wheel_move()
  # mrb_get_mouse_wheel_move
  # src/mruby_integration/core/input/mouse.cpp
  0.5
end

# Sets the mouse cursor
# @param cursor [Integer]
# @return [nil]
def set_mouse_cursor(cursor)
  # mrb_set_mouse_cursor
  # src/mruby_integration/core/input/mouse.cpp
  nil
end
