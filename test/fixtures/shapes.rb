def fixture_draw_pixel
  w = RAYWHITE
  v = VIOLET
  [
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, v, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
  ]
end

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

def fixture_draw_circle
  w = RAYWHITE
  p = PURPLE
  [
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, p, p, p, p, w, w, w,
    w, w, p, p, p, p, p, p, w, w,
    w, w, p, p, p, p, p, p, w, w,
    w, w, p, p, p, p, p, p, w, w,
    w, w, p, p, p, p, p, p, w, w,
    w, w, w, p, p, p, p, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
  ]
end

def fixture_draw_circle_sector
  w = RAYWHITE
  p = PURPLE
  [
    w, w, w, p, p, w, w, w, w, w,
    w, p, p, p, p, w, w, w, w, w,
    w, p, p, p, p, w, w, w, w, w,
    p, p, p, p, p, w, w, w, w, w,
    p, p, p, p, p, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
  ]
end

def fixture_draw_circle_sector_lines
  w = RAYWHITE
  p = PURPLE
  [
    w, w, p, p, p, w, w, w, w, w,
    w, p, w, w, p, w, w, w, w, w,
    p, w, w, w, p, w, w, w, w, w,
    p, w, w, w, p, w, w, w, w, w,
    p, w, w, w, p, w, w, w, w, w,
    p, p, p, p, p, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
  ]
end

def fixture_draw_rectangle
  w = RAYWHITE
  r = RED
  [
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, r, r, r, r, w, w, w, w,
    w, w, r, r, r, r, w, w, w, w,
    w, w, r, r, r, r, w, w, w, w,
    w, w, r, r, r, r, w, w, w, w,
    w, w, r, r, r, r, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
  ]
end

def fixture_draw_rectangle_lines
  w = RAYWHITE
  r = RED
  [
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, r, r, r, r, w, w, w, w,
    w, w, r, w, w, r, w, w, w, w,
    w, w, r, w, w, r, w, w, w, w,
    w, w, r, w, w, r, w, w, w, w,
    w, w, r, r, r, r, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
  ]
end

def fixture_draw_rectangle_lines_ex
  w = RAYWHITE
  r = RED
  [
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, r, r, r, r, r, r, r, r,
    w, w, r, r, r, r, r, r, r, r,
    w, w, r, r, w, w, w, w, r, r,
    w, w, r, r, w, w, w, w, r, r,
    w, w, r, r, w, w, w, w, r, r,
    w, w, r, r, w, w, w, w, r, r,
    w, w, r, r, r, r, r, r, r, r,
    w, w, r, r, r, r, r, r, r, r,
  ]
end

def fixture_draw_triangle
  w = RAYWHITE
  b = BLUE
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
    w, w, w, w, w, w, w, w, w, w,
  ]
end
