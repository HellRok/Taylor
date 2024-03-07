# Loads a texture from a file.
# @param path [String]
# @return [Texture2D]
def load_texture(path)
  # mrb_load_texture
  # src/mruby_integration/textures.cpp
  Texture2D.new
end

# Loads a texture from an image object.
# @param image [Image]
# @return [Texture2D]
def load_texture_from_image(image)
  # mrb_load_texture_from_image
  # src/mruby_integration/textures.cpp
  Texture2D.new
end

# Unloads a texture.
# @param texture [Texture2D]
# @return [nil]
def unload_texture(texture)
  # mrb_unload_texture
  # src/mruby_integration/textures.cpp
  nil
end

# Draws a texture, the colour will apply a tint and alpha levels.
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
# destination rectangle, the colour will apply a tint and alpha levels.
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

# Returns a new colour which is a faded version of the original.
# @param colour [Colour
# @return [Colour]
def fade(colour)
  # mrb_fade
  # src/mruby_integration/textures.cpp
  Colour.new
end

# Generates mipmaps for the {Texture2D}.
# @param texture [Texture2D]
# @return [nil]
def generate_texture_mipmaps(texture)
  # mrb_gen_texture_mipmaps
  # src/mruby_integration/textures.cpp
  nil
end

# Sets the filtering for the {Texture2D}.
# @param texture [Texture2D]
# @param filter [Integer] What sort of filtering to apply, valid options are: {TEXTURE_FILTER_POINT}, {TEXTURE_FILTER_BILINEAR}, {TEXTURE_FILTER_TRILINEAR}, {TEXTURE_FILTER_ANISOTROPIC_4X}, {TEXTURE_FILTER_ANISOTROPIC_8X}, or {TEXTURE_FILTER_ANISOTROPIC_16X}.
# @return [nil]
def set_texture_filter(texture, filter)
  # mrb_set_texture_filter
  # src/mruby_integration/textures.cpp
  nil
end
