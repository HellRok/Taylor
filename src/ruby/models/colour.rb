# The Colour class is used for setting the colour of basic primatives (Circle,
# Rectangle, etc) but also for setting transparency on Texture2D objects.
class Colour
  # @return [Integer]
  attr_reader :red, :green, :blue, :alpha

  # Compares the values of two Colours
  # @param other [Colour]
  # @return [Boolean]
  def ==(other)
    self.red == other.red &&
      self.green == other.green &&
      self.blue == other.blue &&
      self.alpha == other.alpha
  end


  # Return the object represented by a Hash
  # @return [Hash]
  def to_h
    {
      red: red,
      green: green,
      blue: blue,
      alpha: alpha,
    }
  end
end

# A nice lightgray colour
LIGHTGRAY  = Colour.new(200, 200, 200, 255)
# A nice gray colour
GRAY       = Colour.new(130, 130, 130, 255)
# A nice darkgray colour
DARKGRAY   = Colour.new( 80,  80,  80, 255)
# A nice yellow colour
YELLOW     = Colour.new(253, 249,   0, 255)
# A nice gold colour
GOLD       = Colour.new(255, 203,   0, 255)
# A nice orange colour
ORANGE     = Colour.new(255, 161,   0, 255)
# A nice pink colour
PINK       = Colour.new(255, 109, 194, 255)
# A nice red colour
RED        = Colour.new(230,  41,  55, 255)
# A nice maroon colour
MAROON     = Colour.new(190,  33,  55, 255)
# A nice green colour
GREEN      = Colour.new(  0, 228,  48, 255)
# A nice lime colour
LIME       = Colour.new(  0, 158,  47, 255)
# A nice darkgreen colour
DARKGREEN  = Colour.new(  0, 117,  44, 255)
# A nice skyblue colour
SKYBLUE    = Colour.new(102, 191, 255, 255)
# A nice blue colour
BLUE       = Colour.new(  0, 121, 241, 255)
# A nice darkblue colour
DARKBLUE   = Colour.new(  0,  82, 172, 255)
# A nice purple colour
PURPLE     = Colour.new(200, 122, 255, 255)
# A nice violet colour
VIOLET     = Colour.new(135,  60, 190, 255)
# A nice darkpurple colour
DARKPURPLE = Colour.new(112,  31, 126, 255)
# A nice beige colour
BEIGE      = Colour.new(211, 176, 131, 255)
# A nice brown colour
BROWN      = Colour.new(127, 106,  79, 255)
# A nice darkbrown colour
DARKBROWN  = Colour.new( 76,  63,  47, 255)

# A nice white colour
WHITE      = Colour.new(255, 255, 255, 255)
# A nice black colour
BLACK      = Colour.new(  0,   0,   0, 255)
# A nice blank colour
BLANK      = Colour.new(  0,   0,   0,   0)
# A nice magenta colour
MAGENTA    = Colour.new(255,   0, 255, 255)
# The official Raylib white
RAYWHITE   = Colour.new(245, 245, 245, 255)
