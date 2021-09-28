# The Rectangle class is used for drawing and also collision checking.
class Rectangle
  # @return [Integer]
  attr_reader :x, :y, :width, :height

  # Creates a new instance of Rectangle
  # @param x [Integer]
  # @param y [Integer]
  # @param width [Integer]
  # @param height [Integer]
  # @return [Rectangle]
  def initialize(x, y, width, height)
    # mrb_Rectangle_initialize
    # src/mruby_integration/models/rectangle.cpp
    Rectangle.new
  end

  def x=(x)
    # mrb_Rectangle_set_x
    # src/mruby_integration/models/rectangle.cpp
    0
  end

  def y=(y)
    # mrb_Rectangle_set_y
    # src/mruby_integration/models/rectangle.cpp
    0
  end

  def width=(width)
    # mrb_Rectangle_set_width
    # src/mruby_integration/models/rectangle.cpp
    10
  end

  def height=(height)
    # mrb_Rectangle_set_height
    # src/mruby_integration/models/rectangle.cpp
    10
  end

  # Return the object represented by a Hash
  # @return [Hash]
  def to_h
    # src/mruby_integration/models/rectangle.cpp
    {
      x: x,
      y: y,
      width: width,
      height: height,
    }
  end

  # Draws a rectangle in several configurations
  # @param origin [Vector2]
  # @param rotation [Float] only usable when outline and rounded are false
  # @param outline [Boolean]
  # @param thickness [Integer] only used when outline is true
  # @param rounded [Boolean]
  # @param radius [Float] A value between 0.0 and 1.0 and only used when rounded is true
  # @raise [ArgumentError] If the radius is out of bounds
  # @return [Rectangle]
  def draw(
    origin: Vector2::ZERO,
    rotation: 0,
    outline: false,
    thickness: 2,
    rounded: false,
    radius: 5,
    segments: 8,
    colour: BLACK
  )
    # src/mruby_integration/models/rectangle.cpp
  end
end
