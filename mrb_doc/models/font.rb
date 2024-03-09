class Font
  # Returns the default built in {Font}. You may not want to {unload} this one!
  #
  # @exmaple Using the default font.
  #   Font.default.draw("Hello!")
  #
  # @return [Font]
  def self.default
    # mrb_Font_default
    # src/mruby_integration/models/font.cpp
    Font.new
  end

  # Loads a font file from the disk. If the file does not exist, it will
  # raise a {Font::NotFound} error.
  #
  # Currently only TTF files are supported.
  #
  # @example Basic usage.
  #   font = Font.new("/assets/my_cool_font.ttf", size: 16)
  #
  # @param path [String]
  # @param size [Integer]
  # @param glyph_count [Integer]
  # @return [Font]
  # @raise [Font::NotFound]
  def initialize(path, size: 32, glyph_count: 95)
    # mrb_Font_initialize
    # src/mruby_integration/models/font.cpp
    Font.new
  end

  # Draw the text to the screen using the loaded {Font}.
  #
  # @example Drawing text on screen using a custom font.
  #   font = Font.new("/assets/my_cool_font.ttf", size: 16)
  # 
  #   font.draw("Hello", x: 15, y: 12, colour: Colour::BLUE)
  #
  #   position = Vector[80, 90]
  #   font.draw("Hello", position: position, colour: Colour::BLUE)
  #
  #   font.unload
  #
  # @param text [String] The text to draw on the screen.
  # @param size [Float]
  # @param spacing [Float] How much spacing to have between letters.
  # @param x [Float]
  # @param y [Float]
  # @param position [Vector2]
  # @param colour [Colour]
  # @return [nil]
  def draw(text, size: self.size, spacing: 0, x: 0, y: 0, position: Vector2[x, y], colour: Colour::BLACK)
    # mrb_Font_draw
    # src/mruby_integration/models/font.cpp
    nil
  end

  # Returns the measurements of the text if drawn by the {Font}.
  #
  # @example Measuring a string.
  #   font = Font.new("/assets/my_cool_font.ttf", size: 16)
  #
  #   hello_size = font.measure("Hello")
  #
  #   puts hello_size.width # => 33
  #   puts hello_size.height # => 16
  #
  #   font.unload
  #
  # @param text [String] The text to measure.
  # @param size [Float]
  # @param spacing [Float] How much spacing to have between letters.
  # @return [Vector2]
  def measure(text, size: self.size, spacing: 0)
    # mrb_Font_measure
    # src/mruby_integration/models/font.cpp
    Vector2[33, 16]
  end

  # Unloads the {Font} from memory.
  #
  # @example Basic usage.
  #   font = Font.new("/assets/my_cool_font.ttf", size: 16)
  #   font.unload
  #
  # @return [nil]
  def unload
    # mrb_Font_unload
    # src/mruby_integration/models/font.cpp
    nil
  end

  # Checks if the font is loaded and ready to go.
  # @return [Boolean]
  def ready?
    # mrb_Font_ready
    # src/mruby_integration/models/font.cpp
    true
  end

  # Creates an {Image} of the text using the {Font}.
  #
  # @example Creating an image from the string "Hello".
  #   font = Font.new("/assets/my_cool_font.ttf", size: 16)
  #
  #   image = font.to_image("Hello", colour: Colour::PINK)
  #
  #   image.export("my_cool_text.jpg")
  #
  #   font.unload
  #   image.unload
  #
  # @param text [String] The text to turn into an {Image}.
  # @param size [Integer]
  # @param spacing [Integer]
  # @param colour [Colour]
  # @return [Image]
  def to_image(text, size: 32, spacing: 0, colour: BLACK)
    # mrb_Font_to_image
    # src/mruby_integration/models/font.cpp
    Image.new
  end
end
