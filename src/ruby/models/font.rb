class Font
  attr_reader :base_size, :glyph_count, :glyph_padding, :texture

  def to_h
    {
      base_size: base_size,
      glyph_count: glyph_count,
      glyph_padding: glyph_padding,
      texture: texture.to_h,
    }
  end

  def self.load(path, size: 32, char_count: 100)
    raise Font::NotFound.new("Could not find font at path \"#{path}\"") unless File.exist?(path)
    load_font_ex(path, size, char_count)
  end

  def unload
    unload_font(self)
  end

  def draw(text, position: Vector2::ZERO, size: 32, padding: 0, colour: BLACK)
    draw_text_ex(self, text, position, size, padding, colour)
  end

  def measure(text, size: 32, padding: 0)
    measure_text_ex(self, text, size, padding)
  end

  def to_image(text, size: 32, padding: 0, colour: BLACK)
    image_text_ex(self, text, size, padding, colour)
  end

  def filter=(val)
    texture.generate_mipmaps
    texture.filter = val
  end

  class NotFound < StandardError; end
end
