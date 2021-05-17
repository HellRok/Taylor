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
end
