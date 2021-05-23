# Draw a line between the start and end points
# @param start_x [Integer]
# @param start_y [Integer]
# @param end_x [Integer]
# @param end_y [Integer]
# @param colour [Colour]
# @return [nil]
def draw_line(start_x, start_y, end_x, end_y, colour)
  # mrb_draw_line
  # src/mruby_integration/shapes.cpp
  nil
end

# Draw a circle
# @param x [Integer]
# @param y [Integer]
# @param radius [Float]
# @param colour [Colour]
# @return [nil]
def draw_circle(x, y, radius, colour)
  # mrb_draw_circle
  # src/mruby_integration/shapes.cpp
  nil
end

# Draw a circle
# @param vector [Vector2]
# @param radius [Float]
# @param colour [Colour]
# @return [nil]
def draw_circle_v(vector, radius, colour)
  # mrb_draw_circle_v
  # src/mruby_integration/shapes.cpp
  nil
end

# Draw a rectangle
# @param x [Integer]
# @param y [Integer]
# @param width [Integer]
# @param height [Integer]
# @param colour [Colour]
# @return [nil]
def draw_rectangle(x, y, width, height, colour)
  # mrb_draw_rectangle
  # src/mruby_integration/shapes.cpp
  nil
end

# Draw a rectangle
# @param rectangle [Rectangle]
# @param colour [Colour]
# @return [nil]
def draw_rectangle_rec(rectangle, colour)
  # mrb_draw_rectangle_rec
  # src/mruby_integration/shapes.cpp
  nil
end

# Draw a rectangle outline
# @param x [Integer]
# @param y [Integer]
# @param width [Integer]
# @param height [Integer]
# @param colour [Colour]
# @return [nil]
def draw_rectangle_lines(x, y, width, height, colour)
  # mrb_draw_rectangle_lines
  # src/mruby_integration/shapes.cpp
  nil
end

# Draw a rectangle outline with the specific thickness
# @param rectangle [Rectangle]
# @param thickness [Integer]
# @param colour [Colour]
# @return [nil]
def draw_rectangle_lines_ex(rectangle, thickness, colour)
  # mrb_draw_rectangle_lines_ex
  # src/mruby_integration/shapes.cpp
  nil
end

# Draw a triangle
# @param left [Vector2]
# @param right [Vector2]
# @param top [Vector2]
# @param colour [Colour]
# @return [nil]
def draw_triangle(left, right, top, colour)
  # mrb_draw_triangle
  # src/mruby_integration/shapes.cpp
  nil
end

# Checks if a Vector2 is inside a Rectangle
# @param point [Vector2]
# @param rectangle [Rectangle]
# @return [Boolean]
def check_collision_point_rec(point, rectangle)
  # mrb_check_collision_point_rec
  # src/mruby_integration/shapes.cpp
  true
end
