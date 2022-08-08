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

  # Used for alerting the user the texture was not found at the specified path
  class NotFound < StandardError; end
end
