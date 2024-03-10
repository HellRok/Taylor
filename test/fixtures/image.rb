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
