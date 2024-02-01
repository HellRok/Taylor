# Draws the current frame rate at the passed in x and y coordinates.
# @param x [Integer]
# @param y [Integer]
# @return [nil]
def draw_fps(x, y)
  # mrb_draw_fps
  # src/mruby_integration/text.cpp
  nil
end

# Returns the size of the text for the given font
# @param font [Font] Which font to draw with
# @param text [String] The text to put on the screen
# @param font_size [Integer]
# @param font_padding [Integer]
# @return [Vector2]
def measure_text_ex(font, text, font_size, font_padding)
  # mrb_measure_text_ex
  # src/mruby_integration/text.cpp
  Vector2.new(32, 12)
end
