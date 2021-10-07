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

def fixture_image_text_ex
  [
    Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0),
    Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0),
    Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 57), Colour.new(0, 0, 0, 170), Colour.new(0, 0, 0, 170), Colour.new(0, 0, 0, 170), Colour.new(0, 0, 0, 170), Colour.new(0, 0, 0, 170), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0),
    Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 85), Colour.new(0, 0, 0, 255), Colour.new(0, 0, 0, 255), Colour.new(0, 0, 0, 255), Colour.new(0, 0, 0, 255), Colour.new(0, 0, 0, 255), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0),
    Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 85), Colour.new(0, 0, 0, 255), Colour.new(0, 0, 0, 255), Colour.new(0, 0, 0, 255), Colour.new(0, 0, 0, 255), Colour.new(0, 0, 0, 255), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0),
    Colour.new(0, 0, 0, 255), Colour.new(0, 0, 0, 255), Colour.new(0, 0, 0, 170), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0),
    Colour.new(0, 0, 0, 255), Colour.new(0, 0, 0, 255), Colour.new(0, 0, 0, 170), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0),
    Colour.new(0, 0, 0, 170), Colour.new(0, 0, 0, 170), Colour.new(0, 0, 0, 113), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 57), Colour.new(0, 0, 0, 85), Colour.new(0, 0, 0, 85), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0),
    Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 170), Colour.new(0, 0, 0, 255), Colour.new(0, 0, 0, 255), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0),
    Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 170), Colour.new(0, 0, 0, 255), Colour.new(0, 0, 0, 255), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0),
    Colour.new(0, 0, 0, 170), Colour.new(0, 0, 0, 170), Colour.new(0, 0, 0, 170), Colour.new(0, 0, 0, 170), Colour.new(0, 0, 0, 170), Colour.new(0, 0, 0, 113), Colour.new(0, 0, 0, 85), Colour.new(0, 0, 0, 85), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0),
    Colour.new(0, 0, 0, 255), Colour.new(0, 0, 0, 255), Colour.new(0, 0, 0, 255), Colour.new(0, 0, 0, 255), Colour.new(0, 0, 0, 255), Colour.new(0, 0, 0, 85), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0),
    Colour.new(0, 0, 0, 255), Colour.new(0, 0, 0, 255), Colour.new(0, 0, 0, 255), Colour.new(0, 0, 0, 255), Colour.new(0, 0, 0, 255), Colour.new(0, 0, 0, 85), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0),
    Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0),
    Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0),
    Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0),
  ]
end
