class Vector2
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
end
