def fixture_draw_line
  w = Colour::RAYWHITE
  g = Colour::GREEN
  [
    g, w, w, w, w, w, w, w, w, w,
    w, g, w, w, w, w, w, w, w, w,
    w, w, g, w, w, w, w, w, w, w,
    w, w, w, g, w, w, w, w, w, w,
    w, w, w, w, g, w, w, w, w, w,
    w, w, w, w, w, g, w, w, w, w,
    w, w, w, w, w, w, g, w, w, w,
    w, w, w, w, w, w, w, g, w, w,
    w, w, w, w, w, w, w, w, g, w,
    w, w, w, w, w, w, w, w, w, g
  ]
end

def fixture_draw_line_ex
  w = Colour::RAYWHITE
  g = Colour::GREEN
  [
    g, g, g, w, w, w, w, w, w, w,
    g, g, g, g, w, w, w, w, w, w,
    g, g, g, g, g, w, w, w, w, w,
    w, g, g, g, g, g, w, w, w, w,
    w, w, g, g, g, g, g, w, w, w,
    w, w, w, g, g, g, g, g, w, w,
    w, w, w, w, g, g, g, g, g, w,
    w, w, w, w, w, g, g, g, g, g,
    w, w, w, w, w, w, g, g, g, g,
    w, w, w, w, w, w, w, g, g, g
  ]
end

def fixture_draw_line_bezier
  w = Colour::RAYWHITE
  g = Colour::GREEN
  [
    g, g, g, w, w, w, w, w, w, w,
    w, w, w, g, w, w, w, w, w, w,
    w, w, w, g, g, w, w, w, w, w,
    w, w, w, w, g, w, w, w, w, w,
    w, w, w, w, g, w, w, w, w, w,
    w, w, w, w, w, g, w, w, w, w,
    w, w, w, w, w, g, w, w, w, w,
    w, w, w, w, w, g, g, w, w, w,
    w, w, w, w, w, w, g, w, w, w,
    w, w, w, w, w, w, w, g, g, g
  ]
end

def fixture_draw_line_bezier_quad
  w = Colour::RAYWHITE
  g = Colour::GREEN
  [
    g, g, w, w, w, w, w, w, w, w,
    w, w, g, g, w, w, w, w, w, w,
    w, w, w, g, g, w, w, w, w, w,
    w, w, w, w, w, g, w, w, w, w,
    w, w, w, w, w, w, g, w, w, w,
    w, w, w, w, w, w, w, g, w, w,
    w, w, w, w, w, w, w, g, g, w,
    w, w, w, w, w, w, w, w, g, w,
    w, w, w, w, w, w, w, w, w, g,
    w, w, w, w, w, w, w, w, w, g
  ]
end
