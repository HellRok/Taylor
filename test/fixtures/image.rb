def fixture_image_colour_replace!
  b = Colour::BLUE
  o = Colour[218, 154, 37]
  p = Colour[195, 37, 218]
  [
    o, b, p,
    b, o, b,
    p, b, o
  ]
end

def fixture_image_draw!
  r = Colour::RAYWHITE
  t = Colour::WHITE
  o = Colour[218, 154, 37]
  [
    r, r, r,
    r, o, t,
    r, t, o
  ]
end
