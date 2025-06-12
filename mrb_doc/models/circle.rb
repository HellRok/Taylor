class Circle
  # @return [Float]
  attr_accessor :x, :y, :radius, :thickness

  # @return [Colour]
  attr_writer :colour, :outline, :gradient

  # Creates a new instance of {Circle}.
  #
  # If `outline` is specified then the circle will be drawn with an outline of
  # that {Colour}. You can specify the `thickness` to make it thicker.
  #
  # if `gradient` is specified then the circle will be drawn with a gradient
  # between `colour` and `gradient`.
  #
  # @example Basic usage
  #   circle = Circle.new(x: 100, y: 100, radius: 5, colour:Colour::RED)
  #
  # @param x [Float]
  # @param y [Float]
  # @param radius [Float]
  # @param colour [Colour]
  # @param outline [Colour]
  # @param thickness [Float]
  # @param gradient [Colour]
  # @return [Circle]
  def initialize(x:, y:, radius:, colour:, outline: nil, thickness: 1, gradient: nil)
    # mrb_Circle_initialize
    # src/mruby_integration/models/circle.cpp
    Circle.new
  end
end
