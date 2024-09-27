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
