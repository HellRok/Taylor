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
  def initialize(red, green, blue, alpha)
    # mrb_Colour_initialize
    # src/mruby_integration/models/colour.cpp
    Colour.new
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
    # mrb_Colour_set_alpha
    # src/mruby_integration/models/colour.cpp
    Colour[1, 2, 3, 4]
  end
end
