# The Font class is used for displaying TTF fonts
class Font
  # @return [Integer]
  attr_reader :base_size, :chars_count, :chars_padding

  # Creates a new instance of Font
  # @param base_size [Integer]
  # @param chars_count [Integer]
  # @param chars_padding [Integer]
  # @return [Font]
  def initialize(base_size, chars_count, chars_padding)
    # mrb_Font_initialize
    # src/mruby_integration/models/font.cpp
    Font.new
  end

  def base_size=(base_size)
    # mrb_Font_base_size
    # src/mruby_integration/models/font.cpp
    10
  end

  def chars_count=(chars_count)
    # mrb_Font_chars_count
    # src/mruby_integration/models/font.cpp
    95
  end

  def chars_padding=(chars_padding)
    # mrb_Font_chars_padding
    # src/mruby_integration/models/font.cpp
    4
  end

  # Return the object represented by a Hash
  # @return [Hash]
  def to_h
    # src/mruby_integration/models/font.cpp
    {
      base_size: base_size,
      chars_count: chars_count,
      chars_padding: chars_padding,
    }
  end
end

