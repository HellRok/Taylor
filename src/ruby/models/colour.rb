class Colour
  attr_reader :red, :green, :blue, :alpha

  def ==(other)
    self.red == other.red &&
      self.green == other.green &&
      self.blue == other.blue &&
      self.alpha == other.alpha
  end

  def to_h
    {
      red: red,
      green: green,
      blue: blue,
      alpha: alpha,
    }
  end
end

LIGHTGRAY  = Colour.new(200, 200, 200, 255)
GRAY       = Colour.new(130, 130, 130, 255)
DARKGRAY   = Colour.new( 80,  80,  80, 255)
YELLOW     = Colour.new(253, 249,   0, 255)
GOLD       = Colour.new(255, 203,   0, 255)
ORANGE     = Colour.new(255, 161,   0, 255)
PINK       = Colour.new(255, 109, 194, 255)
RED        = Colour.new(230,  41,  55, 255)
MAROON     = Colour.new(190,  33,  55, 255)
GREEN      = Colour.new(  0, 228,  48, 255)
LIME       = Colour.new(  0, 158,  47, 255)
DARKGREEN  = Colour.new(  0, 117,  44, 255)
SKYBLUE    = Colour.new(102, 191, 255, 255)
BLUE       = Colour.new(  0, 121, 241, 255)
DARKBLUE   = Colour.new(  0,  82, 172, 255)
PURPLE     = Colour.new(200, 122, 255, 255)
VIOLET     = Colour.new(135,  60, 190, 255)
DARKPURPLE = Colour.new(112,  31, 126, 255)
BEIGE      = Colour.new(211, 176, 131, 255)
BROWN      = Colour.new(127, 106,  79, 255)
DARKBROWN  = Colour.new( 76,  63,  47, 255)

WHITE      = Colour.new(255, 255, 255, 255)
BLACK      = Colour.new(  0,   0,   0, 255)
BLANK      = Colour.new(  0,   0,   0,   0)
MAGENTA    = Colour.new(255,   0, 255, 255)
RAYWHITE   = Colour.new(245, 245, 245, 255)
