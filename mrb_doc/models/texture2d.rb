class Texture2D
  # Loads an image file from the disk. If the file does not exist, it will
  # raise a {Texture2D::NotFoundError} error.
  #
  # @example Basic usage
  #   texture = Texture2D.new("/assets/my_cool_sprite.png")
  #
  # @param path [String]
  # @return [Texture2D]
  # @raise [Texture2D::NotFoundError]
  def initialize(path)
    # mrb_Texture2D_initialize
    # src/mruby_integration/models/texture2d.cpp
  end

  # Unloads the {Texture2D} from memory.
  #
  # @example Basic usage
  #   texture = Texture2D.new("/assets/my_cool_sprite.png")
  #   texture.unload
  #
  # @return [nil]
  def unload
    # mrb_Texture2D_unload
    # src/mruby_integration/models/texture2d.cpp
    nil
  end

  # Checks if the {Texture2D} was successfully loaded onto the GPU and is valid.
  #
  # @example Basic usage
  #   texture = Texture2D.new("/assets/image.png")
  #   raise "Bad image!" unless texture.valid?
  #   texture.unload
  #
  # @return [Boolean]
  def valid?
    # mrb_Texture_valid
    # src/mruby_integration/models/texture.cpp
    true
  end

  # Sets the filtering for the {Texture2D}.
  #
  # @example Basic usage
  #   big_texture = Texture2D.new("/assets/my_cool_background.png")
  #
  #   big_texture.filter = Texture2D::BILINEAR
  #
  #   big_texture.unload
  #
  # @param val [Integer] What sort of filtering to apply, valid options are:
  #   {Texture2D::NO_FILTER}, {Texture2D::BILINEAR}, {Texture2D::TRILINEAR},
  #   {Texture2D::ANISOTROPIC_4X}, {Texture2D::ANISOTROPIC_8X}, or
  #   {Texture2D::ANISOTROPIC_16X}.
  # @return [nil]
  # @raise [ArgumentError]
  def filter=(val)
    # mrb_Texture2D_filter_equals
    # src/mruby_integration/models/texture2d.cpp
    nil
  end

  # Generates [mipmaps](https://en.wikipedia.org/wiki/Mipmap) for the {Texture2D}.
  #
  # @example Basic usage
  #   big_texture = Texture2D.new("/assets/my_cool_background.png")
  #
  #   big_texture.generate_mipmaps
  #
  #   big_texture.unload
  #
  # @return [nil]
  def generate_mipmaps
    # mrb_Texture2D_generate_mipmaps
    # src/mruby_integration/models/texture2d.cpp
    nil
  end

  # Draws the {Texture2D} segment defined by source at the given destination,
  # rotated around the origin in the specified colour.
  #
  # @example Basic usage
  #   texture = Texture2D.new("/assets/my_cool_sprite.png")
  #
  #   # Just draw the whole texture
  #   texture.draw(position: Vector2[100, 120])
  #
  #   # Rotate the texture 90 degrees when drawn
  #   texture.draw(position: Vector2[100, 120], rotation: 90)
  #
  #   # Draw with half opacity
  #   texture.draw(position: Vector2[100, 120], colour: Colour[255, 255, 255, 128])
  #
  #   # Stretch as you draw it
  #   texture.draw(
  #     source: Rectangle[0, 0, 16, 16],
  #     destination: Rectangle[100, 120, 64, 32],
  #   )
  #
  # @example Basic sprite sheet usage
  #   sheet = Texture2D.new("/assets/my_cool_sprite_sheet.png")
  #   player = Rectangle[0, 0, 16, 16]
  #   grass = Rectangle[16, 0, 16, 16]
  #
  #   10.times do |y|
  #     10.times do |x|
  #       sheet.draw(source: grass, position: Vector[x * 16, y * 16])
  #     end
  #   end
  #
  #   sheet.draw(source: player, position: Vector2[32, 32])
  #
  #
  # @param source [Rectangle]
  # @param position [Vector2]
  # @param destination [Rectangle]
  # @param origin [Vector2]
  # @param rotation [Integer] In degrees
  # @param colour [Colour]
  # @return [nil]
  # @raise [ArgumentError] if both `position` and `destination` are passed in
  def draw(
    source: Rectangle[0, 0, width, height],
    position: Vector2[0, 0],
    destination: Rectangle[position.x, position.y, source.width, source.height],
    origin: Vector2[0, 0],
    rotation: 0,
    colour: Colour::WHITE
  )
    # mrb_Texture2D_draw
    # src/mruby_integration/models/texture2d.cpp
    nil
  end
end
