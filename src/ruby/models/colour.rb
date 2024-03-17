# The Colour class is used for setting the colour of basic primitives (Circles,
# Rectangles, etc) but also for setting transparency on {Texture2D} objects.
class Colour
  # @return [Integer]
  attr_reader :red, :green, :blue, :alpha

  # A short form way to create new {Colour} objects.
  # @param red [Integer] A value between 0 and 255.
  # @param blue [Integer] A value between 0 and 255.
  # @param green [Integer] A value between 0 and 255.
  # @param alpha [Integer] A value between 0 and 255.
  # @return [Colour]
  def self.[](red = 0, green = 0, blue = 0, alpha = 255)
    new(red: red, green: green, blue: blue, alpha: alpha)
  end

  # Compares the values of two Colours.
  # @param other [Colour]
  # @return [Boolean]
  def ==(other)
    red == other.red &&
      green == other.green &&
      blue == other.blue &&
      alpha == other.alpha
  end

  # Return the object represented by a Hash.
  # @return [Hash]
  def to_h
    {
      red: red,
      green: green,
      blue: blue,
      alpha: alpha
    }
  end

  # @!group Colours

  # A nice lightgray colour.
  LIGHTGRAY = Colour[200, 200, 200]
  # A nice gray colour.
  GRAY = Colour[130, 130, 130]
  # A nice darkgray colour.
  DARKGRAY = Colour[80, 80, 80]
  # A nice yellow colour.
  YELLOW = Colour[253, 249, 0]
  # A nice gold colour.
  GOLD = Colour[255, 203, 0]
  # A nice orange colour.
  ORANGE = Colour[255, 161, 0]
  # A nice pink colour.
  PINK = Colour[255, 109, 194]
  # A nice red colour.
  RED = Colour[230, 41, 55]
  # A nice maroon colour.
  MAROON = Colour[190, 33, 55]
  # A nice green colour.
  GREEN = Colour[0, 228, 48]
  # A nice lime colour.
  LIME = Colour[0, 158, 47]
  # A nice darkgreen colour.
  DARKGREEN = Colour[0, 117, 44]
  # A nice skyblue colour.
  SKYBLUE = Colour[102, 191, 255]
  # A nice blue colour.
  BLUE = Colour[0, 121, 241]
  # A nice darkblue colour.
  DARKBLUE = Colour[0, 82, 172]
  # A nice purple colour.
  PURPLE = Colour[200, 122, 255]
  # A nice violet colour.
  VIOLET = Colour[135, 60, 190]
  # A nice darkpurple colour.
  DARKPURPLE = Colour[112, 31, 126]
  # A nice beige colour.
  BEIGE = Colour[211, 176, 131]
  # A nice brown colour.
  BROWN = Colour[127, 106, 79]
  # A nice darkbrown colour.
  DARKBROWN = Colour[76, 63, 47]

  # A nice white colour.
  WHITE = Colour[255, 255, 255]
  # A nice black colour.
  BLACK = Colour[0, 0, 0]
  # A nice blank colour.
  BLANK = Colour[0, 0, 0, 0]
  # A nice magenta colour.
  MAGENTA = Colour[255, 0, 255]
  # The official Raylib white.
  RAYWHITE = Colour[245, 245, 245]

  # @!endgroup
end
