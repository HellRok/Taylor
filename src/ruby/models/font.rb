# The Font class is used for displaying TTF fonts
class Font
  # @return [Integer]
  attr_reader :size, :glyph_count, :glyph_padding, :texture

  # Return the object represented by a Hash
  # @return [Hash]
  def to_h
    {
      size: size,
      glyph_count: glyph_count,
      glyph_padding: glyph_padding,
      texture: texture.to_h
    }
  end

  # Draws the text at the given position, size, padding, and colour
  # @param text [String]
  # @param position [Vector2]
  # @param size [Integer]
  # @param padding [Integer]
  # @param colour [Colour]
  # @return [nil]
  def draw(text, position: Vector2::ZERO, size: 32, padding: 0, colour: BLACK)
    draw_text_ex(self, text, position, size, padding, colour)
  end

  # Returns the size of the text
  # @param text [String]
  # @param size [Integer]
  # @param padding [Integer]
  # @return [Vector2]
  def measure(text, size: 32, padding: 0)
    measure_text_ex(self, text, size, padding)
  end

  # Creates an image from the font
  # @param text [String] The text to put on the screen
  # @param size [Integer]
  # @param padding [Integer]
  # @param colour [Colour]
  # @return [Image]
  def to_image(text, size: 32, padding: 0, colour: BLACK)
    image_text_ex(self, text, size, padding, colour)
  end

  # Sets the filtering and generates mipmaps for the {Texture2D} used behind the {Font}
  # @param val [Integer] What sort of filtering to apply, valid options are: {TEXTURE_FILTER_POINT}, {TEXTURE_FILTER_BILINEAR}, {TEXTURE_FILTER_TRILINEAR}, {TEXTURE_FILTER_ANISOTROPIC_4X}, {TEXTURE_FILTER_ANISOTROPIC_8X}, or {TEXTURE_FILTER_ANISOTROPIC_16X}
  # @return [Integer]
  def filter=(val)
    texture.generate_mipmaps
    texture.filter = val
  end

  # Used for alerting the user the font was not found at the specified path
  class NotFound < StandardError; end
end
