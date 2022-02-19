# A class for holding image data
class Image
  # @return [Integer]
  attr_reader :width, :height, :mipmaps, :format

  # Creates a new instance of Image
  # @param width [Integer]
  # @param height [Integer]
  # @param mipmaps [Integer]
  # @param format [Integer]
  # @return [Image]
  def initialize(width, height, mipmaps, format)
    # mrb_Image_initialize
    # src/mruby_integration/models/image.cpp
    Image.new
  end

  def width=(width)
    # mrb_Image_set_width
    # src/mruby_integration/models/image.cpp
    640
  end

  def height=(height)
    # mrb_Image_set_height
    # src/mruby_integration/models/image.cpp
    480
  end

  def mipmaps=(mipmaps)
    # mrb_Image_set_mipmaps
    # src/mruby_integration/models/image.cpp
    1
  end

  def format=(format)
    # mrb_Image_set_format
    # src/mruby_integration/models/image.cpp
    1
  end

  # Returns an array containing the image data as an array of Colour objects
  # @return [Array<Colour>]
  def data
    # mrb_Image_get_data
    # src/mruby_integration/models/image.cpp
    [Colour.new]
  end

  # Return the object represented by a Hash
  # @return [Hash]
  def to_h
    # src/mruby_integration/models/image.cpp
    {
      width: width,
      height: height,
      mipmaps: mipmaps,
      format: format,
    }
  end

  # Loads an image from the specified path
  # @param path [String]
  # @raise [Image::NotFound] If the file specified by path doesn't exist
  # @return [Image]
  def self.load(path)
    # src/mruby_integration/models/image.cpp
    Image.new
  end

  # Unloads the texture from memory
  # @return [nil]
  def unload
    # src/mruby_integration/models/image.cpp
    nil
  end

  # Exports an image to a file
  # @param path [String]
  # @return [nil]
  def export(path)
    # src/mruby_integration/models/image.cpp
    nil
  end

  # Copies the image to a new object. If `source` is specified it'll only be
  # that section of the image that is returned.
  # @param source [Rectangle]
  # @return [Image]
  def copy(source: nil)
    # src/mruby_integration/models/image.cpp
    Image.new
  end

  # Returns a texture of the image
  # @return [Texture2D]
  def to_texture
    # src/mruby_integration/models/image.cpp
    Texture2D.new
  end

  # Resizes the image, defaults to using the nearest neighbour algorithm which
  # is useful for pixel art.
  # @param width [Integer]
  # @param height [Integer]
  # @param scaling [Symbol] Valid options are :nearest_neighbour and :bicubic
  # @return [Image]
  def resize!(width:, height:, scaling: :nearest_neighbour)
    # src/mruby_integration/models/image.cpp
    self
  end

  # Crops the image to the section in the rectangle
  # @param rectangle [Rectangle]
  # @return [Image]
  def crop!(rectangle)
    # src/mruby_integration/models/image.cpp
    self
  end

  # Applies the alpha of the mask to the image
  # @param mask [Image]
  # @return [Image]
  def alpha_mask=(mask)
    # src/mruby_integration/models/image.cpp
    self
  end

  # Pre-multiplies the alpha for the image
  # @return [Image]
  def premultiply_alpha!
    # src/mruby_integration/models/image.cpp
    self
  end

  # Flips the image upside down
  # @return [Image]
  def flip_vertical!
    # src/mruby_integration/models/image.cpp
    self
  end

  # Generates mipmaps for the image
  # @return [Image]
  def generate_mipmaps!
    # src/mruby_integration/models/image.cpp
    self
  end

  # Flips the image sideways
  # @return [Image]
  def flip_horizontal!
    # src/mruby_integration/models/image.cpp
    self
  end

  # Rotates the image either clockwise or counter-clockwise
  # @param [direction] Valid options are :cw and :ccw
  # @raise [ArgumentError] If the direction is invalid
  # @return [Image]
  def rotate!(direction = :cw)
    # src/mruby_integration/models/image.cpp
    self
  end

  # Tints the image with the specified colour
  # @param colour [Colour]
  # @return [nil]
  def tint!(colour)
    # src/mruby_integration/models/image.cpp
    self
  end

  # Generates a new image of width by height in the specified colour.
  # @param width [Integer]
  # @param height [Integer]
  # @param colour [Colour]
  # @return [Image]
  def self.generate(width:, height:, colour: RAYWHITE)
    # src/mruby_integration/models/image.cpp
    Image.new
  end

  # Used for alerting the user the image was not found at the specified path
  class NotFound < StandardError; end
end
