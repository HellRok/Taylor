# Loads an image from a file
# @param path [String]
# @return [Image]
def load_image(path)
  # mrb_load_image
  # src/mruby_integration/textures.cpp
  Image.new
end

# Unloads an image
# @param image [Image]
# @return [nil]
def unload_image(image)
  # mrb_unload_image
  # src/mruby_integration/images.cpp
  nil
end

# Loads a texture from a file
# @param path [String]
# @return [Texture2D]
def load_texture(path)
  # mrb_load_texture
  # src/mruby_integration/textures.cpp
  Texture2D.new
end

# Unloads a texture
# @param texture [Texture2D]
# @return [nil]
def unload_texture(texture)
  # mrb_unload_texture
  # src/mruby_integration/textures.cpp
  nil
end

# Draws a texture, the colour will apply a tint and alpha levels
# @param texture [Texture2D]
# @param x [Integer]
# @param y [Integer]
# @param colour [Colour]
# @return [nil]
def draw_texture(texture, x, y, colour)
  # mrb_draw_texture
  # src/mruby_integration/textures.cpp
  nil
end

# Draws a section of texture with the specified rotation to the scaled to the
# destination rectangle, the colour will apply a tint and alpha levels
# @param texture [Texture2D]
# @param source [Rectangle]
# @param destination [Rectangle]
# @param origin [Vector2]
# @param rotation [Float]
# @param colour [Colour]
# @return [nil]
def draw_texture_pro(texture, source, destination, origin, rotation, colour)
  # mrb_draw_texture_pro
  # src/mruby_integration/textures.cpp
  nil
end

# Returns a new colour which is a faded version of the original
# @param colour [Colour
# @return [Colour]
def fade(colour)
  # mrb_fade
  # src/mruby_integration/textures.cpp
  Colour.new
end

# Returns an Image object with the screen data
# @return [Image]
def get_screen_data()
  # mrb_get_screen_data
  # src/mruby_integration/textures.cpp
  Image.new
end
