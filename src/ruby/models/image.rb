# A class for holding image data
class Image
  # @return [Integer]
  attr_reader :width, :height, :mipmaps, :format

  # Return the object represented by a Hash
  # @return [Hash]
  def to_h
    {
      width: width,
      height: height,
      mipmaps: mipmaps,
      format: format
    }
  end

  # Used for alerting the user the image was not found at the specified path
  class NotFound < StandardError; end
end
