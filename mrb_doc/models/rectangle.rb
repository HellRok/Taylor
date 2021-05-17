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
end
