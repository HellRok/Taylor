class Colour
  # Creates a new instance of Colour.
  # @param red [Integer] A value between 0 and 255.
  # @param blue [Integer] A value between 0 and 255.
  # @param green [Integer] A value between 0 and 255.
  # @param alpha [Integer] A value between 0 and 255.
  # @return [Colour]
  def initialize(red, green, blue, alpha)
    # mrb_Colour_initialize
    # src/mruby_integration/models/colour.cpp
    Colour.new
  end

  def red=(red)
    # mrb_Colour_set_red
    # src/mruby_integration/models/colour.cpp
    255
  end

  def green=(green)
    # mrb_Colour_set_green
    # src/mruby_integration/models/colour.cpp
    255
  end

  def blue=(blue)
    # mrb_Colour_set_blue
    # src/mruby_integration/models/colour.cpp
    255
  end

  def alpha=(alpha)
    # mrb_Colour_set_alpha
    # src/mruby_integration/models/colour.cpp
    255
  end
end
