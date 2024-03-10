class Texture2D
  # Creates a new instance of {Texture2D}.
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
end
