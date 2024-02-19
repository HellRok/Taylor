def fixture_font_default_draw
  w = Colour::RAYWHITE
  b = Colour::BLACK
  [
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    b, w, w, w, b, b, w, w, w, b,
    w, b, w, b, w, w, b, w, b, w,
    w, w, b, w, w, w, w, b, w, w,
    w, b, w, b, w, w, b, w, b, w,
    b, w, w, w, b, b, w, w, w, b,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w
  ]
end

def fixture_font_draw
  w = Colour::RAYWHITE
  b = Colour::BLACK
  [
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    b, w, b, w, b, w, b, w, w, w,
    w, b, w, w, w, b, w, w, w, w,
    b, w, b, w, b, w, b, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w
  ]
end

def fixture_font_draw_with_size
  w = Colour::RAYWHITE
  b = Colour::BLACK
  [
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    b, b, w, w, b, b, w, w, w, w,
    b, b, w, w, b, b, w, w, w, w,
    w, w, b, b, w, w, w, w, w, w,
    w, w, b, b, w, w, w, w, w, w,
    b, b, w, w, b, b, w, w, w, w,
    b, b, w, w, b, b, w, w, w, w
  ]
end

def fixture_font_draw_with_position
  w = Colour::RAYWHITE
  b = Colour::BLACK
  [
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, b, w, b, w, w, w, w, w,
    w, w, w, b, w, w, w, w, w, w,
    w, w, b, w, b, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w
  ]
end

def fixture_font_draw_with_x_and_y
  w = Colour::RAYWHITE
  b = Colour::BLACK
  [
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, b, w, b, w, w, w, w, w,
    w, w, w, b, w, w, w, w, w, w,
    w, w, b, w, b, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w
  ]
end

def fixture_font_draw_with_colour
  w = Colour::RAYWHITE
  g = Colour::GREEN
  [
    w, w, w, w, w, w, w, w, w, w,
    w, g, g, w, w, w, w, w, w, w,
    g, w, w, g, w, w, w, w, w, w,
    g, w, w, g, w, w, w, w, w, w,
    w, g, g, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w
  ]
end

def fixture_font_draw_with_spacing
  w = Colour::RAYWHITE
  b = Colour::BLACK
  [
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    b, w, b, w, w, b, w, b, w, w,
    w, b, w, w, w, w, b, w, w, w,
    b, w, b, w, w, b, w, b, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w
  ]
end

def fixture_font_to_image
  w = Colour::BLANK
  b = Colour::BLACK
  [
    w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w,
    b, w, b, w, b, w, b, w,
    w, b, w, w, w, b, w, w,
    b, w, b, w, b, w, b, w,
    w, w, w, w, w, w, w, w
  ]
end

def fixture_font_to_image_with_size
  [
    Colour[0, 0, 0, 0], Colour[0, 0, 0, 0], Colour[0, 0, 0, 0], Colour[0, 0, 0, 0], Colour[0, 0, 0, 0], Colour[0, 0, 0, 0], Colour[0, 0, 0, 0], Colour[0, 0, 0, 0],
    Colour[0, 0, 0, 0], Colour[0, 0, 0, 0], Colour[0, 0, 0, 0], Colour[0, 0, 0, 0], Colour[0, 0, 0, 0], Colour[0, 0, 0, 0], Colour[0, 0, 0, 0], Colour[0, 0, 0, 0],
    Colour[0, 0, 0, 0], Colour[0, 0, 0, 0], Colour[0, 0, 0, 0], Colour[0, 0, 0, 0], Colour[0, 0, 0, 0], Colour[0, 0, 0, 0], Colour[0, 0, 0, 0], Colour[0, 1, 0, 1],
    Colour[0, 56, 12, 62], Colour[0, 39, 8, 43], Colour[0, 2, 0, 2], Colour[0, 3, 1, 4], Colour[0, 42, 9, 47], Colour[0, 45, 10, 51], Colour[0, 12, 2, 13], Colour[0, 0, 0, 0],
    Colour[0, 213, 45, 238], Colour[0, 149, 31, 167], Colour[0, 12, 3, 14], Colour[0, 17, 4, 19], Colour[0, 163, 34, 183], Colour[0, 173, 36, 193], Colour[0, 45, 10, 51], Colour[0, 0, 0, 0],
    Colour[0, 202, 43, 226], Colour[0, 160, 34, 179], Colour[0, 70, 15, 79], Colour[0, 75, 16, 84], Colour[0, 174, 37, 195], Colour[0, 163, 34, 183], Colour[0, 42, 9, 47], Colour[0, 0, 0, 0],
    Colour[0, 24, 5, 27], Colour[0, 72, 15, 81], Colour[0, 176, 37, 197], Colour[0, 177, 37, 198], Colour[0, 75, 16, 84], Colour[0, 17, 4, 19], Colour[0, 3, 1, 4], Colour[0, 0, 0, 0],
    Colour[0, 24, 5, 27], Colour[0, 72, 15, 81], Colour[0, 176, 37, 197], Colour[0, 177, 37, 198], Colour[0, 75, 16, 84], Colour[0, 17, 4, 19], Colour[0, 3, 1, 4], Colour[0, 0, 0, 0],
    Colour[0, 202, 43, 226], Colour[0, 160, 34, 179], Colour[0, 70, 15, 79], Colour[0, 75, 16, 84], Colour[0, 174, 37, 195], Colour[0, 163, 34, 183], Colour[0, 42, 9, 47], Colour[0, 0, 0, 0],
    Colour[0, 213, 45, 238], Colour[0, 149, 31, 167], Colour[0, 12, 3, 14], Colour[0, 17, 4, 19], Colour[0, 163, 34, 183], Colour[0, 173, 36, 193], Colour[0, 45, 10, 51], Colour[0, 0, 0, 0],
    Colour[0, 56, 12, 62], Colour[0, 39, 8, 43], Colour[0, 2, 0, 2], Colour[0, 3, 1, 4], Colour[0, 42, 9, 47], Colour[0, 45, 10, 51], Colour[0, 12, 2, 13], Colour[0, 0, 0, 0],
    Colour[0, 0, 0, 0], Colour[0, 0, 0, 0], Colour[0, 0, 0, 0], Colour[0, 0, 0, 0], Colour[0, 0, 0, 0], Colour[0, 0, 0, 0], Colour[0, 0, 0, 0], Colour[0, 1, 0, 1]
  ]
end

def fixture_font_to_image_with_spacing
  w = Colour::BLANK
  b = Colour::BLACK
  [
    w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w,
    b, w, b, w, w, b, w, b, w,
    w, b, w, w, w, w, b, w, w,
    b, w, b, w, w, b, w, b, w,
    w, w, w, w, w, w, w, w, w
  ]
end

def fixture_font_to_image_with_colour
  w = Colour::BLANK
  g = Colour::GREEN
  [
    w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w,
    g, w, g, w, g, w, g, w,
    w, g, w, w, w, g, w, w,
    g, w, g, w, g, w, g, w,
    w, w, w, w, w, w, w, w
  ]
end
