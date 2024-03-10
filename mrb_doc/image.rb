# Draws the specified portion of the source image into the specified region of
# the destination image.
# @param destination [Image]
# @param source [Image]
# @param source_rectangle [Rectangle]
# @param destination_rectangle [Rectangle]
# @param colour [Colour]
# @return [nil]
def image_draw!(destination, source, source_rectangle, destination_rectangle, colour)
  # mrb_image_draw
  # src/mruby_integration/image.cpp
  nil
end

# Returns an Image object with the screen data.
# @return [Image]
def get_screen_data
  # mrb_get_screen_data
  # src/mruby_integration/image.cpp
  Image.new
end
