def fixture_draw_triangle
  w = Colour::RAYWHITE
  b = Colour::BLUE
  [
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, b, b, w, w, w, w,
    w, w, w, b, b, b, b, w, w, w,
    w, w, b, b, b, b, b, w, w, w,
    w, w, b, b, b, b, b, b, w, w,
    w, b, b, b, b, b, b, b, b, w,
    b, b, b, b, b, b, b, b, b, b,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w
  ]
end

def fixture_draw_triangle_lines
  w = Colour::RAYWHITE
  b = Colour::BLUE
  [
    w, w, w, w, b, b, w, w, w, w,
    w, w, w, b, w, w, b, w, w, w,
    w, w, w, b, w, w, b, w, w, w,
    w, w, b, w, w, w, w, b, w, w,
    w, b, w, w, w, w, w, w, b, w,
    w, b, w, w, w, w, w, w, b, w,
    b, b, b, b, b, b, b, b, b, b,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w
  ]
end
