class Vector2
  # @return [Float]
  attr_accessor :x, :y

  # Creates a new instance of {Vector2}.
  #
  # @example Basic usage
  #   position = Vector2.new(x: 16, y: 32)
  #
  # @param x [Float]
  # @param y [Float]
  # @return [Vector2]
  def initialize(x, y)
    # mrb_Vector2_initialize
    # src/mruby_integration/models/vector2.cpp
    Vector2.new
  end

  # Sets the corresponding pixel to the passed in {Colour}.
  #
  # @example Basic usage
  #   pixel = Vector2.new(x: 16, y: 32)
  #   pixel.draw
  #
  # @return [nil]
  def draw
    # mrb_Vector2_draw
    # src/mruby_integration/models/vector2.cpp
    nil
  end
end
