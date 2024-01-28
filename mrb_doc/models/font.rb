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

  # Unloads the font from memory
  # @return [nil]
  def unload
    # mrb_Font_unload
    # src/mruby_integration/models/font.cpp
    nil
  end

  # Checks if the font is loaded and ready to go
  # @return [Boolean]
  def ready?
    # mrb_Font_ready
    # src/mruby_integration/models/font.cpp
    true
  end
end
