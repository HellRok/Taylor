# The {Circle} class is used for drawing circles.
class Circle
  # @return [Colour]
  attr_reader :colour, :outline, :gradient

  # A short form way to create new {Circle} objects.
  #
  # @example Basic usage
  #   circle = Circle[120, 200, 50, Colour::GREEN]
  #
  # @param x [Float]
  # @param y [Float]
  # @param radius [Float]
  # @param colour [Colour]
  # @return [Circle]
  def self.[](x, y, radius, colour = Colour::BLACK)
    new(x: x, y: y, radius: radius, colour: colour)
  end

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

  # Returns `true` if the {Vector2} is contained inside this {Circle} or is
  # on the border of.
  #
  # @example Basic usage
  #   hitbox = Circle.new(x: 10, y: 10, radius: 10)
  #   position = Vector2.new(x: 0, y: 0)
  #
  #   puts hitbox.overlaps?(position)
  #   # => false
  #
  #   # The position changes to inside the circle...
  #   position = Vector2.new(x: 15, y: 15)
  #
  #   puts hitbox.overlaps?(position)
  #   # => true
  #
  #   # The position changes to the edge of the circle...
  #   position = Vector2.new(x: 0, y: 10)
  #
  #   puts hitbox.overlaps?(position)
  #   # => true
  #
  #   # The position changes to far outside circle...
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

    x_distance = x - other.x
    y_distance = y - other.y

    distance = Math.sqrt((x_distance**2) + (y_distance**2))

    distance <= radius
  end
end
