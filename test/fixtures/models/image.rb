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
