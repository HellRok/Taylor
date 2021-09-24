def fixture_draw_texture
  w = RAYWHITE
  t = WHITE
  o = Colour.new(218, 154, 37, 255)
  p = Colour.new(195, 37, 218, 255)
  [
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, o, t, p, w, w, w, w,
    w, w, w, t, o, t, w, w, w, w,
    w, w, w, p, t, o, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
  ]
end

def fixture_draw_texture_pro
  w = RAYWHITE
  t = WHITE
  o = Colour.new(218, 154, 37, 255)
  p = Colour.new(195, 37, 218, 255)
  [
    o, o, o, t, t, t, p, p, p, w,
    o, o, o, t, t, t, p, p, p, w,
    o, o, o, t, t, t, p, p, p, w,
    t, t, t, o, o, o, t, t, t, w,
    t, t, t, o, o, o, t, t, t, w,
    t, t, t, o, o, o, t, t, t, w,
    p, p, p, t, t, t, o, o, o, w,
    p, p, p, t, t, t, o, o, o, w,
    p, p, p, t, t, t, o, o, o, w,
    w, w, w, w, w, w, w, w, w, w,
  ]
end
