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
