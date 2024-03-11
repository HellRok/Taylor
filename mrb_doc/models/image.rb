class Image
  # Generates a new {Image} of width by height in the specified colour.
  #
  # @example Basic usage
  #   image = Image.generate(width: 128, height: 128, colour: Colour::ORANGE)
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

  # Loads an image file from the disk. If the file does not exist, it will
  # raise an {Image::NotFound} error.
  #
  # Supported image formats are: PNG, JPG, BMP, QOI, GIF, DDS and HDR.
  #
  # @example Basic usage
  #   image = Image.new("/assets/image.png")
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
  # @example Basic usage
  #   image = Image.new("/assets/image.png")
  #   image.unload
  #
  # @return [nil]
  def unload
    # mrb_Image_unload
    # src/mruby_integration/models/image.cpp
    nil
  end

  # Exports an {Image} to a file.
  #
  # @example Basic usage
  #   image = Image.generate(width: 10, height: 10, colour: Colour::GREEN)
  #   image.export("./my_green_image.png")
  #
  # @param path [String]
  # @return [nil]
  def export(path)
    # mrb_Image_unload
    # src/mruby_integration/models/image.cpp
    nil
  end

  # Copies the image to a new object.
  #
  # @example Basic usage
  #   image = Image.new("./assets/my_cool_image.png")
  #
  #   # This creates a copy of the whole image
  #   copy = image.copy
  #
  #   # This will only copy the portion x from 10 to 110, and y from 20 to 70
  #   subsection = image.copy(source: Rectangle[10, 20, 100, 50])
  #
  # @param source [Rectangle] If specified, only this section of the image will be copied.
  # @return [Image]
  def copy(source: Rectangle[0, 0, width, height])
    # mrb_Image_copy
    # src/mruby_integration/models/image.cpp
    Image.new
  end

  # Resizes the image using one of the two scalers.
  #
  # `:nearest_neighbour` is useful for scaling up pixel art and works best in
  # exact integer scaling. And `:bicubic` is useful for scaling up normal
  # images and works well at any scaling.
  #
  # @example Scaling an image using the nearest-neighbour scaler
  #   image = Image.new("./assets/pixel_art.png")
  #   p [image.width, image.height] # => [8, 8]
  #
  #   # Nearest-neighbour is the default so no need to specify
  #   image.resize!(width: 16, height: 16)
  #   p [image.width, image.height] # => [16, 16]
  #
  # @example Scaling an image using the bicubic scaler
  #   image = Image.new("./assets/background.png")
  #   p [image.width, image.height] # => [1280, 720]
  #
  #   image.resize!(width: 1920, height: 1080, scaler: :bicubic)
  #   p [image.width, image.height] # => [1920, 1080]
  #
  # @param width [Integer]
  # @param height [Integer]
  # @param scaler [:nearest_neighbour, :bicubic]
  # @return [Image]
  # @raise [ArgumentError] When passed an invalid scaler.
  def resize!(width:, height:, scaler: :nearest_neighbour)
    # mrb_Image_resize_bang
    # src/mruby_integration/models/image.cpp
    self
  end

  # Crops the {Image} to the section specified by `source`.
  #
  # @example Basic usage
  #   image = Image.new("./assets/spritesheet.png")
  #   p [image.width, image.height] # => [64, 128]
  #
  #   image.crop!(source: Rectangle[8, 16, 8, 8])
  #   p [image.width, image.height] # => [8, 8]
  #
  # @param source [Rectangle]
  # @return [Image]
  def crop!(source: rectangle)
    # mrb_Image_crop_bang
    # src/mruby_integration/models/image.cpp
    self
  end

  # Applies the alpha mask to this {Image}.
  #
  # @example Basic usage
  #   image = Image.new("./assets/sprite.png")
  #   mask = Image.new("./assets/sprite_mask.png")
  #   image.alpha_mask!(mask)
  #
  # @param mask [Image]
  # @return [Image]
  def alpha_mask!(mask)
    # mrb_Image_alpha_mask_bang
    # src/mruby_integration/models/image.cpp
    self
  end

  # Flips the {Image} upside down.
  #
  # @example Basic usage
  #   sprite = Image.new("./assets/sprite.png")
  #   sprite.flip_vertically!
  #
  # @return [Image]
  def flip_vertically!
    # mrb_Image_flip_vertically_bang
    # src/mruby_integration/models/image.cpp
    self
  end

  # Flips the {Image} sideways.
  #
  # @example Basic usage
  #   sprite = Image.new("./assets/sprite.png")
  #   sprite.flip_horizontally!
  #
  # @return [Image]
  def flip_horizontally!
    # mrb_Image_flip_horizontally_bang
    # src/mruby_integration/models/image.cpp
    self
  end

  # Rotates the {Image} 90 degrees clockwise.
  #
  # @example Basic usage
  #   sprite = Image.new("./assets/sprite.png")
  #   sprite.rotate_clockwise!
  #
  # @return [Image]
  def rotate_clockwise!
    # mrb_Image_rotate_clockwise_bang
    # src/mruby_integration/models/image.cpp
    self
  end

  # Rotates the {Image} 90 degrees counter clockwise.
  #
  # @example Basic usage
  #   sprite = Image.new("./assets/sprite.png")
  #   sprite.rotate_counter_clockwise!
  #
  # @return [Image]
  def rotate_counter_clockwise!
    # mrb_Image_rotate_counter_clockwise_bang
    # src/mruby_integration/models/image.cpp
    self
  end

  # Premultiplies the alpha into the colour values. Useful for after you've
  # applied an alpha mask.
  #
  # @example Basic usage
  #   sprite = Image.new("./assets/sprite.png")
  #   mask = Image.generate(
  #     width: 16,
  #     height: 16,
  #     colour: Colour[128, 128, 128, 128],
  #   )
  #
  #   sprite.alpha_mask!(mask)
  #   sprite.premultiply_alpha!
  #
  # @return [Image]
  def premultiply_alpha!
    # mrb_Image_premultiply_alpha_bang
    # src/mruby_integration/models/image.cpp
    self
  end

  # Generates the [mipmaps](https://en.wikipedia.org/wiki/Mipmap) for the
  # {Image}.
  #
  # @example Basic usage
  #   sprite = Image.new("./assets/sprite.png")
  #
  #   puts sprite.mipmaps # => 1
  #
  #   p [sprite.width, sprite.height] # => [16, 16]
  #
  #   puts sprite.mipmaps # => 5
  #
  # @return [Image]
  def generate_mipmaps!
    # mrb_Image_generate_mipmaps_bang
    # src/mruby_integration/models/image.cpp
    self
  end

  # Tints the image with the specified {Colour}.
  #
  # @example Basic usage
  #   sprite = Image.new("./assets/sprite.png")
  #   sprite.tint!(colour: Colour::PURPLE)
  #
  # @param colour [Colour]
  # @return [Image]
  def tint!(colour:)
    # mrb_Image_tint_bang
    # src/mruby_integration/image.cpp
    self
  end

  # Converts the {Image} to greyscale.
  #
  # @example Basic usage
  #   sprite = Image.new("./assets/sprite.png")
  #   sprite.greyscale!
  #
  # @return [Image]
  def greyscale!
    # mrb_Image_greyscale_bang
    # src/mruby_integration/image.cpp
    self
  end

  # Inverts the {Colour}s of the {Image}.
  #
  # @example Basic usage
  #   sprite = Image.new("./assets/sprite.png")
  #   sprite.invert!
  #
  # @return [Image]
  def invert!
    # mrb_Image_invert_bang
    # src/mruby_integration/image.cpp
    self
  end

  # Change the contrast of the {Image}.
  #
  # @example Raise the contrast
  #   sprite = Image.new("./assets/sprite.png")
  #   sprite.contrast!(50)
  #
  # @example Lower the contrast
  #   sprite = Image.new("./assets/sprite.png")
  #   sprite.contrast!(-50)
  #
  # @param contrast [Float] A value between -100 and 100.
  # @raise [ArgumentError] If the contrast is outside of the allowed range.
  # @return [Image]
  def contrast!(contrast)
    # mrb_Image_contrast_bang
    # src/mruby_integration/image.cpp
    self
  end

  # Change the brightness of the {Image}.
  #
  # @example Raise the brightness
  #   sprite = Image.new("./assets/sprite.png")
  #   sprite.brightness!(128)
  #
  # @example Lower the brightness
  #   sprite = Image.new("./assets/sprite.png")
  #   sprite.brightness!(-128)
  #
  # @param brightness [Float] a value between -255 and 255
  # @raise [ArgumentError] If the brightness is outside of the allowed range
  # @return [nil]
  def brightness!(brightness)
    # mrb_Image_brightness_bang
    # src/mruby_integration/image.cpp
    self
  end

  # Replace all instances of the `from` {Colour} with the `to` {Colour}.
  #
  # @example Basic usage
  #   sprite = Image.new("./assets/sprite.png")
  #   sprite.brightness!(from: Colour[255, 0, 0], to: Colour::GREEN)
  #
  # @param from [Colour]
  # @param to [Colour]
  # @return [Image]
  def replace!(from:, to:)
    # mrb_Image_replace_bang
    # src/mruby_integration/image.cpp
    self
  end

  # Draw one image onto another. You can specify the `source` to draw a subset
  # of the {Image}.
  #
  # @example Creating a background from a tilemap
  #   tilemap = Image.new("./assets/tilemap.png")
  #   grass = Rectangle[0, 0, 16, 16]
  #   tree  = Rectangle[16, 0, 16, 16]
  #   rock  = Rectangle[0, 16, 16, 16]
  #   house = Rectangle[16, 16, 16, 16]
  #   tiles = [grass, tree, rock, house]
  #
  #   background_tiles = Vector2[32, 16]
  #   background = Image.generate(width: background_tiles.width * 16, height: background_tiles.height * 16)
  #
  #   background_tiles.height.to_i.times do |y|
  #     background_tiles.width.to_i.times do |x|
  #       background.draw!(
  #         image: tilemap,
  #         source: tiles.sample,
  #         destination: Rectangle[
  #           x * 16, y * 16,
  #           16, 16
  #         ]
  #       )
  #     end
  #   end
  #
  # @param image [Image]
  # @param source [Rectangle] If left blank, will use the whole image.
  # @param destination [Rectangle] If left blank, will draw into the top left corner.
  # @param colour [Colour]
  # @return [nil]
  def draw!(
    image:,
    source: Rectangle[0, 0, image.width, image.height],
    destination: Rectangle[0, 0, image.width, image.height],
    colour: Colour::WHITE
  )
    # mrb_Image_draw_bang
    # src/mruby_integration/models/image.cpp
    self
  end

  # Returns an array containing the image data as an array of {Colour} objects.
  #
  # @return [Array<Colour>]
  def data
    # mrb_Image_get_data
    # src/mruby_integration/models/image.cpp
    [Colour.new]
  end

  # Returns a {Texture2D} of the {Image}.
  #
  # @example Basic usage
  #   image = Imag.new("./assets/sprite.png")
  #   sprite = image.to_texture
  #   sprite.draw
  #
  # @return [Texture2D]
  def to_texture
    # mrb_Image_to_texture
    # src/mruby_integration/models/image.cpp
    Texture2D.new
  end
end
