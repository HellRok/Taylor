class Rectangle
  # @return [Integer]
  attr_writer :x, :y, :width, :height

  # Creates a new instance of {Rectangle}.
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
end
