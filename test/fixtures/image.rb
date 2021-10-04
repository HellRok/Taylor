def fixture_image_load
  t = WHITE
  o = Colour.new(218, 154, 37, 255)
  p = Colour.new(195, 37, 218, 255)
  [
    o, t, p,
    t, o, t,
    p, t, o,
  ]
end

def fixture_generate_colour
  100.times.map { RAYWHITE }
end

def fixture_image_from_image
  t = WHITE
  o = Colour.new(218, 154, 37, 255)
  [
    o, t,
    t, o,
  ]
end
