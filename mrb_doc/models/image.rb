class Image
  # Generates a new {Image} of width by height in the specified colour.
  #
  # ```ruby
  # image = Image.generate(width: 128, height: 128, colour: Colour::ORANGE)
  # ```
  #
  # @param width [Integer]
  # @param height [Integer]
  # @param colour [Colour]
  # @return [Image]
  def self.generate(width:, height:, colour: Colour::BLANK)
    # mrb_Image_generate
    # src/mruby_integration/models/image.cpp
    Image.new
  end

  # Loads an image file off of the disk. If the file does not exist, it will
  # raise an {Image::NotFound} error.
  #
  # Supported image types are png, jpg, bmp, qoi, gif, dds, hdr.
  #
  # ```ruby
  # image = Image.new("/assets/image.png")
  # ```
  #
  # @param path [Integer]
  # @return [Image]
  # @raise [Image::NotFound]
  def initialize(path)
    # mrb_Image_initialize
    # src/mruby_integration/models/image.cpp
    Image.new
  end

  # Unloads the {Image} from memory.
  #
  # ```ruby
  # image = Image.new("/assets/image.png")
  # image.unload
  # ```
  #
  # @return [nil]
  def unload
    # mrb_Image_unload
    # src/mruby_integration/models/image.cpp
    nil
  end

  # Exports an {Image} to a file.
  #
  # ```ruby
  # image = Image.generate(width: 10, height: 10, colour: Colour::GREEN)
  # image.export("./my_green_image.png")
  # ```
  #
  # @param path [String]
  # @return [nil]
  def export(path)
    # mrb_Image_unload
    # src/mruby_integration/models/image.cpp
    nil
  end

  # Copies the image to a new object. If `source` is specified it'll only be
  # that section of the image that is returned.
  #
  # ```ruby
  # image = Image.new("./assets/my_cool_image.png")
  #
  # # This creates a copy of the whole image
  # copy = image.copy
  #
  # # This will only copy the portion x from 10 to 110, and y from 20 to 70
  # subsection = image.copy(source: Rectangle[10, 20, 100, 50])
  # ```
  #
  # @param source [Rectangle]
  # @return [Image]
  def copy(source: Rectangle[0, 0, width, height])
    # mrb_Image_copy
    # src/mruby_integration/models/image.cpp
    Image.new
  end

  # Returns an array containing the image data as an array of Colour objects
  # @return [Array<Colour>]
  def data
    # mrb_Image_get_data
    # src/mruby_integration/models/image.cpp
    [Colour.new]
  end
end
