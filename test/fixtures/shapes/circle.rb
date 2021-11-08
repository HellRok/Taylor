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
    p, p, p, p, p, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
  ]
end

def fixture_draw_circle_gradient
  [
    Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(5, 225, 54, 255),
    Colour.new(30, 212, 79, 255), Colour.new(30, 212, 79, 255), Colour.new(5, 225, 54, 255),
    Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(5, 225, 54, 255),
    Colour.new(58, 197, 108, 255), Colour.new(94, 178, 146, 255), Colour.new(94, 178, 146, 255),
    Colour.new(58, 197, 108, 255), Colour.new(5, 225, 54, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255),
    Colour.new(30, 212, 79, 255), Colour.new(94, 178, 146, 255), Colour.new(153, 147, 206, 255),
    Colour.new(153, 147, 206, 255), Colour.new(94, 178, 146, 255), Colour.new(30, 212, 79, 255),
    Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255), Colour.new(30, 212, 79, 255), Colour.new(94, 178, 146, 255),
    Colour.new(153, 147, 206, 255), Colour.new(153, 147, 206, 255), Colour.new(94, 178, 146, 255),
    Colour.new(30, 212, 79, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(5, 225, 54, 255),
    Colour.new(58, 197, 108, 255), Colour.new(94, 178, 146, 255), Colour.new(94, 178, 146, 255),
    Colour.new(58, 197, 108, 255), Colour.new(5, 225, 54, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255), Colour.new(5, 225, 54, 255), Colour.new(30, 212, 79, 255),
    Colour.new(30, 212, 79, 255), Colour.new(5, 225, 54, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255),
  ]
end

def fixture_draw_circle_lines
  w = RAYWHITE
  p = PURPLE
  [
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, p, p, p, p, w, w, w,
    w, w, p, w, w, w, w, p, w, w,
    w, w, p, w, w, w, w, p, w, w,
    w, w, p, w, w, w, w, p, w, w,
    w, w, p, w, w, w, w, p, w, w,
    w, w, w, p, p, p, p, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
  ]
end
