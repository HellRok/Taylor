# A class for holding image data.
class Image
  # @return [Integer]
  attr_reader :width, :height, :mipmaps, :format

  # Return the object represented by a Hash.
  # @return [Hash]
  def to_h
    {
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
  #     "LoadImage",
  #     Image.mock_return(width: 10, height: 10, mipmaps: 1, format: 0)
  #   )
  #
  # @param width [Integer]
  # @param height [Integer]
  # @param mipmaps [Integer]
  # @param format [Integer]
  # @return [String]
  def self.mock_return(width: 10, height: 10, mipmaps: 1, format: 0)
    [width, height, mipmaps, format].map(&:to_s).join(" ")
  end

  # Used for alerting the user if the image was not found at the specified path.
  class NotFound < StandardError; end
end
