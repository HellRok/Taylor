# No filter, just pixel approximation
TEXTURE_FILTER_POINT = 0
# Linear filtering
TEXTURE_FILTER_BILINEAR = 1
# Trilinear filtering (linear with mipmaps)
TEXTURE_FILTER_TRILINEAR = 2
# Anisotropic filtering 4x
TEXTURE_FILTER_ANISOTROPIC_4X = 3
# Anisotropic filtering 8x
TEXTURE_FILTER_ANISOTROPIC_8X = 4
# Anisotropic filtering 16x
TEXTURE_FILTER_ANISOTROPIC_16X = 5

# The Texture2D class is most often used for drawing sprites.
class Texture2D
  # @return [Integer]
  attr_reader :id, :width, :height, :mipmaps, :format

  # Creates a new instance of Texture2D
  # @param id [Integer]
  # @param width [Integer]
  # @param height [Integer]
  # @param mipmaps [Integer]
  # @param format [Integer]
  # @return [Texture2D]
  def initialize(id, width, height, mipmaps, format)
    # mrb_Texture2D_initialize
    # src/mruby_integration/models/texture2d.cpp
    Texture2D.new
  end

  def id=(id)
    # mrb_Texture2D_set_id
    # src/mruby_integration/models/texture2d.cpp
    0
  end

  def width=(width)
    # mrb_Texture2D_set_width
    # src/mruby_integration/models/texture2d.cpp
    10
  end

  def height=(height)
    # mrb_Texture2D_set_height
    # src/mruby_integration/models/texture2d.cpp
    10
  end

  def mipmaps=(mipmaps)
    # mrb_Texture2D_set_mipmaps
    # src/mruby_integration/models/texture2d.cpp
    1
  end

  def format=(format)
    # mrb_Texture2D_set_format
    # src/mruby_integration/models/texture2d.cpp
    1
  end

  # Return the object represented by a Hash
  # @return [Hash]
  def to_h
    # src/mruby_integration/models/texture2d.cpp
    {
      id: id,
      width: width,
      height: height,
      mipmaps: mipmaps,
      format: format,
    }
  end

  # Loads a texture from the specified path
  # @param path [String]
  # @raise [Texture2D::NotFound] If the file specified by path doesn't exist
  # @return [Texture2D]
  def self.load(path)
    # src/mruby_integration/models/texture2d.cpp
    Texture2D.new
  end

  # Unloads the texture from memory
  # @return [nil]
  def unload
    # src/mruby_integration/models/texture2d.cpp
    nil
  end

  # Draws the texture segment defined by source at the given destination,
  # rotated around the origin in the specified colour.
  # If source is not defined it defaults to the full image.
  # If destination is not defined it defaults to source.
  # @param source [Rectangle]
  # @param destination [Rectangle]
  # @param origin [Vector2]
  # @param rotation [Integer] in degrees
  # @param colour [Colour]
  # @return [nil]
  def draw(source: nil, destination: nil, origin: Vector2::ZERO, rotation:0, colour: WHITE)
    # src/mruby_integration/models/texture2d.cpp
    nil
  end

  # Generates mipmaps for the {Texture2D}
  # @return [Integer]
  def generate_mipmaps
    # src/mruby_integration/models/texture2d.cpp
    nil
  end

  # Sets the filtering for the {Texture2D}
  # @param val [Integer] What sort of filtering to apply, valid options are: {TEXTURE_FILTER_POINT}, {TEXTURE_FILTER_BILINEAR}, {TEXTURE_FILTER_TRILINEAR}, {TEXTURE_FILTER_ANISOTROPIC_4X}, {TEXTURE_FILTER_ANISOTROPIC_8X}, or {TEXTURE_FILTER_ANISOTROPIC_16X}
  # @return [Integer]
  def filter=(val)
    # src/mruby_integration/models/texture2d.cpp
    1
  end

  # Used for alerting the user the texture was not found at the specified path
  class NotFound < StandardError; end
end
