def fixture_image_flip_vertical!
  t = Colour::WHITE
  o = Colour[218, 154, 37]
  p = Colour[195, 37, 218]
  [
    p, t, p,
    t, o, t,
    o, t, p
  ]
end

def fixture_image_flip_horizontal!
  t = Colour::WHITE
  o = Colour[218, 154, 37]
  p = Colour[195, 37, 218]
  [
    p, t, o,
    t, o, t,
    p, t, p
  ]
end

def fixture_image_rotate_cw!
  t = Colour::WHITE
  o = Colour[218, 154, 37]
  p = Colour[195, 37, 218]
  [
    p, t, o,
    t, o, t,
    p, t, p
  ]
end

def fixture_image_rotate_ccw!
  t = Colour::WHITE
  o = Colour[218, 154, 37]
  p = Colour[195, 37, 218]
  [
    p, t, p,
    t, o, t,
    o, t, p
  ]
end

def fixture_image_colour_tint!
  [
    Colour[0, 108, 45]
  ]
end

def fixture_image_colour_invert!
  [
    Colour::WHITE
  ]
end

def fixture_image_colour_grayscale!
  [
    [Colour[99, 99, 99]],
    [Colour[98, 98, 98]],
    [Colour[139, 139, 139]]
  ]
end

def fixture_image_colour_contrast!
  [
    [Colour[0, 196, 0]],
    [Colour[95, 135, 107]]
  ]
end

def fixture_image_colour_brightness!
  [
    [Colour[185, 110, 240]],
    [Colour[85, 10, 140]]
  ]
end

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
