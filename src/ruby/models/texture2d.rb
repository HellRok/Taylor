class Texture2D
  attr_reader :id, :width, :height, :mipmaps, :format

  def to_h
    {
      id: id,
      width: width,
      height: height,
      mipmaps: mipmaps,
      format: format,
    }
  end

  def self.load(path)
    raise Texture2D::NotFound.new("Could not find file at path \"#{path}\"") unless File.exist?(path)
    load_texture(path)
  end

  def unload
    unload_texture(self)
  end

  def draw(source: nil, destination: nil, origin: Vector2::ZERO, rotation: 0, colour: WHITE)
    @source = source unless source.nil?
    @source ||= Rectangle.new(0, 0, self.width, self.height)
    @destination = destination unless destination.nil?
    @destination ||= @source

    draw_texture_pro(
      self,
      @source,
      @destination,
      origin,
      rotation,
      colour
    )
  end

  def filter=(val)
    set_texture_filter(self, val)
  end

  def generate_mipmaps
    generate_texture_mipmaps(self)
  end

  class NotFound < StandardError; end
end

TEXTURE_FILTER_POINT = 0           # No filter, just pixel approximation
TEXTURE_FILTER_BILINEAR = 1        # Linear filtering
TEXTURE_FILTER_TRILINEAR = 2       # Trilinear filtering (linear with mipmaps)
TEXTURE_FILTER_ANISOTROPIC_4X = 3  # Anisotropic filtering 4x
TEXTURE_FILTER_ANISOTROPIC_8X = 4  # Anisotropic filtering 8x
TEXTURE_FILTER_ANISOTROPIC_16X = 5 # Anisotropic filtering 16x
