class Vector2
  # @return [Float]
  attr_accessor :x, :y

  # Creates a new instance of {Vector2}.
  # @param x [Float]
  # @param y [Float]
  # @return [Vector2]
  def initialize(x, y)
    # mrb_Vector2_initialize
    # src/mruby_integration/models/vector2.cpp
    Vector2.new
  end
end
