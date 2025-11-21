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

  # Scissors within the {Rectangle}, only drawing that happens within the
  # bounds of the {Rectangle} will actually be drawn to the screen.
  #
  # @example Basic usage
  #   portal = Rectangle.new(x: 100, y: 100, width: 50, height: 75, colour: Colour::BLUE)
  #   portal.scissor do
  #     # Drawing code here
  #   end
  #
  # @return [nil]
  def scissor(&block)
    begin_scissoring
    block.call
  ensure
    end_scissoring
  end

  # Returns `true` if the {Vector2} is contained inside this {Rectangle} or is
  # on the border of.
  #
  # @example Basic usage
  #   hitbox = Rectangle.new(x: 10, y: 10, width: 10, height: 10)
  #   position = Vector2.new(x: 5, y: 5)
  #
  #   puts hitbox.overlaps?(position)
  #   # => false
  #
  #   # The position changes to inside the rectangle...
  #   position = Vector2.new(x: 15, y: 15)
  #
  #   puts hitbox.overlaps?(position)
  #   # => true
  #
  #   # The position changes to the corner of the rectangle...
  #   position = Vector2.new(x: 10, y: 10)
  #
  #   puts hitbox.overlaps?(position)
  #   # => true
  #
  #   # The position changes to far outside rectangle...
  #   position = Vector2.new(x: 100, y: 100)
  #
  #   puts hitbox.overlaps?(position)
  #   # => false
  #
  # @param other [Vector2]
  # @return [Boolean]
  # @raise [ArgumentError] If passed anything other than a Vector2
  def overlaps?(other)
    raise ArgumentError, "Must pass in a Vector2" unless other.is_a?(Vector2)

    other.x.between?(x, x + width) && other.y.between?(y, y + height)
  end
end
