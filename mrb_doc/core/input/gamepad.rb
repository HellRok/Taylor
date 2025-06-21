# Returns the specified gamepad's name.
# @param index [Integer]
# @return [String]
def get_gamepad_name(index)
  # mrb_get_gamepad_name
  # src/mruby_integration/core/input/gamepad.cpp
  "Xbox Controller"
end

# Has the specified button been pressed on the specific gamepad?
# @param index [Integer]
# @param button [Integer]
# @return [Boolean]
def gamepad_button_pressed?(index, button)
  # mrb_gamepad_button_pressed
  # src/mruby_integration/core/input/gamepad.cpp
  true
end

# Is the specified button down on the specific gamepad?
# @param index [Integer]
# @param button [Integer]
# @return [Boolean]
def gamepad_button_down?(index, button)
  # mrb_gamepad_button_down
  # src/mruby_integration/core/input/gamepad.cpp
  true
end

# Has the specified button been released on the specific gamepad?
# @param index [Integer]
# @param button [Integer]
# @return [Boolean]
def gamepad_button_released?(index, button)
  # mrb_gamepad_button_released
  # src/mruby_integration/core/input/gamepad.cpp
  false
end

# Is the specified button not being pressed on the specific gamepad?
# @param index [Integer]
# @param button [Integer]
# @return [Boolean]
def gamepad_button_up?(index, button)
  # mrb_gamepad_button_up
  # src/mruby_integration/core/input/gamepad.cpp
  true
end

# Returns the last pressed gamepad button.
# @return [Integer]
def get_gamepad_button_pressed
  # mrb_get_gamepad_button_pressed
  # src/mruby_integration/core/input/gamepad.cpp
  0
end

# Returns the count of axis for the specified gamepad.
# @param index [Integer]
# @return [Integer]
def get_gamepad_axis_count(index)
  # mrb_get_gamepad_axis_count
  # src/mruby_integration/core/input/gamepad.cpp
  2
end

# Returns the movement of the specified axis for the specified gamepad.
# @param index [Integer]
# @param axis [Integer]
# @return [Float] -1.0 to 1.0
def get_gamepad_axis_movement(index, axis)
  # mrb_get_gamepad_axis_movement
  # src/mruby_integration/core/input/gamepad.cpp
  0.5
end

# Setup gamepad mappings using the
# [SDL_GameControllerDB](https://github.com/gabomdq/SDL_GameControllerDB) format.
# @param mappings [String]
# @return [Integer]
def set_gamepad_mappings(mappings)
  # mrb_set_gamepad_mappings
  # src/mruby_integration/core/input/gamepad.cpp
  1
end
