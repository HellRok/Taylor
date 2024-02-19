def fixture_draw_texture
  w = Colour::RAYWHITE
  t = Colour::WHITE
  o = Colour[218, 154, 37]
  p = Colour[195, 37, 218]
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
    w, w, w, w, w, w, w, w, w, w
  ]
end

def fixture_draw_texture_pro
  w = Colour::RAYWHITE
  t = Colour::WHITE
  o = Colour[218, 154, 37]
  p = Colour[195, 37, 218]
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
    w, w, w, w, w, w, w, w, w, w
  ]
end
