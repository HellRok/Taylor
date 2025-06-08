# Returns the current mouse x position in the window.
# @return [Integer]
def get_mouse_x
  # mrb_get_mouse_x
  # src/mruby_integration/core/input/mouse.cpp
  64
end

# Returns the current mouse y position in the window.
# @return [Integer]
def get_mouse_y
  # mrb_get_mouse_y
  # src/mruby_integration/core/input/mouse.cpp
  64
end

# Returns the current mouse position in the window.
# @return [Vector2]
def get_mouse_position
  # mrb_get_mouse_position
  # src/mruby_integration/core/input/mouse.cpp
  Vector2.new
end

# Sets the position of the mouse.
# @param x [Integer]
# @param y [Integer]
# @return [nil]
def set_mouse_position(x, y)
  # mrb_set_mouse_position
  # src/mruby_integration/core/input/mouse.cpp
  nil
end

# Sets the offset for all mouse position functions.
# @param x [Integer]
# @param y [Integer]
# @return [nil]
def set_mouse_offset(x, y)
  # mrb_set_mouse_offset
  # src/mruby_integration/core/input/mouse.cpp
  nil
end

# Sets the scaling for all mouse position functions.
# @param x [Float]
# @param y [Float]
# @return [nil]
def set_mouse_scale(x, y)
  # mrb_set_mouse_scale
  # src/mruby_integration/core/input/mouse.cpp
  nil
end

# Returns the movement of the mouse wheel since last frame.
# @return [Float]
def get_mouse_wheel_move
  # mrb_get_mouse_wheel_move
  # src/mruby_integration/core/input/mouse.cpp
  0.5
end

# Sets the mouse cursor.
# @param cursor [Integer]
# @return [nil]
def set_mouse_cursor(cursor)
  # mrb_set_mouse_cursor
  # src/mruby_integration/core/input/mouse.cpp
  nil
end
