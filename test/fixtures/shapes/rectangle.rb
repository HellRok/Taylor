def fixture_draw_rectangle
  w = RAYWHITE
  r = RED
  [
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, r, r, r, r, w, w, w, w,
    w, w, r, r, r, r, w, w, w, w,
    w, w, r, r, r, r, w, w, w, w,
    w, w, r, r, r, r, w, w, w, w,
    w, w, r, r, r, r, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w
  ]
end

def fixture_draw_rectangle_gradient_v
  [
    Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255), Colour.new(231, 54, 52, 255), Colour.new(231, 54, 52, 255), Colour.new(231, 54, 52, 255), Colour.new(231, 54, 52, 255), Colour.new(231, 54, 52, 255), Colour.new(231, 54, 52, 255), Colour.new(231, 54, 52, 255), Colour.new(231, 54, 52, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255), Colour.new(234, 80, 45, 255), Colour.new(234, 80, 45, 255), Colour.new(234, 80, 45, 255), Colour.new(234, 80, 45, 255), Colour.new(234, 80, 45, 255), Colour.new(234, 80, 45, 255), Colour.new(234, 80, 45, 255), Colour.new(234, 80, 45, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255), Colour.new(237, 106, 38, 255), Colour.new(237, 106, 38, 255), Colour.new(237, 106, 38, 255), Colour.new(237, 106, 38, 255), Colour.new(237, 106, 38, 255), Colour.new(237, 106, 38, 255), Colour.new(237, 106, 38, 255), Colour.new(237, 106, 38, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255), Colour.new(240, 132, 31, 255), Colour.new(240, 132, 31, 255), Colour.new(240, 132, 31, 255), Colour.new(240, 132, 31, 255), Colour.new(240, 132, 31, 255), Colour.new(240, 132, 31, 255), Colour.new(240, 132, 31, 255), Colour.new(240, 132, 31, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255), Colour.new(243, 158, 24, 255), Colour.new(243, 158, 24, 255), Colour.new(243, 158, 24, 255), Colour.new(243, 158, 24, 255), Colour.new(243, 158, 24, 255), Colour.new(243, 158, 24, 255), Colour.new(243, 158, 24, 255), Colour.new(243, 158, 24, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255), Colour.new(246, 184, 17, 255), Colour.new(246, 184, 17, 255), Colour.new(246, 184, 17, 255), Colour.new(246, 184, 17, 255), Colour.new(246, 184, 17, 255), Colour.new(246, 184, 17, 255), Colour.new(246, 184, 17, 255), Colour.new(246, 184, 17, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255), Colour.new(249, 210, 10, 255), Colour.new(249, 210, 10, 255), Colour.new(249, 210, 10, 255), Colour.new(249, 210, 10, 255), Colour.new(249, 210, 10, 255), Colour.new(249, 210, 10, 255), Colour.new(249, 210, 10, 255), Colour.new(249, 210, 10, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255), Colour.new(252, 236, 3, 255), Colour.new(252, 236, 3, 255), Colour.new(252, 236, 3, 255), Colour.new(252, 236, 3, 255), Colour.new(252, 236, 3, 255), Colour.new(252, 236, 3, 255), Colour.new(252, 236, 3, 255), Colour.new(252, 236, 3, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255)
  ]
end

def fixture_draw_rectangle_gradient_h
  [
    Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255), Colour.new(231, 54, 52, 255), Colour.new(234, 80, 45, 255), Colour.new(237, 106, 38, 255), Colour.new(240, 132, 31, 255), Colour.new(243, 158, 24, 255), Colour.new(246, 184, 17, 255), Colour.new(249, 210, 10, 255), Colour.new(252, 236, 3, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255), Colour.new(231, 54, 52, 255), Colour.new(234, 80, 45, 255), Colour.new(237, 106, 38, 255), Colour.new(240, 132, 31, 255), Colour.new(243, 158, 24, 255), Colour.new(246, 184, 17, 255), Colour.new(249, 210, 10, 255), Colour.new(252, 236, 3, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255), Colour.new(231, 54, 52, 255), Colour.new(234, 80, 45, 255), Colour.new(237, 106, 38, 255), Colour.new(240, 132, 31, 255), Colour.new(243, 158, 24, 255), Colour.new(246, 184, 17, 255), Colour.new(249, 210, 10, 255), Colour.new(252, 236, 3, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255), Colour.new(231, 54, 52, 255), Colour.new(234, 80, 45, 255), Colour.new(237, 106, 38, 255), Colour.new(240, 132, 31, 255), Colour.new(243, 158, 24, 255), Colour.new(246, 184, 17, 255), Colour.new(249, 210, 10, 255), Colour.new(252, 236, 3, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255), Colour.new(231, 54, 52, 255), Colour.new(234, 80, 45, 255), Colour.new(237, 106, 38, 255), Colour.new(240, 132, 31, 255), Colour.new(243, 158, 24, 255), Colour.new(246, 184, 17, 255), Colour.new(249, 210, 10, 255), Colour.new(252, 236, 3, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255), Colour.new(231, 54, 52, 255), Colour.new(234, 80, 45, 255), Colour.new(237, 106, 38, 255), Colour.new(240, 132, 31, 255), Colour.new(243, 158, 24, 255), Colour.new(246, 184, 17, 255), Colour.new(249, 210, 10, 255), Colour.new(252, 236, 3, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255), Colour.new(231, 54, 52, 255), Colour.new(234, 80, 45, 255), Colour.new(237, 106, 38, 255), Colour.new(240, 132, 31, 255), Colour.new(243, 158, 24, 255), Colour.new(246, 184, 17, 255), Colour.new(249, 210, 10, 255), Colour.new(252, 236, 3, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255), Colour.new(231, 54, 52, 255), Colour.new(234, 80, 45, 255), Colour.new(237, 106, 38, 255), Colour.new(240, 132, 31, 255), Colour.new(243, 158, 24, 255), Colour.new(246, 184, 17, 255), Colour.new(249, 210, 10, 255), Colour.new(252, 236, 3, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255)
  ]
end

def fixture_draw_rectangle_gradient_ex
  [
    Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255), Colour.new(216, 53, 55, 255), Colour.new(187, 63, 78, 255), Colour.new(158, 73, 101, 255), Colour.new(129, 83, 124, 255), Colour.new(101, 93, 148, 255), Colour.new(72, 103, 171, 255), Colour.new(43, 113, 194, 255), Colour.new(14, 123, 217, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255), Colour.new(218, 79, 48, 255), Colour.new(187, 76, 54, 255), Colour.new(158, 86, 77, 255), Colour.new(129, 96, 100, 255), Colour.new(101, 106, 123, 255), Colour.new(72, 116, 147, 255), Colour.new(43, 126, 170, 255), Colour.new(14, 136, 193, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255), Colour.new(221, 105, 41, 255), Colour.new(190, 102, 47, 255), Colour.new(158, 99, 53, 255), Colour.new(129, 109, 76, 255), Colour.new(101, 119, 99, 255), Colour.new(72, 129, 123, 255), Colour.new(43, 139, 146, 255), Colour.new(14, 149, 169, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255), Colour.new(224, 131, 34, 255), Colour.new(193, 128, 40, 255), Colour.new(161, 125, 46, 255), Colour.new(129, 123, 52, 255), Colour.new(101, 133, 75, 255), Colour.new(72, 143, 98, 255), Colour.new(43, 153, 122, 255), Colour.new(14, 163, 145, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255), Colour.new(227, 157, 27, 255), Colour.new(195, 154, 33, 255), Colour.new(164, 151, 39, 255), Colour.new(132, 149, 45, 255), Colour.new(101, 146, 51, 255), Colour.new(72, 156, 74, 255), Colour.new(43, 166, 98, 255), Colour.new(14, 176, 121, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255), Colour.new(230, 183, 20, 255), Colour.new(198, 180, 26, 255), Colour.new(167, 177, 32, 255), Colour.new(135, 175, 38, 255), Colour.new(103, 172, 44, 255), Colour.new(72, 170, 50, 255), Colour.new(43, 180, 73, 255), Colour.new(14, 190, 97, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255), Colour.new(233, 209, 13, 255), Colour.new(201, 206, 19, 255), Colour.new(170, 203, 25, 255), Colour.new(138, 201, 31, 255), Colour.new(106, 198, 37, 255), Colour.new(75, 196, 43, 255), Colour.new(43, 193, 49, 255), Colour.new(14, 203, 73, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255), Colour.new(236, 235, 6, 255), Colour.new(204, 232, 12, 255), Colour.new(172, 229, 18, 255), Colour.new(141, 227, 24, 255), Colour.new(109, 224, 30, 255), Colour.new(78, 222, 36, 255), Colour.new(46, 219, 42, 255), Colour.new(14, 216, 48, 255), Colour.new(245, 245, 245, 255),
    Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255), Colour.new(245, 245, 245, 255)
  ]
end

def fixture_draw_rectangle_lines
  w = RAYWHITE
  r = RED
  [
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, r, r, r, r, w, w, w, w,
    w, w, r, w, w, r, w, w, w, w,
    w, w, r, w, w, r, w, w, w, w,
    w, w, r, w, w, r, w, w, w, w,
    w, w, r, r, r, r, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w
  ]
end

def fixture_draw_rectangle_lines_ex
  w = RAYWHITE
  r = RED
  [
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, w, r, r, r, r, r, r, r, r,
    w, w, r, r, r, r, r, r, r, r,
    w, w, r, r, w, w, w, w, r, r,
    w, w, r, r, w, w, w, w, r, r,
    w, w, r, r, w, w, w, w, r, r,
    w, w, r, r, w, w, w, w, r, r,
    w, w, r, r, r, r, r, r, r, r,
    w, w, r, r, r, r, r, r, r, r
  ]
end

def fixture_draw_rectangle_pro
  w = RAYWHITE
  r = RED
  [
    w, w, w, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w,
    w, r, w, w, w, w, w, w, w, w,
    r, r, r, w, w, w, w, w, w, w,
    r, r, r, r, w, w, w, w, w, w,
    r, r, r, r, r, w, w, w, w, w,
    r, r, r, r, r, w, w, w, w, w,
    r, r, r, r, w, w, w, w, w, w,
    w, r, r, w, w, w, w, w, w, w,
    w, w, w, w, w, w, w, w, w, w
  ]
end

def fixture_draw_rectangle_rounded
  w = RAYWHITE
  r = RED
  [
    w, w, w, w, w, w, w, w, w, w,
    w, w, r, r, r, r, r, r, w, w,
    w, r, r, r, r, r, r, r, r, w,
    w, r, r, r, r, r, r, r, r, w,
    w, r, r, r, r, r, r, r, r, w,
    w, r, r, r, r, r, r, r, r, w,
    w, r, r, r, r, r, r, r, r, w,
    w, r, r, r, r, r, r, r, r, w,
    w, w, r, r, r, r, r, r, w, w,
    w, w, w, w, w, w, w, w, w, w
  ]
end

def fixture_draw_rectangle_rounded_lines
  w = RAYWHITE
  r = RED
  [
    w, w, r, r, r, r, r, r, w, w,
    w, r, r, r, r, r, r, r, r, w,
    r, r, w, w, w, w, w, w, r, r,
    r, r, w, w, w, w, w, w, r, r,
    r, r, w, w, w, w, w, w, r, r,
    r, r, w, w, w, w, w, w, r, r,
    r, r, w, w, w, w, w, w, r, r,
    r, r, w, w, w, w, w, w, r, r,
    w, r, r, r, r, r, r, r, r, w,
    w, w, r, r, r, r, r, r, w, w
  ]
end
