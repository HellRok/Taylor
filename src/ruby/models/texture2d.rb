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
