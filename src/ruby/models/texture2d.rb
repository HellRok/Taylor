# The Texture2D class is most often used for drawing sprites.
class Texture2D
  # @return [Integer]
  attr_reader :id, :width, :height, :mipmaps, :format

  # Return the object represented by a Hash
  # @return [Hash]
  def to_h
    {
      id: id,
      width: width,
      height: height,
      mipmaps: mipmaps,
      format: format
    }
  end

  # Loads a texture from the specified path
  # @param path [String]
  # @raise [Texture2D::NotFound] If the file specified by path doesn't exist
  # @return [Texture2D]
  def self.load(path)
    raise Texture2D::NotFound.new("Could not find file at path \"#{path}\"") unless File.exist?(path)
    load_texture(path)
  end

  # Unloads the texture from memory
  # @return [nil]
  def unload
    unload_texture(self)
  end

  # Draws the texture segment defined by source at the given destination,
  # rotated around the origin in the specified colour.
  # If source is not defined it defaults to the full image.
  # If destination is not defined it defaults to source.
  # @param source [Rectangle]
  # @param destination [Rectangle]
  # @param origin [Vector2]
  # @param rotation [Integer] in degrees
  # @param colour [Colour]
  # @return [nil]
  def draw(source: nil, destination: nil, origin: Vector2::ZERO, rotation: 0, colour: WHITE)
    @source = source unless source.nil?
    @source ||= Rectangle.new(0, 0, width, height)
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

  # Sets the filtering for the {Texture2D}
  # @param val [Integer] What sort of filtering to apply, valid options are: {TEXTURE_FILTER_POINT}, {TEXTURE_FILTER_BILINEAR}, {TEXTURE_FILTER_TRILINEAR}, {TEXTURE_FILTER_ANISOTROPIC_4X}, {TEXTURE_FILTER_ANISOTROPIC_8X}, or {TEXTURE_FILTER_ANISOTROPIC_16X}
  # @return [Integer]
  def filter=(val)
    set_texture_filter(self, val)
  end

  # Generates mipmaps for the {Texture2D}
  # @return [Integer]
  def generate_mipmaps
    generate_texture_mipmaps(self)
  end

  # Used for alerting the user the texture was not found at the specified path
  class NotFound < StandardError; end
end

# No filter, just pixel approximation
TEXTURE_FILTER_POINT = 0
# Linear filtering
TEXTURE_FILTER_BILINEAR = 1
# Trilinear filtering (linear with mipmaps)
TEXTURE_FILTER_TRILINEAR = 2
# Anisotropic filtering 4x
TEXTURE_FILTER_ANISOTROPIC_4X = 3
# Anisotropic filtering 8x
TEXTURE_FILTER_ANISOTROPIC_8X = 4
# Anisotropic filtering 16x
TEXTURE_FILTER_ANISOTROPIC_16X = 5
