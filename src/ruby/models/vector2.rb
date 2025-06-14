# A class used to hold an x and y value, will be translated when viewed through
# a {Camera2D} object.
#
# @example Basic usage
#   delta = 1 / 60.0 # Assume 60 frames per second
#   player_position = Vector2[7, 8]
#   player_velocity = Vector2[2, 2]
#
#   player_position += player_velocity * delta
#
#   puts player_position.x # => 7.0333...
#   puts player_position.y # => 8.0333...
class Vector2
  alias_method :width, :x
  alias_method :height, :y

  # A short form way to create new {Vector2} objects.
  #
  # @example Basic usage
  #   position = Vector2[10, 12]
  #
  #   puts position.x # => 10
  #   puts position.y # => 12
  #
  # @param x [Float]
  # @param y [Float]
  # @return [Vector2]
  def self.[](x, y)
    new(x, y)
  end

  # The equality operator is used for checking if two {Vector2} objects share
  # the same position.
  #
  # @example Basic usage
  #   puts Vector2[3, 4] == Vector2[3, 4] # => true
  #
  #   puts Vector2[3, 4] == Vector2[4, 3] # => false
  #
  # @param other [Vector2]
  # @return [Boolean]
  def ==(other)
    return super unless other.is_a?(Vector2)

    x == other.x &&
      y == other.y
  end

  # The addition operator is used for adding up two {Vector2} objects.
  #
  # @example Basic usage
  #   vector_1 = Vector2[1, 2]
  #   vector_2 = Vector2[3, 4]
  #
  #   vector_both = vector_1 + vector_2
  #
  #   puts vector_both.x # => 4
  #   puts vector_both.y # => 6
  #
  # @param other [Vector2]
  # @return [Vector2]
  def +(other)
    Vector2.new(
      x + other.x,
      y + other.y
    )
  end

  # The subtraction operator is used for subtracting two {Vector2} objects.
  #
  # @example Basic usage
  #   vector_1 = Vector2[3, 4]
  #   vector_2 = Vector2[2, 1]
  #
  #   vector_both = vector_1 - vector_2
  #
  #   puts vector_both.x # => 1
  #   puts vector_both.y # => 3
  #
  # @param other [Vector2]
  # @return [Vector2]
  def -(other)
    Vector2.new(
      x - other.x,
      y - other.y
    )
  end

  alias_method :difference, :-

  # Scale the {Vector2} by the scalar.
  #
  # @example Basic usage
  #   vector = Vector2[2, 4]
  #   vector *= 3
  #
  #   puts vector.x # => 6
  #   puts vector.y # => 12
  #
  # @param other [Numeric]
  # @return [Vector2]
  def *(other)
    Vector2.new(
      x * other,
      y * other
    )
  end

  alias_method :scale, :*

  # Divide the {Vector2} by the value.
  #
  # @example Basic usage
  #   vector = Vector2[2, 3]
  #   vector /= 2
  #
  #   puts vector.x # => 1
  #   puts vector.y # => 1.5
  #
  # @param other [Numeric]
  # @return [Vector2]
  def /(other)
    Vector2.new(
      x / other,
      y / other
    )
  end

  # Calculates the length of the {Vector2}.
  #
  # @example Basic usage
  #   vector = Vector2[3, 4]
  #
  #   puts vector.length # => 5
  #
  # @return [Numeric]
  def length
    Math.sqrt(x**2 + y**2)
  end

  # Return the object represented by a Hash.
  #
  # @example Basic usage
  #   vector = Vector2[6, 8]
  #
  #   p vector.to_h
  #
  #   # => {
  #   #      x: 6,
  #   #      y: 8
  #   #    }
  #
  # @return [Hash]
  def to_h
    {
      x: x,
      y: y
    }
  end

  # Returns a string representation of the {Vector2} that's useful for debugging.
  #
  # @example Basic usage
  #   vector = Vector2[6, 8]
  #
  #   puts vector.inspect # => #<Vector2:0x102bd20 x:6.0 y:8.0>
  #
  #   p vector # => #<Vector2:0x102bd20 x:6.0 y:8.0>
  #
  # @return [String]
  def inspect
    "#<Vector2:0x#{object_id.to_s(16)} x:#{x} y:#{y}>"
  end

  # A method used to generate the mock data for Raylib.
  #
  # @example Basic usage
  #   Taylor::Raylib.mock_call(
  #     "GetMousePosition",
  #     Vector2.mock_return(x: 1, y: 2)
  #   )
  #
  # @param x [Float]
  # @param y [Float]
  # @return [String]
  def self.mock_return(x: 0, y: 0)
    [x, y].map(&:to_s).join(" ")
  end

  # A Vector2 setup at 0, 0.
  ZERO = Vector2.new(0, 0)
end
