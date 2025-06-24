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
