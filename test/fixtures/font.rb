def fixture_font_default_draw
  w = RAYWHITE
  b = BLACK
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
  w = RAYWHITE
  b = BLACK
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
  w = RAYWHITE
  b = BLACK
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
  w = RAYWHITE
  b = BLACK
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
  w = RAYWHITE
  b = BLACK
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
  w = RAYWHITE
  g = GREEN
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
  w = RAYWHITE
  b = BLACK
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
  w = BLANK
  b = BLACK
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
    Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0),
    Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0),
    Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 1, 0, 1),
    Colour.new(0, 56, 12, 62), Colour.new(0, 39, 8, 43), Colour.new(0, 2, 0, 2), Colour.new(0, 3, 1, 4), Colour.new(0, 42, 9, 47), Colour.new(0, 45, 10, 51), Colour.new(0, 12, 2, 13), Colour.new(0, 0, 0, 0),
    Colour.new(0, 213, 45, 238), Colour.new(0, 149, 31, 167), Colour.new(0, 12, 3, 14), Colour.new(0, 17, 4, 19), Colour.new(0, 163, 34, 183), Colour.new(0, 173, 36, 193), Colour.new(0, 45, 10, 51), Colour.new(0, 0, 0, 0),
    Colour.new(0, 202, 43, 226), Colour.new(0, 160, 34, 179), Colour.new(0, 70, 15, 79), Colour.new(0, 75, 16, 84), Colour.new(0, 174, 37, 195), Colour.new(0, 163, 34, 183), Colour.new(0, 42, 9, 47), Colour.new(0, 0, 0, 0),
    Colour.new(0, 24, 5, 27), Colour.new(0, 72, 15, 81), Colour.new(0, 176, 37, 197), Colour.new(0, 177, 37, 198), Colour.new(0, 75, 16, 84), Colour.new(0, 17, 4, 19), Colour.new(0, 3, 1, 4), Colour.new(0, 0, 0, 0),
    Colour.new(0, 24, 5, 27), Colour.new(0, 72, 15, 81), Colour.new(0, 176, 37, 197), Colour.new(0, 177, 37, 198), Colour.new(0, 75, 16, 84), Colour.new(0, 17, 4, 19), Colour.new(0, 3, 1, 4), Colour.new(0, 0, 0, 0),
    Colour.new(0, 202, 43, 226), Colour.new(0, 160, 34, 179), Colour.new(0, 70, 15, 79), Colour.new(0, 75, 16, 84), Colour.new(0, 174, 37, 195), Colour.new(0, 163, 34, 183), Colour.new(0, 42, 9, 47), Colour.new(0, 0, 0, 0),
    Colour.new(0, 213, 45, 238), Colour.new(0, 149, 31, 167), Colour.new(0, 12, 3, 14), Colour.new(0, 17, 4, 19), Colour.new(0, 163, 34, 183), Colour.new(0, 173, 36, 193), Colour.new(0, 45, 10, 51), Colour.new(0, 0, 0, 0),
    Colour.new(0, 56, 12, 62), Colour.new(0, 39, 8, 43), Colour.new(0, 2, 0, 2), Colour.new(0, 3, 1, 4), Colour.new(0, 42, 9, 47), Colour.new(0, 45, 10, 51), Colour.new(0, 12, 2, 13), Colour.new(0, 0, 0, 0),
    Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 0, 0, 0), Colour.new(0, 1, 0, 1)

  ]
end

def fixture_font_to_image_with_spacing
  w = BLANK
  b = BLACK
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
  w = BLANK
  g = GREEN
  [
    w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w,
    g, w, g, w, g, w, g, w,
    w, g, w, w, w, g, w, w,
    g, w, g, w, g, w, g, w,
    w, w, w, w, w, w, w, w
  ]
end
