# The class for dealing with {Touch} on phones, tablets, and computers with touch screens.
class Touch
  # How many touches should we consider before it's more likely we've got a bug.
  MAX_TOUCH_POINTS = 20

  # Returns the {Touch} position for that index.
  #
  # @example Basic usage
  #   puts Touch[0]
  #   # => Vector2[123, 345]
  #
  # @return [Vector2]
  def self.[](index)
    position_for(index)
  end

  # Returns all the current {Touch} positions as an {Array} of {Vector2}.
  #
  # @example Basic usage
  #   Touch.positions.each do |position|
  #     Circle.draw(position: position, radius: 10, colour: Colour::PURPLE)
  #   end
  #
  # @return [Array<Vector2>]
  # @raise [Touch::TooManyTouchesError] If there are too many points returned,
  #   it's more likely a bug than legitimate results.
  def self.positions
    touches = []

    (0..MAX_TOUCH_POINTS).each do |index|
      touch = position_for(index)

      break if touch == Vector2[0, 0]
      if index == MAX_TOUCH_POINTS
        raise TooManyTouchesError, "We received more than the expected limit of touches, is your input device having an issue?"
      end

      touches << touch
    end

    touches
  end

  # Thrown when we exceed `Touch::MAX_TOUCH_POINTS`, you can just bump
  # `Touch::MAX_TOUCH_POINTS` if you genuinely need more. If you actually do
  # take over 20 touches, please let me (Sean) know what you're working on, that
  # sounds fascinating!
  class TooManyTouchesError < StandardError; end
end
