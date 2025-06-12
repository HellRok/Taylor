# The {Circle} class is used for drawing circles.
class Circle
  # @return [Colour]
  attr_reader :colour, :outline, :gradient

  # Return the {Circle} represented as a Hash
  #
  # @example Basic usage
  #   circle = Circle.new(x: 50, y: 60, radius: 10, colour: Colour[128, 0, 255, 255])
  #
  #   p circle.to_h
  #   # => {
  #   #      x: 50,
  #   #      y: 60,
  #   #      radius: 10,
  #   #      colour: {
  #   #        red: 128,
  #   #        green: 0,
  #   #        blue: 255,
  #   #        alpha: 255,
  #   #      },
  #   #      outline: nil,
  #   #      thickness: 1,
  #   #      gradient: nil,
  #   #    }
  #
  # @return [Hash]
  def to_h
    {
      x: x,
      y: y,
      radius: radius,
      colour: colour&.to_h,
      thickness: thickness,
      outline: outline&.to_h,
      gradient: gradient&.to_h
    }
  end
end
