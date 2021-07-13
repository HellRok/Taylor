def fixture_draw_line
  w = RAYWHITE
  g = GREEN
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
    w, w, w, w, w, w, w, w, w, g,
  ]
end

def fixture_draw_line_ex
  w = RAYWHITE
  g = GREEN
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
    w, w, w, w, w, w, w, g, g, g,
  ]
end

def fixture_draw_line_bezier
  w = RAYWHITE
  g = GREEN
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
    w, w, w, w, w, w, w, g, g, g,
  ]
end

def fixture_draw_line_bezier_quad
  w = RAYWHITE
  g = GREEN
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
    w, w, w, w, w, w, w, w, w, g,
  ]
end
