class Vector2
  attr_reader :x, :y

  def ==(other)
    self.x == other.x &&
      self.y == other.y
  end

  def +(other)
    Vector2.new(
      self.x + other.x,
      self.y + other.y
    )
  end

  def -(other)
    Vector2.new(
      self.x - other.x,
      self.y - other.y
    )
  end

  alias :difference :-

  def scale(scalar)
    Vector2.new(
      self.x * scalar,
      self.y * scalar
    )
  end

  def length
    Math.sqrt(x**2 + y**2)
  end

  def to_h
    {
      x: x,
      y: y,
    }
  end

  ZERO = Vector2.new(0, 0)
end
