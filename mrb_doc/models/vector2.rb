# A class used to hold an x and y value, will be translated when viewed through
# a Camera2D object.
class Vector2
  # @return [Float]
  attr_reader :x, :y

  # Creates a new instance of Vector2
  # @param x [Float]
  # @param y [Float]
  # @return [Vector2]
  def initialize(x, y)
    # mrb_Vector2_initialize
    # src/mruby_integration/models/vector2.cpp
    Vector2.new
  end

  def x=(x)
    # mrb_Vector2_set_x
    # src/mruby_integration/models/vector2.cpp
    1
  end

  def y=(y)
    # mrb_Vector2_set_y
    # src/mruby_integration/models/vector2.cpp
    1
  end

  # The equality operator is used for checking if two Vector2s share the same
  # position.
  # @param other [Vector2]
  # @return [Boolean]
  def ==(other)
    # src/mruby_integration/models/vector2.cpp
    self.x == other.x &&
      self.y == other.y
  end

  # The addition operator is used for adding up two Vector2s
  # @param other [Vector2]
  # @return [Vector2]
  def +(other)
    # src/mruby_integration/models/vector2.cpp
    Vector2.new(
      self.x + other.x,
      self.y + other.y
    )
  end

  # The addition operator is used for subtracting two Vector2s
  # @param other [Vector2]
  # @return [Vector2]
  def -(other)
    # src/mruby_integration/models/vector2.cpp
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
    # src/mruby_integration/models/vector2.cpp
    Vector2.new(
      self.x * scalar,
      self.y * scalar
    )
  end

  # Calculates the length of the Vector2
  # @return [Numeric]
  def length
    # src/mruby_integration/models/vector2.cpp
    Math.sqrt(x**2 + y**2)
  end

  # Return the object represented by a Hash
  # @return [Hash]
  def to_h
    # src/mruby_integration/models/vector2.cpp
    {
      x: x,
      y: y,
    }
  end

  # A Vector2 setup at 0, 0
  ZERO = Vector2.new(0, 0)
end
