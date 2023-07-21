# A class used to hold an x and y value, will be translated when viewed through
# a Camera2D object.
class Vector2
  # @return [Float]
  attr_reader :x, :y

  # The equality operator is used for checking if two Vector2s share the same
  # position.
  # @param other [Vector2]
  # @return [Boolean]
  def ==(other)
    self.x == other.x &&
      self.y == other.y
  end

  # The addition operator is used for adding up two Vector2s
  # @param other [Vector2]
  # @return [Vector2]
  def +(other)
    Vector2.new(
      self.x + other.x,
      self.y + other.y
    )
  end

  # The addition operator is used for subtracting two Vector2s
  # @param other [Vector2]
  # @return [Vector2]
  def -(other)
    Vector2.new(
      self.x - other.x,
      self.y - other.y
    )
  end

  alias :difference :-

  # Change the length of the Vector2
  # @param scalar [Numeric]
  # @return [Vector2]
  def scale(scalar)
    Vector2.new(
      self.x * scalar,
      self.y * scalar
    )
  end

  # Calculates the length of the Vector2
  # @return [Numeric]
  def length
    Math.sqrt(x**2 + y**2)
  end

  # Return the object represented by a Hash
  # @return [Hash]
  def to_h
    {
      x: x,
      y: y,
    }
  end

  # A Vector2 setup at 0, 0
  ZERO = Vector2.new(0, 0)
end
