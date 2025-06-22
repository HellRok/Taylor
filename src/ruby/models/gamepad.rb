# The {Gamepad} class is used for reading input from any attached gamepads/controllers.
class Gamepad
  # If there are more gamepads detected than this, we assume an error.
  MAX_GAMEPADS = 10

  # Returns the requested {Gamepad}.
  #
  # @example Basic usage
  #   player_one = Gamepad[0]
  #   puts player_one
  #   # => #<Gamepad:0x55bb73db1ca0>
  #
  # @return [Gamepad]
  # @raise [ArgumentError] If calling an unavailable gamepad index
  def self.[](index)
    count = Gamepad.all.count

    raise ArgumentError, "Must be an integer in (0..#{count - 1})" if index < 0 || index >= count

    new(index: index)
  end

  # Returns all {Gamepad} attached to the computer.
  #
  # @example Basic usage
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   p Gamepad.all
  #   # => [
  #   #      #<Gamepad:0x55855cacad70>,
  #   #      #<Gamepad:0x55855cacacb0>,
  #   #    ]
  #
  # @return [Array<Gamepad>]
  # @raise [Gamepad::TooManyGamepadsError] If more than {Gamepad::MAX_GAMEPADS} detected
  def self.all
    gamepads = []

    (0..MAX_GAMEPADS).each do |index|
      gamepad = Gamepad.new(index: index)
      break unless gamepad.available?

      if index == MAX_GAMEPADS
        raise TooManyGamepadsError, "We received more than the expected limit of gamepads, if you mean to have more than 10 set Gamepad::MAX_GAMEPADS higher"
      end

      gamepads << gamepad
    end

    gamepads
  end

  # Thrown when we exceed {Gamepad::MAX_GAMEPADS}, you can just bump
  # {Gamepad::MAX_GAMEPADS} if you genuinely need more.
  class TooManyGamepadsError < StandardError; end

  # The D-pad buttons
  module Dpad
    # The D-pad up button
    UP = 1
    # The D-pad right button
    RIGHT = 2
    # The D-pad down button
    DOWN = 3
    # The D-pad left button
    LEFT = 4
  end

  # The regular buttons
  module Button
    # Unknown gamepad button.
    UNKNOWN = 0
    # Nintendo: X
    # Xbox: Y
    # PS: Triangle
    UP = 5
    # Nintendo: A
    # Xbox: X
    # PS: Square
    RIGHT = 6
    # Nintendo: B
    # Xbox: A
    # PS: Cross
    DOWN = 7
    # Nintendo: Y
    # Xbox: B
    # PS: Circle
    LEFT = 8
    # Select
    MIDDLE_LEFT = 13
    # Normally a home button
    MIDDLE = 14
    # Start
    MIDDLE_RIGHT = 15
    # Left Joystick pressed
    LEFT_JOYSTICK = 16
    # Right Joystick pressed
    RIGHT_JOYSTICK = 17
  end

  # The triggers or shoulder buttons
  module Trigger
    # The front left trigger
    LEFT_1 = 9
    # The back left trigger
    LEFT_2 = 10
    # The front right trigger
    RIGHT_1 = 11
    # The back right trigger
    RIGHT_2 = 12
  end

  # The Joystick axis and trigger pressures
  module Axis
    # The left joystick horizontal axis
    LEFT_X = 0
    # The left joystick vertical axis
    LEFT_Y = 1
    # The right joystick horizontal axis
    RIGHT_X = 2
    # The right joystick vertical axis
    RIGHT_Y = 3
    # The left trigger pressure level
    LEFT_TRIGGER = 4
    # The right trigger pressure level
    RIGHT_TRIGGER = 5
  end
end
