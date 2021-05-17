# Left mouse button
MOUSE_LEFT_BUTTON = 0
# Right mouse button
MOUSE_RIGHT_BUTTON = 1
# Middle mouse button (scrollwheel)
MOUSE_MIDDLE_BUTTON = 2

# Is the specified mouse button pressed?
# @param button [Integer]
# @return [Boolean]
def is_mouse_button_pressed?(button)
  # mrb_is_mouse_button_pressed
  # src/mruby_integration/core/input/mouse.cpp
  True
end

# Is the specified mouse button down?
# @param button [Integer]
# @return [Boolean]
def is_mouse_button_down?(button)
  # mrb_is_mouse_button_down
  # src/mruby_integration/core/input/mouse.cpp
  True
end

# Returns the current mouse position in the window
# @return [Vector2]
def get_mouse_position()
  # mrb_get_mouse_position
  # src/mruby_integration/core/input/mouse.cpp
  Vector2.new
end

# Returns the movement of the mouse wheel since last frame
# @return [Float]
def get_mouse_wheel_move()
  # mrb_get_mouse_wheel_move
  # src/mruby_integration/core/input/mouse.cpp
  0.5
end
