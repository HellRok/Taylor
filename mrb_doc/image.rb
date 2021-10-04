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

# Returns an Image object with the screen data
# @return [Image]
def get_screen_data()
  # mrb_get_screen_data
  # src/mruby_integration/image.cpp
  Image.new
end
