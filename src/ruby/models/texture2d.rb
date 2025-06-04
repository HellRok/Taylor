# The Texture2D class is most often used for drawing sprites.
class Texture2D
  # @return [Integer]
  attr_reader :id, :width, :height, :mipmaps, :format

  # Return the object represented by a Hash.
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

  # Draws the texture segment defined by source at the given destination,
  # rotated around the origin in the specified colour.
  # @param source [Rectangle] If not defined it defaults to the full image.
  # @param destination [Rectangle] If not defined it defaults to source.
  # @param origin [Vector2]
  # @param rotation [Integer] In degrees.
  # @param colour [Colour]
  # @return [nil]
  def draw(source: Rectangle[0, 0, width, height], destination: nil, origin: Vector2::ZERO, rotation: 0, colour: Colour::WHITE)
    destination ||= source
    draw_texture_pro(
      self,
      source,
      destination,
      origin,
      rotation,
      colour
    )
  end

  # Generates mipmaps for the {Texture2D}.
  # @return [Integer]
  def generate_mipmaps
    generate_texture_mipmaps(self)
  end

  # A method used to generate the mock data for Raylib.
  #
  # @example Basic usage
  #   Taylor::Raylib.mock_call(
  #     "LoadTexture",
  #     Texture2D(id: 1, width: 10, height: 15, mipmaps: 2, format: 0)
  #   )
  #
  # @param id [Integer]
  # @param width [Integer]
  # @param height [Integer]
  # @param mipmaps [Integer]
  # @param format [Integer]
  # @return [String]
  def self.mock_return(id: 1, width: 10, height: 15, mipmaps: 2, format: 0)
    [id, width, height, mipmaps, format].map(&:to_s).join(" ")
  end

  # Used for alerting the user if the texture was not found at the specified path.
  class NotFoundError < StandardError; end

  # @!group Texture filters

  # No filter, just pixel approximation.
  NO_FILTER = 0
  # Linear filtering.
  BILINEAR = 1
  # Trilinear filtering (linear with mipmaps).
  TRILINEAR = 2
  # Anisotropic filtering 4x.
  ANISOTROPIC_4X = 3
  # Anisotropic filtering 8x.
  ANISOTROPIC_8X = 4
  # Anisotropic filtering 16x.
  ANISOTROPIC_16X = 5

  # @!endgroup
end
