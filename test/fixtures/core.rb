def fixture_init_window
  100.times.map { RAYWHITE }
end

def fixture_clear_background
  100.times.map { RED }
end

def fixture_mode2D
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
