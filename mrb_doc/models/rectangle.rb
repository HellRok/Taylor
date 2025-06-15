class Rectangle
  # @return [Float]
  attr_accessor :x, :y, :width, :height, :thickness, :roundness

  # @return [Integer]
  attr_accessor :segments

  # @return [Colour]
  attr_writer :colour, :outline

  # Creates a new instance of {Rectangle}.
  #
  # @example Basic usage
  #   rectangle = Rectangle.new(x: 10, y: 20, width: 32, height: 32, colour: Colour::GREEN)
  #
  # @param x [Float]
  # @param y [Float]
  # @param width [Float]
  # @param height [Float]
  # @param colour [Colour]
  # @param outline [Colour]
  # @param thickness [Float] Must be greater than 0
  # @param roundness [Float] Must be within (0.0..1.0)
  # @param segments [Integer] Must be greater than 0
  # @return [Rectangle]
  # @raise [ArgumentError]
  def initialize(x:, y:, width:, height:, colour:, outline: nil, thickness: 1, roundness: 0, segments: 4)
    # mrb_Rectangle_initialize
    # src/mruby_integration/models/rectangle.cpp
    Rectangle.new
  end

  # Draws the {Rectangle}.
  #
  # If `outline` is specified then the rectangle will be drawn with an outline of
  # that {Colour}. You can specify the `thickness` to make it thicker.
  #
  # if `roundness` is specified then the rectangle will be drawn with rounded corners.
  #
  # @example Basic usage
  #   rectangle = Rectangle.new(x: 100, y: 100, width: 50, height: 60, colour:Colour::RED)
  #   rectangle.draw
  #
  #   rectangle_with_roundness = Rectangle.new(x: 100, y: 100, width: 50, height: 60,, colour:Colour::RED, roundness: 0.25)
  #   rectangle_with_roundness.draw
  #
  #   rectangle_with_outline = Rectangle.new(x: 100, y: 100, width: 50, height: 60, colour:Colour::RED, outline: Colour::BLUE, thickness: 3)
  #   rectangle_with_outline.draw
  #
  #   rectangle_with_roundness_and_outline = Rectangle.new(x: 100, y: 100, width: 50, height: 60, colour:Colour::RED, roundness: 0.5, outline: Colour::BLUE, thickness: 3)
  #   rectangle_with_roundness_and_outline.draw
  #
  # @return [nil]
  def draw
    # mrb_Rectangle_draw
    # src/mruby_integration/models/rectangle.cpp
    nil
  end
end
