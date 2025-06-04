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
    Texture2D.new
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
    # src/mruby_integration/textures.cpp
    nil
  end
end
