def fixture_core_drawing_clear_default
  100.times.map { Colour::RAYWHITE }
end

def fixture_core_drawing_clear_specified
  100.times.map { Colour::GREEN }
end

def fixture_core_drawing_drawing
  100.times.map { Colour::RAYWHITE }
end

def fixture_core_drawing_scissor_mode
  w = Colour::RAYWHITE
  r = Colour::RED
  [
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, r, r, r, r, r, r, w, w,
    w, w, r, r, r, r, r, r, w, w,
    w, w, r, r, r, r, r, r, w, w,
    w, w, r, r, r, r, r, r, w, w,
    w, w, r, r, r, r, r, r, w, w,
    w, w, r, r, r, r, r, r, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w
  ]
end

def fixture_core_drawing_blend_mode
  wh = Colour::RAYWHITE

  # Used red as base and green as overlay
  # NOTE: In alpha and premultiplied alpha green was 50% transparent
  ad = Colour.new(red: 230, green: 255, blue: 103, alpha: 255) # Additive
  mu = Colour.new(red: 0, green: 37, blue: 10, alpha: 255) # Multiplied
  ac = Colour.new(red: 230, green: 255, blue: 103, alpha: 255) # Add colors
  su = Colour.new(red: 0, green: 187, blue: 0, alpha: 255) # Subtract colors
  al = Colour.new(red: 115, green: 134, blue: 52, alpha: 255) # Alpha
  ap = Colour.new(red: 115, green: 249, blue: 76, alpha: 255) # Alpha premultiply
  [
    ad, ad, mu, mu, ac, ac, su, su, al, al,
    ad, ad, mu, mu, ac, ac, su, su, al, al,
    ap, ap, wh, wh, wh, wh, wh, wh, wh, wh,
    ap, ap, wh, wh, wh, wh, wh, wh, wh, wh,
    wh, wh, wh, wh, wh, wh, wh, wh, wh, wh,
    wh, wh, wh, wh, wh, wh, wh, wh, wh, wh,
    wh, wh, wh, wh, wh, wh, wh, wh, wh, wh,
    wh, wh, wh, wh, wh, wh, wh, wh, wh, wh,
    wh, wh, wh, wh, wh, wh, wh, wh, wh, wh,
    wh, wh, wh, wh, wh, wh, wh, wh, wh, wh
  ]
end
