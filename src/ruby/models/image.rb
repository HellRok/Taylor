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

  # Copies the image to a new object. If `source` is specified it'll only be
  # that section of the image that is returned.
  # @param source [Rectangle]
  # @return [Image]
  def copy(source: nil)
    if source
      image_from_image(self, source)
    else
      image_copy(self)
    end
  end

  # Returns a texture of the image
  # @return [Texture2D]
  def to_texture
    load_texture_from_image(self)
  end

  # Resizes the image, defaults to using the nearest neighbour algorithm which
  # is useful for pixel art.
  # @param width [Integer]
  # @param height [Integer]
  # @param scaling [Symbol] Valid options are :nearest_neighbour and :bicubic
  # @return [Image]
  def resize!(width:, height:, scaling: :nearest_neighbour)
    case scaling
    when :bicubic
      image_resize!(self, width, height)
    when :nearest_neighbour
      image_resize_nearest_neighbour!(self, width, height)
    else
      raise ArgumentError.new("Unknown scaler \"#{scaling}\", valid options are: :bicubic, :nearest_neighbour")
    end

    self
  end

  # Crops the image to the section in the rectangle
  # @param rectangle [Rectangle]
  # @return [Image]
  def crop!(rectangle)
    image_crop!(self, rectangle)
    self
  end

  # Applies the alpha of the mask to the image
  # @param mask [Image]
  # @return [Image]
  def alpha_mask=(mask)
    image_alpha_mask!(self, mask)
  end

  # Pre-multiplies the alpha for the image
  # @return [Image]
  def premultiply_alpha!
    image_alpha_premultiply!(self)
    self
  end

  # Generates mipmaps for the image
  # @return [Image]
  def generate_mipmaps!
    image_mipmaps!(self)
    self
  end

  # Flips the image upside down
  # @return [Image]
  def flip_vertical!
    image_flip_vertical!(self)
    self
  end

  # Flips the image sideways
  # @return [Image]
  def flip_horizontal!
    image_flip_horizontal!(self)
    self
  end

  # Rotates the image either clockwise or counter-clockwise
  # @param direction [Symbol] Valid options are :cw and :ccw
  # @raise [ArgumentError] If the direction is invalid
  # @return [Image]
  def rotate!(direction = :cw)
    raise ArgumentError.new("Value must be :ccw, :cw, or nil") unless [:ccw, :cw, nil].include?(direction)

    if direction == :ccw
      image_rotate_ccw!(self)
    else
      image_rotate_cw!(self)
    end
    self
  end

  # Tints the image with the specified colour
  # @param colour [Colour]
  # @return [nil]
  def tint!(colour)
    image_colour_tint!(self, colour)
    self
  end

  # Inverts the colours of the image
  # @return [nil]
  def invert!
    image_colour_invert!(self)
    self
  end

  # Converts the image to grayscale
  # @return [nil]
  def grayscale!
    image_colour_grayscale!(self)
    self
  end

  # Change the contrast of the image
  # @param contrast [Float] a value between -100 and 100
  # @raise [ArgumentError] If the contrast is outside of the allowed range
  # @return [nil]
  def contrast!(contrast)
    raise ArgumentError.new("Must be within (-100..100)") if contrast < -100 || contrast > 100

    image_colour_contrast!(self, contrast)
    self
  end

  # Replace the old Colour with the new Colour
  # @param old_colour [Colour]
  # @param new_colour [Colour]
  # @return [nil]
  def replace!(old_colour, new_colour)
    image_colour_replace!(self, old_colour, new_colour)
    self
  end

  # Change the brightness of the image
  # @param brightness [Float] a value between -255 and 255
  # @raise [ArgumentError] If the brightness is outside of the allowed range
  # @return [nil]
  def brightness!(brightness)
    raise ArgumentError.new("Must be within (-255..255)") if brightness < -255 || brightness > 255

    image_colour_brightness!(self, brightness)
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

  # Generates a new image of width by height in the specified colour.
  # @param width [Integer]
  # @param height [Integer]
  # @param colour [Colour]
  # @return [Image]
  def self.generate(width:, height:, colour: Colour::RAYWHITE)
    generate_image_colour(width, height, colour)
  end

  # Used for alerting the user the image was not found at the specified path
  class NotFound < StandardError; end
end
