# Loads an image from a file
# @param path [String]
# @return [Image]
def load_image(path)
  # mrb_load_image
  # src/mruby_integration/image.cpp
  Image.new
end

# Unloads an image
# @param image [Image]
# @return [nil]
def unload_image(image)
  # mrb_unload_image
  # src/mruby_integration/image.cpp
  nil
end

# Exports an image to a file
# @param image [Image]
# @param path [String]
# @return [nil]
def export_image(image, path)
  # mrb_export_image
  # src/mruby_integration/image.cpp
  nil
end

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

# Returns an Image object with the screen data
# @return [Image]
def get_screen_data()
  # mrb_get_screen_data
  # src/mruby_integration/image.cpp
  Image.new
end
