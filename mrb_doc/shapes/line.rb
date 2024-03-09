# Draw a line between the start and end points.
# @param start_x [Integer]
# @param start_y [Integer]
# @param end_x [Integer]
# @param end_y [Integer]
# @param colour [Colour]
# @return [nil]
def draw_line(start_x, start_y, end_x, end_y, colour)
  # mrb_draw_line
  # src/mruby_integration/shapes/line.cpp
  nil
end

# Draw a line between the start and end points using {Vector2}s.
# @param start [Vector2]
# @param stop [Vector2]
# @param colour [Colour]
# @return [nil]
def draw_line_v(start, stop, colour)
  # mrb_draw_line_v
  # src/mruby_integration/shapes/line.cpp
  nil
end

# Draw a line between the start and end points using {Vector2}s and specified thickness.
# @param start [Vector2]
# @param stop [Vector2]
# @param thickness [Float]
# @param colour [Colour]
# @return [nil]
def draw_line_ex(start, stop, thickness, colour)
  # mrb_draw_line_ex
  # src/mruby_integration/shapes/line.cpp
  nil
end

# Draw a bezier curve between the start and end points using {Vector2}s and specified thickness.
# @param start [Vector2]
# @param stop [Vector2]
# @param thickness [Float]
# @param colour [Colour]
# @return [nil]
def draw_line_bezier(start, stop, thickness, colour)
  # mrb_draw_line_bezier
  # src/mruby_integration/shapes/line.cpp
  nil
end

# Draw a bezier curve between the start and end points passing through the control using {Vector2}s and specified thickness
# @param start [Vector2]
# @param stop [Vector2]
# @param control [Vector2]
# @param thickness [Float]
# @param colour [Colour]
# @return [nil]
def draw_line_bezier_quad(start, stop, control, thickness, colour)
  # mrb_draw_line_bezier_quad
  # src/mruby_integration/shapes/line.cpp
  nil
end

# @note I honestly don't know how this method is supposed to work, I thought I had
#   bugs in my code but reproducing it in plain C++ causes it to do the same
#   things. As far as I can tell it just draws a line from 0, 0 to the first
#   vector and nothing else.
# @param vectors [Array<Vector2>]
# @param colour [Colour]
# @return [nil]
def draw_line_strip(vectors, colour)
  # mrb_draw_line_strips
  # src/mruby_integration/shapes/line.cpp
  nil
end
