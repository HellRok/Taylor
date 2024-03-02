# Pre-multiplies the alpha for the image
# @param image [Image]
# @return [nil]
def image_alpha_premultiply!(image)
  # mrb_image_alpha_premultiply
  # src/mruby_integration/image.cpp
  nil
end

# Generates mipmaps for the specified image
# @param image [Image]
# @return [nil]
def image_mipmaps!(image)
  # mrb_image_mipmaps
  # src/mruby_integration/image.cpp
  nil
end

# Tints the image with the specified colour
# @param image [Image]
# @param colour [Colour]
# @return [nil]
def image_colour_tint!(image, colour)
  # mrb_image_colour_tint
  # src/mruby_integration/image.cpp
  nil
end

# Inverts the colours of the image
# @param image [Image]
# @return [nil]
def image_colour_invert!(image)
  # mrb_image_colour_invert
  # src/mruby_integration/image.cpp
  nil
end

# Converts the image to grayscale
# @param image [Image]
# @return [nil]
def image_colour_grayscale!(image)
  # mrb_image_colour_grayscale
  # src/mruby_integration/image.cpp
  nil
end

# Change the contrast of the image
# @param image [Image]
# @param contrast [Float] a value between -100 and 100
# @return [nil]
def image_colour_contrast!(image, contrast)
  # mrb_image_colour_contrast
  # src/mruby_integration/image.cpp
  nil
end

# Change the brightness of the image
# @param image [Image]
# @param brightness [Float] a value between -255 and 255
# @return [nil]
def image_colour_brightness!(image, brightness)
  # mrb_image_colour_brightness
  # src/mruby_integration/image.cpp
  nil
end

# Replace the old Colour with the new Colour
# @param image [Image]
# @param old_colour [Colour]
# @param new_colour [Colour]
# @return [nil]
def image_colour_replace!(image, old_colour, new_colour)
  # mrb_image_colour_replace
  # src/mruby_integration/image.cpp
  nil
end

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

# Returns an Image object with the screen data
# @return [Image]
def get_screen_data
  # mrb_get_screen_data
  # src/mruby_integration/image.cpp
  Image.new
end
