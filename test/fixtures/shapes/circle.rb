def fixture_draw_circle
  w = Colour::RAYWHITE
  p = Colour::PURPLE
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
    w, w, w, w, w, w, w, w, w, w
  ]
end

def fixture_draw_circle_sector
  w = Colour::RAYWHITE
  p = Colour::PURPLE
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
    w, w, w, w, w, w, w, w, w, w
  ]
end

def fixture_draw_circle_sector_lines
  w = Colour::RAYWHITE
  p = Colour::PURPLE
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
    w, w, w, w, w, w, w, w, w, w
  ]
end

def fixture_draw_circle_gradient
  [
    Colour[245, 245, 245], Colour[245, 245, 245], Colour[245, 245, 245],
    Colour[245, 245, 245], Colour[245, 245, 245], Colour[245, 245, 245],
    Colour[245, 245, 245], Colour[245, 245, 245], Colour[245, 245, 245],
    Colour[245, 245, 245], Colour[245, 245, 245], Colour[245, 245, 245],
    Colour[245, 245, 245], Colour[245, 245, 245], Colour[245, 245, 245],
    Colour[245, 245, 245], Colour[245, 245, 245], Colour[245, 245, 245],
    Colour[245, 245, 245], Colour[245, 245, 245], Colour[245, 245, 245],
    Colour[245, 245, 245], Colour[245, 245, 245], Colour[5, 225, 54],
    Colour[30, 212, 79], Colour[30, 212, 79], Colour[5, 225, 54],
    Colour[245, 245, 245], Colour[245, 245, 245], Colour[245, 245, 245],
    Colour[245, 245, 245], Colour[245, 245, 245], Colour[5, 225, 54],
    Colour[58, 197, 108], Colour[94, 178, 146], Colour[94, 178, 146],
    Colour[58, 197, 108], Colour[5, 225, 54], Colour[245, 245, 245],
    Colour[245, 245, 245], Colour[245, 245, 245], Colour[245, 245, 245],
    Colour[30, 212, 79], Colour[94, 178, 146], Colour[153, 147, 206],
    Colour[153, 147, 206], Colour[94, 178, 146], Colour[30, 212, 79],
    Colour[245, 245, 245], Colour[245, 245, 245], Colour[245, 245, 245],
    Colour[245, 245, 245], Colour[30, 212, 79], Colour[94, 178, 146],
    Colour[153, 147, 206], Colour[153, 147, 206], Colour[94, 178, 146],
    Colour[30, 212, 79], Colour[245, 245, 245], Colour[245, 245, 245],
    Colour[245, 245, 245], Colour[245, 245, 245], Colour[5, 225, 54],
    Colour[58, 197, 108], Colour[94, 178, 146], Colour[94, 178, 146],
    Colour[58, 197, 108], Colour[5, 225, 54], Colour[245, 245, 245],
    Colour[245, 245, 245], Colour[245, 245, 245], Colour[245, 245, 245],
    Colour[245, 245, 245], Colour[5, 225, 54], Colour[30, 212, 79],
    Colour[30, 212, 79], Colour[5, 225, 54], Colour[245, 245, 245],
    Colour[245, 245, 245], Colour[245, 245, 245], Colour[245, 245, 245],
    Colour[245, 245, 245], Colour[245, 245, 245], Colour[245, 245, 245],
    Colour[245, 245, 245], Colour[245, 245, 245], Colour[245, 245, 245],
    Colour[245, 245, 245], Colour[245, 245, 245], Colour[245, 245, 245],
    Colour[245, 245, 245], Colour[245, 245, 245], Colour[245, 245, 245],
    Colour[245, 245, 245], Colour[245, 245, 245], Colour[245, 245, 245],
    Colour[245, 245, 245], Colour[245, 245, 245], Colour[245, 245, 245],
    Colour[245, 245, 245]
  ]
end

def fixture_draw_circle_lines
  w = Colour::RAYWHITE
  p = Colour::PURPLE
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
    w, w, w, w, w, w, w, w, w, w
  ]
end
