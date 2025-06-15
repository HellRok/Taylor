# The {Rectangle} class is used for drawing.
class Rectangle
  # @return [Colour]
  attr_reader :colour, :outline

  # Shorthand for initializing a new {Rectangle}.
  #
  # @example Basic usage
  #   source = Rectangle[8, 16, 24, 32]
  #   p source.to_h
  #
  #   # => {
  #   #      x: 8,
  #   #      y: 16,
  #   #      width: 24,
  #   #      height: 32,
  #   #    }
  #
  # @param y [Float]
  # @param x [Float]
  # @param width [Float]
  # @param height [Float]
  # @param colour [Colour]
  # @return [Rectangle]
  def self.[](x, y, width, height, colour = Colour::BLACK)
    new(x: x, y: y, width: width, height: height, colour: colour)
  end

  # Return the {Rectangle} represented by a Hash.
  #
  # @example Basic usage
  #   rectangle = Rectangle.new(x: 50, y: 60, width: 32, height: 32, colour: Colour[128, 0, 255, 255])
  #
  #   p circle.to_h
  #   # => {
  #   #      x: 50,
  #   #      y: 60,
  #   #      width: 32,
  #   #      height: 32,
  #   #      colour: {
  #   #        red: 128,
  #   #        green: 0,
  #   #        blue: 255,
  #   #        alpha: 255,
  #   #      },
  #   #      outline: nil,
  #   #      thickness: 1,
  #   #      roundness: 0,
  #   #      segments: 6,
  #   #    }
  #
  # @return [Hash]
  def to_h
    {
      x: x,
      y: y,
      width: width,
      height: height,
      colour: colour.to_h,
      outline: outline.to_h,
      thickness: thickness,
      roundness: roundness,
      segments: segments
    }
  end
end
