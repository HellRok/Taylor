# The Font class is used for displaying TTF fonts
class Font
  # @return [Integer]
  attr_reader :base_size, :glyph_count, :glyph_padding

  # Creates a new instance of Font
  # @param base_size [Integer]
  # @param glyph_count [Integer]
  # @param glyph_padding [Integer]
  # @return [Font]
  def initialize(base_size, glyph_count, glyph_padding)
    # mrb_Font_initialize
    # src/mruby_integration/models/font.cpp
    Font.new
  end

  def base_size=(base_size)
    # mrb_Font_base_size
    # src/mruby_integration/models/font.cpp
    10
  end

  def glyph_count=(glyph_count)
    # mrb_Font_glyph_count
    # src/mruby_integration/models/font.cpp
    95
  end

  def glyph_padding=(glyph_padding)
    # mrb_Font_glyph_padding
    # src/mruby_integration/models/font.cpp
    4
  end

  # Return the object represented by a Hash
  # @return [Hash]
  def to_h
    # src/mruby_integration/models/font.cpp
    Hash.new
  end

  # Loads the font from the specified path
  # @param path [String]
  # @param size [Integer]
  # @param char_count [Integer]
  # @raise [Font::NotFound] If the file specified by path doesn't exist
  # @return [Font]
  def self.load(path, size: 32, char_count: 100)
    # src/mruby_integration/models/font.cpp
    Font.new
  end

  # Unloads the font from memory
  # @return [nil]
  def unload
    # src/mruby_integration/models/font.cpp
    nil
  end

  # Draws the text at the given position, size, padding, and colour
  # @param text [String]
  # @param position [Vector2]
  # @param size [Integer]
  # @param padding [Integer]
  # @param colour [Colour]
  # @return [nil]
  def draw(text, position: Vector2::ZERO, size: 32, padding: 0, colour: BLACK)
    # src/mruby_integration/models/font.cpp
    nil
  end

  # Returns the size of the text
  # @param text [String]
  # @param size [Integer]
  # @param padding [Integer]
  # @raise [Font::NotFound] If the file specified by path doesn't exist
  # @return [Vector2]
  def measure(text, size: 32, padding: 0)
    # src/mruby_integration/models/font.cpp
    Vector2.new
  end

  # Creates an image from the font
  # @param text [String] The text to put on the screen
  # @param font_size [Integer]
  # @param font_padding [Integer]
  # @param colour [Colour]
  # @return [Image]
  def to_image(text, font_size: 32, font_padding: 0, colour: BLACK)
    # mrb_image_text_ex
    # src/mruby_integration/image.cpp
    Image.new
  end

  # Used for alerting the user the font was not found at the specified path
  class NotFound < StandardError; end
end
