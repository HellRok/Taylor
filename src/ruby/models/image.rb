class Image
  attr_reader :width, :height, :mipmaps, :format

  def to_h
    {
      width: width,
      height: height,
      mipmaps: mipmaps,
      format: format,
    }
  end

  def self.load(path)
    raise Image::NotFound.new("Could not find file at path \"#{path}\"") unless File.exist?(path)
    load_image(path)
  end

  def unload
    unload_image(self)
  end

  def export(path)
    export_image(self, path)
  end

  def copy(source: nil)
    if source
      image_from_image(self, source)
    else
      image_copy(self)
    end
  end

  def to_texture
    load_texture_from_image(self)
  end

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

  def crop!(rectangle)
    image_crop!(self, rectangle)
    self
  end

  def alpha_mask=(mask)
    image_alpha_mask!(self, mask)
    self
  end

  def premultiply_alpha!
    image_alpha_premultiply!(self)
    self
  end

  def generate_mipmaps!
    image_mipmaps!(self)
    self
  end

  def flip_vertical!
    image_flip_vertical!(self)
    self
  end

  def flip_horizontal!
    image_flip_horizontal!(self)
    self
  end

  def rotate!(direction = :cw)
    raise ArgumentError.new('Value must be :ccw, :cw, or nil') unless [:ccw, :cw, nil].include?(direction)

    if direction == :ccw
      image_rotate_ccw!(self)
    else
      image_rotate_cw!(self)
    end
    self
  end

  def tint!(colour)
    image_colour_tint!(self, colour)
    self
  end

  def invert!
    image_colour_invert!(self)
    self
  end

  def grayscale!
    image_colour_grayscale!(self)
    self
  end

  def contrast!(contrast)
    raise ArgumentError.new('Must be within (-100..100)') if contrast < -100 || contrast > 100

    image_colour_contrast!(self, contrast)
    self
  end

  def replace!(old_colour, new_colour)
    image_colour_replace!(self, old_colour, new_colour)
    self
  end

  def brightness!(brightness)
    raise ArgumentError.new('Must be within (-255..255)') if brightness < -255 || brightness > 255

    image_colour_brightness!(self, brightness)
    self
  end

  def draw!(image:, source: nil, destination: nil, colour: WHITE)
    source ||= Rectangle.new(0, 0, image.width, image.height)
    destination ||= Rectangle.new(0, 0, image.width, image.height)

    image_draw!(self, image, source, destination, colour)
    self
  end

  def self.generate(width:, height:, colour: RAYWHITE)
    generate_image_colour(width, height, colour)
  end

  class NotFound < StandardError; end
end
