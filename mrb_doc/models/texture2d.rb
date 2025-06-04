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
end
