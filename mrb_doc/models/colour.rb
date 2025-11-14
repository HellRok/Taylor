class Colour
  # @return [Integer]
  attr_accessor :red, :green, :blue, :alpha

  # Creates a new instance of Colour.
  #
  # @example Basic usage
  #   purple = Colour.new(red: 128, green: 0, blue: 255)
  #
  # @param red [Integer] A value between 0 and 255.
  # @param blue [Integer] A value between 0 and 255.
  # @param green [Integer] A value between 0 and 255.
  # @param alpha [Integer] A value between 0 and 255.
  # @return [Colour]
  def initialize(red: 0, green: 0, blue: 0, alpha: 255)
    # mrb_Colour_initialize
    # src/mruby_integration/models/colour.cpp
  end

  # Returns a new {Colour} which is a faded version of the original.
  #
  # @example Basic usage
  #   faded_blue = Colour::BLUE.fade(0.25)
  #   p faded_blue
  #   # => #<Vector2:0x555a13701450 red:0 blue:241 green:121 alpha:63>
  #
  #   p Colour::BLUE
  #   # => #<Vector2:0x555a13679de0 red:0 blue:241 green:121 alpha:255>
  #
  # @param alpha [Float] A value between 0.0 and 1.0.
  # @return [Colour]
  # @raise [ArgumentError] If the alpha is out of bounds.
  def fade(alpha)
    # mrb_Colour_alpha
    # src/mruby_integration/models/colour.cpp
    Colour[1, 2, 3, 4]
  end

  # Returns a tinted version of {Colour} with the passed in {Colour}.
  #
  # @example Basic usage
  #   grey = Colour[128, 128, 128, 255]
  #   p grey
  #   # => #<Colour:0xb78270 red:128 blue:128 green:128 alpha:255>
  #
  #   blue_grey = grey.tint(Colour::BLUE)
  #   p blue_grey
  #   # => #<Colour:0x20638fd0 red:0 blue:120 green:60 alpha:255>
  #
  # @param colour [Colour]
  # @return [Colour]
  # @raise [ArgumentError] If the alpha is out of bounds.
  def tint(colour)
    # mrb_Colour_tint
    # src/mruby_integration/models/colour.cpp
    Colour[1, 2, 3, 4]
  end

  # Returns a {Colour} brightened by the passed in percent.
  #
  # @example Basic usage
  #   red = Colour::RED
  #   # => #<Colour:0x55b398928100 red:230 blue:55 green:41 alpha:255>
  #
  #   p red.brightness(0.5)
  #   # => #<Colour:0x5557726209e0 red:242 blue:155 green:148 alpha:255>
  #
  #   p red.brightness(-0.5)
  #   # => #<Colour:0x555772620770 red:115 blue:27 green:20 alpha:255>
  #
  # @param percent [Float] A value between -1.0 and 1.0.
  # @return [Colour]
  # @raise [ArgumentError] If the percent is out of bounds.
  def brightness(percent)
    # mrb_Colour_brightness
    # src/mruby_integration/models/colour.cpp
    Colour[1, 2, 3, 4]
  end

  # Returns a {Colour} contrasted by the passed in percent.
  #
  # @example Basic usage
  #   red = Colour::RED
  #   p red
  #   # => #<Colour:0x1cf6c580 red:230 blue:55 green:41 alpha:255>
  #
  #   p red.contrast(0.5)
  #   # => #<Colour:0x1cfc3b70 red:255 blue:0 green:0 alpha:255>
  #
  #   p red.contrast(-0.5)
  #   # => #<Colour:0x1cfc3900 red:153 blue:109 green:105 alpha:255>
  #
  # @param percent [Float] A value between -1.0 and 1.0.
  # @return [Colour]
  # @raise [ArgumentError] If the percent is out of bounds.
  def contrast(percent)
    # mrb_Colour_contrast
    # src/mruby_integration/models/colour.cpp
    Colour[1, 2, 3, 4]
  end
end
