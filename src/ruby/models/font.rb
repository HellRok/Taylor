# The Font class is used for displaying TTF fonts.
#
# @example Basic usage
#   font = Font.new("./assets/comic_sans.ttf", size: 16)
#
#   font.draw("Hello", x: 16, y: 12, colour: Colour::GREEN)
#
#   position = Vector2[30, 42]
#   font.draw("Hello", position: position, colour: Colour::GREEN)
#
#   font.unload
class Font
  # @return [Integer]
  attr_reader :size, :glyph_count, :glyph_padding, :texture

  # Return the object represented by a Hash
  #
  # @example Basic usage
  #   font = Font.new("./assets/my_font.ttf", size: 16)
  #
  #   p font.to_h
  #
  #   # => {
  #   #      :size=>16,
  #   #      :glyph_count=>95,
  #   #      :glyph_padding=>4,
  #   #      :texture=>{
  #   #        :id=>3.0,
  #   #        :width=>512.0,
  #   #        :height=>512.0,
  #   #        :mipmaps=>1.0,
  #   #        :format=>2.0
  #   #      }
  #   #    }
  #
  #   font.unload
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
  # {Texture2D::NO_FILTER}, but otherwise you'll want to set it to something
  # nicer.
  #
  # @example Setting the filtering of a texture to anisotropic
  #   font = Font.new("./assets/windings.ttf")
  #   font.filter = Texture2D::ANISOTROPIC_16X
  #
  # @param val [Integer] What sort of filtering to apply, valid options are:
  #   {Texture2D::NO_FILTER}, {Texture2D::BILINEAR}, {Texture2D::TRILINEAR},
  #   {Texture2D::ANISOTROPIC_4X}, {Texture2D::ANISOTROPIC_8X}, or
  #   {Texture2D::ANISOTROPIC_16X}.
  # @return [Integer]
  # @raise [ArgumentError]
  def filter=(val)
    texture.generate_mipmaps
    texture.filter = val
  end

  # A method used to generate the mock data for Raylib.
  #
  # @example Basic usage
  #   Taylor::Raylib.mock_call(
  #     "GetFontDefault",
  #     Font.mock_return(size: 10, glyph_count: 224, glyph_padding: 0)
  #   )
  #
  # @param size [Integer]
  # @param glyph_count [Integer]
  # @param glyph_padding [Integer]
  # @return [String]
  def self.mock_return(size: 0, glyph_count: 0, glyph_padding: 0)
    [size, glyph_count, glyph_padding].map(&:to_s).join(" ")
  end

  # Used for alerting the user if the font was not found at the specified path.
  class NotFoundError < StandardError; end
end
