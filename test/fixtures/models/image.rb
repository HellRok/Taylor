def fixture_models_image_load
  t = WHITE
  o = Colour.new(218, 154, 37, 255)
  p = Colour.new(195, 37, 218, 255)
  [
    o, t, p,
    t, o, t,
    p, t, o,
  ]
end

def fixture_models_generate_default
  100.times.map { RAYWHITE }
end

def fixture_models_generate
  100.times.map { GREEN }
end

def fixture_models_copy_with_source
  t = WHITE
  o = Colour.new(218, 154, 37, 255)
  [
    o, t,
    t, o,
  ]
end

def fixture_models_image_resize_bicubic_scaing!
  [
    Colour.new(212, 139, 4, 255), Colour.new(226, 176, 73, 255), Colour.new(254, 255, 224, 255), Colour.new(247, 221, 255, 255), Colour.new(205, 73, 232, 255), Colour.new(186, 5, 212, 255),
    Colour.new(226, 176, 73, 255), Colour.new(232, 194, 107, 255), Colour.new(245, 232, 179, 255), Colour.new(240, 206, 219, 255), Colour.new(216, 115, 228, 255), Colour.new(205, 73, 232, 255),
    Colour.new(254, 255, 224, 255), Colour.new(245, 232, 179, 255), Colour.new(227, 181, 82, 255), Colour.new(225, 172, 96, 255), Colour.new(240, 206, 219, 255), Colour.new(247, 221, 255, 255),
    Colour.new(247, 221, 255, 255), Colour.new(240, 206, 219, 255), Colour.new(225, 172, 96, 255), Colour.new(227, 181, 82, 255), Colour.new(245, 232, 179, 255), Colour.new(254, 255, 224, 255),
    Colour.new(205, 73, 232, 255), Colour.new(216, 115, 228, 255), Colour.new(240, 206, 219, 255), Colour.new(245, 232, 179, 255), Colour.new(232, 194, 107, 255), Colour.new(226, 176, 73, 255),
    Colour.new(186, 5, 212, 255), Colour.new(205, 73, 232, 255), Colour.new(247, 221, 255, 255), Colour.new(254, 255, 224, 255), Colour.new(226, 176, 73, 255), Colour.new(212, 139, 4, 255),
  ]
end

def fixture_models_image_resize_default_scaing!
  t = WHITE
  o = Colour.new(218, 154, 37, 255)
  p = Colour.new(195, 37, 218, 255)
  [
    o, o, t, t, p, p,
    o, o, t, t, p, p,
    t, t, o, o, t, t,
    t, t, o, o, t, t,
    p, p, t, t, o, o,
    p, p, t, t, o, o,
  ]
end

def fixture_models_image_crop!
  t = WHITE
  o = Colour.new(218, 154, 37, 255)
  p = Colour.new(195, 37, 218, 255)
  [
    o, t,
    t, o,
    p, t,
  ]
end

def fixture_models_image_alpha_mask
  t = Colour.new(255, 255, 255, 0)
  o = Colour.new(218, 154, 37, 255)
  p = Colour.new(195, 37, 218, 0)
  [
    o, t, p,
    t, o, t,
    p, t, o,
  ]
end

def fixture_models_image_flip_vertical!
  t = WHITE
  o = Colour.new(218, 154, 37, 255)
  p = Colour.new(195, 37, 218, 255)
  [
    p, t, p,
    t, o, t,
    o, t, p,
  ]
end

def fixture_models_image_flip_horizontal!
  t = WHITE
  o = Colour.new(218, 154, 37, 255)
  p = Colour.new(195, 37, 218, 255)
  [
    p, t, o,
    t, o, t,
    p, t, p,
  ]
end

def fixture_models_image_rotate_nil!
  t = WHITE
  o = Colour.new(218, 154, 37, 255)
  p = Colour.new(195, 37, 218, 255)
  [
    p, t, o,
    t, o, t,
    p, t, p,
  ]
end

def fixture_models_image_rotate_cw!
  fixture_models_image_rotate_nil!
end

def fixture_models_image_rotate_ccw!
  t = WHITE
  o = Colour.new(218, 154, 37, 255)
  p = Colour.new(195, 37, 218, 255)
  [
    p, t, p,
    t, o, t,
    o, t, p,
  ]
end

def fixture_models_image_colour_tint!
  [
    Colour.new(0, 108, 45, 255)
  ]
end

def fixture_models_image_colour_invert!
  [
    WHITE
  ]
end

def fixture_models_image_colour_grayscale!
  [
    [Colour.new(99, 99, 99 ,255)],
    [Colour.new(98, 98, 98 ,255)],
    [Colour.new(139, 139, 139 ,255)],
  ]
end

def fixture_models_image_colour_contrast!
  [
    [Colour.new(0, 164, 30, 255)],
    [Colour.new(24, 152, 62, 255)],
  ]
end
