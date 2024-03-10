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

  # Replace the old Colour with the new Colour
  # @param old_colour [Colour]
  # @param new_colour [Colour]
  # @return [nil]
  def replace!(old_colour, new_colour)
    image_colour_replace!(self, old_colour, new_colour)
    self
  end

  # Draws the specified portion of the image into the specified region of the
  # this image.
  # @param image [Image]
  # @param source [Rectangle] if left blank, will use the whole image
  # @param destination [Rectangle] if left blank, will draw into the top left corner
  # @param colour [Colour] if left blank, no tinting is applied
  # @return [nil]
  def draw!(image:, source: nil, destination: nil, colour: Colour::WHITE)
    source ||= Rectangle.new(0, 0, image.width, image.height)
    destination ||= Rectangle.new(0, 0, image.width, image.height)

    image_draw!(self, image, source, destination, colour)
    self
  end

  # Used for alerting the user the image was not found at the specified path
  class NotFound < StandardError; end
end
