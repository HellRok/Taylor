# Generates a new image of width by height in the specified colour.
# @param width [Integer]
# @param height [Integer]
# @param colour [Colour]
# @return [Image]
def generate_image_colour(width, height, colour)
  # mrb_generate_image_colour
  # src/mruby_integration/image.cpp
  Image.new
end

# Copies an image to a new object
# @param image [Image]
# @return [Image]
def image_copy(image)
  # mrb_image_copy
  # src/mruby_integration/image.cpp
  Image.new
end

# Returns a subsection of an image
# @param image [Image]
# @param source [Rectangle]
# @return [Image]
def image_from_image(image, source)
  # mrb_image_from_image
  # src/mruby_integration/image.cpp
  Image.new
end

# Creates an image from the font
# @param font [Font] Which font to draw with
# @param text [String] The text to put on the screen
# @param font_size [Integer]
# @param font_padding [Integer]
# @param colour [Colour]
# @return [Image]
def image_text_ex(font, text, font_size, font_padding, colour)
  # mrb_image_text_ex
  # src/mruby_integration/image.cpp
  Image.new
end

# Resizes the image using a bicubic scaling algorithm. Useful for things like
# photos, not great for pixel art.
# @param image [Image]
# @param width [Integer]
# @param height [Integer]
# @return [nil]
def image_resize!(image, width, height)
  # mrb_image_resize
  # src/mruby_integration/image.cpp
  nil
end

# Resizes the image using a nearest-neighbour scaling algorithm. Useful for things like
# pixel art, not great for photos.
# @param image [Image]
# @param width [Integer]
# @param height [Integer]
# @return [nil]
def image_resize_nearest_neighbour!(image, width, height)
  # mrb_image_resize_nearest_neighbour
  # src/mruby_integration/image.cpp
  nil
end

# Crops the image to the section in the rectangle
# @param image [Image]
# @param rectangle [Rectangle]
# @return [nil]
def image_crop!(image, rectangle)
  # mrb_image_crop
  # src/mruby_integration/image.cpp
  nil
end

# Applies the alpha of the mask to the image
# @param image [Image]
# @param alpha_mask [Image]
# @return [nil]
def image_alpha_mask!(image, alpha_mask)
  # mrb_image_alpha_mask
  # src/mruby_integration/image.cpp
  nil
end

# Pre-multiplies the alpha for the image
# @param image [Image]
# @return [nil]
def image_alpha_premultiply!(image)
  # mrb_image_alpha_premultiply
  # src/mruby_integration/image.cpp
  nil
end

# Flips the image vertically
# @param image [Image]
# @return [nil]
def image_flip_vertical!(image)
  # mrb_image_flip_vertical
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

# Flips the image horizontally
# @param image [Image]
# @return [nil]
def image_flip_horizontal!(image)
  # mrb_image_flip_horizontal
  # src/mruby_integration/image.cpp
  nil
end

# Rotates the image clockwise 90 degrees
# @param image [Image]
# @return [nil]
def image_rotate_cw!(image)
  # mrb_image_rotate_cw
  # src/mruby_integration/image.cpp
  nil
end

# Rotates the image counter-clockwise 90 degrees
# @param image [Image]
# @return [nil]
def image_rotate_ccw!(image)
  # mrb_image_rotate_ccw
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
