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
end
