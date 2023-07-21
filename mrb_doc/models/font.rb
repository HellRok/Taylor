class Font
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
end
