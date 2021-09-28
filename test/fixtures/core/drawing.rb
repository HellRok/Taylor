def fixture_core_drawing_clear_default
  100.times.map { RAYWHITE }
end

def fixture_core_drawing_clear_specified
  100.times.map { GREEN }
end

def fixture_core_drawing_drawing
  100.times.map { RAYWHITE }
end

def fixture_core_drawing_scissor_mode
  w = RAYWHITE
  r = RED
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
    w, w, w, w, w, w, w, w, w, w,
  ]
end

def fixture_core_drawing_mode2D
  w = RAYWHITE
  r = RED
  [
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
      w, w, w, w, w, w, w, w, w, w,
    ],
    [
      r, r, r, r, r, r, w, w, w, w,
      r, r, r, r, r, r, w, w, w, w,
      r, r, r, r, r, r, w, w, w, w,
      r, r, r, r, r, r, w, w, w, w,
      r, r, r, r, r, r, w, w, w, w,
      r, r, r, r, r, r, w, w, w, w,
      w, w, w, w, w, w, w, w, w, w,
      w, w, w, w, w, w, w, w, w, w,
      w, w, w, w, w, w, w, w, w, w,
      w, w, w, w, w, w, w, w, w, w,
    ]
  ]
end
