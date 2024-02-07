# The Font class is used for displaying TTF fonts
#
# ```ruby
# font = Font.new("./assets/comic_sans.ttf", size: 16)
#
# font.draw("Hello", x: 16, y: 12, colour: Colour::GREEN)
#
# position = Vector2[30, 42]
# font.draw("Hello", position: position, colour: Colour::GREEN)
#
# font.unload
# ```
class Font
  # @return [Integer]
  attr_reader :size, :glyph_count, :glyph_padding, :texture

  # Return the object represented by a Hash
  #
  # ```ruby
  # font = Font.new("./assets/my_font.ttf", size: 16)
  #
  # p font.to_h
  # # => {
  # #      :size=>16,
  # #      :glyph_count=>95,
  # #      :glyph_padding=>4,
  # #      :texture=>{
  # #        :id=>3.0,
  # #        :width=>512.0,
  # #        :height=>512.0,
  # #        :mipmaps=>1.0,
  # #        :format=>2.0
  # #      }
  # #    }
  #
  # font.unload
  # ```
  #
  # @return [Hash]
  def to_h
    {
      size: size,
      glyph_count: glyph_count,
      glyph_padding: glyph_padding,
      texture: texture.to_h
    }
  end

  # Sets the filtering and generates mipmaps for the {Texture2D} used behind the {Font}.
  #
  # For pixel art fonts you'll want to leave it as default
  # {TEXTURE_FILTER_POINT}, but otherwise you'll want to set it to something
  # nicer.
  #
  # ```
  # font = Font.new("./assets/windings.ttf")
  # font.filter = TEXTURE_FILTER_ANISOTROPIC_16X
  # ```
  #
  # @param val [Integer] What sort of filtering to apply, valid options are: {TEXTURE_FILTER_POINT}, {TEXTURE_FILTER_BILINEAR}, {TEXTURE_FILTER_TRILINEAR}, {TEXTURE_FILTER_ANISOTROPIC_4X}, {TEXTURE_FILTER_ANISOTROPIC_8X}, or {TEXTURE_FILTER_ANISOTROPIC_16X}
  # @return [Integer]
  def filter=(val)
    texture.generate_mipmaps
    texture.filter = val
  end

  # Used for alerting the user the font was not found at the specified path
  class NotFound < StandardError; end
end
