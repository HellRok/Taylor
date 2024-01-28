class Font
  # Creates a new instance of Font
  # @param size [Integer]
  # @param glyph_count [Integer]
  # @return [Font]
  def initialize(path, size: 32, glyph_count: 95)
    # mrb_Font_initialize
    # src/mruby_integration/models/font.cpp
    Font.new
  end
end
