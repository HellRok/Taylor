# Unknown gamepad button
GAMEPAD_BUTTON_UNKNOWN = 0

# Dpad up
GAMEPAD_BUTTON_LEFT_FACE_UP = 1
# Dpad right
GAMEPAD_BUTTON_LEFT_FACE_RIGHT = 2
# Dpad down
GAMEPAD_BUTTON_LEFT_FACE_DOWN = 3
# Dpad left
GAMEPAD_BUTTON_LEFT_FACE_LEFT = 4

# XBOX: Y
# PS3: Triangle
GAMEPAD_BUTTON_RIGHT_FACE_UP = 5
# XBOX: X
# PS3: Square
GAMEPAD_BUTTON_RIGHT_FACE_RIGHT = 6
# XBOX: A
# PS3: Cross
GAMEPAD_BUTTON_RIGHT_FACE_DOWN = 7
# XBOX: B
# PS3: Circle
GAMEPAD_BUTTON_RIGHT_FACE_LEFT = 8

# Left trigger 1
GAMEPAD_BUTTON_LEFT_TRIGGER_1 = 9
# Left trigger 2
GAMEPAD_BUTTON_LEFT_TRIGGER_2 = 10
# Right trigger 1
GAMEPAD_BUTTON_RIGHT_TRIGGER_1 = 11
# Right trigger 2
GAMEPAD_BUTTON_RIGHT_TRIGGER_2 = 12

# PS3: Select
GAMEPAD_BUTTON_MIDDLE_LEFT = 13
# Ps Button/XBOX Button
GAMEPAD_BUTTON_MIDDLE = 14
# PS3: Start
GAMEPAD_BUTTON_MIDDLE_RIGHT = 15

# Left thumbstick pressed
GAMEPAD_BUTTON_LEFT_THUMB = 16
# Right thumbstick pressed
GAMEPAD_BUTTON_RIGHT_THUM = 17

# Left thumbstick axis X
GAMEPAD_AXIS_LEFT_X = 0
# Left thumbstick axis Y
GAMEPAD_AXIS_LEFT_Y = 1

# Right thumbstick axis X
GAMEPAD_AXIS_RIGHT_X = 2
# Right thumbstick axis Y
GAMEPAD_AXIS_RIGHT_Y = 3

# Pressure level for left trigger [1..-1] (pressure-level)
GAMEPAD_AXIS_LEFT_TRIGGER = 4
# Pressure level for right trigger [1..-1] (pressure-level)
GAMEPAD_AXIS_RIGHT_TRIGGER = 5

# Return whether or not the specified gamepad is available
# @param index [Integer]
# @return [Bool]
def is_gamepad_available?(index)
  # mrb_is_gamepad_available
  # src/mruby_integration/core/input/gamepad.cpp
  true
end

# Returns the specified gamepads name
# @param index [Integer]
# @return [String]
def get_gamepad_name(index)
  # mrb_get_gamepad_name
  # src/mruby_integration/core/input/gamepad.cpp
  'Xbox Controller'
end

# Is the specified button down on the specific gamepad?
# @param index [Integer]
# @param button [Integer]
# @return [Boolean]
def is_gamepad_button_down?(index, button)
  # mrb_is_gamepad_button_down
  # src/mruby_integration/core/input/gamepad.cpp
  True
end

# Returns the last pressed gamepad button
# @return [Integer]
def get_gamepad_button_pressed()
  # mrb_get_gamepad_button_pressed
  # src/mruby_integration/core/input/gamepad.cpp
  0
end

# Returns the count of axis for the specified gamepad
# @param index [Integer]
# @return [Integer]
def get_gamepad_axis_count(index)
  # mrb_get_gamepad_axis_count
  # src/mruby_integration/core/input/gamepad.cpp
  2
end

# Returns the movement of the specified axis for the specified gamepad
# @param index [Integer]
# @param axis [Integer]
# @return [Float] -1.0 to 1.0
def get_gamepad_axis_movement(index, axis)
  # mrb_get_gamepad_axis_movement
  # src/mruby_integration/core/input/gamepad.cpp
  0.5
end
