#include <cstdlib>
#include "raylib.h"
#include "mruby.h"
#include "mruby/data.h"
#include "mruby/class.h"
#include "mruby/compile.h"

#include "mruby_integration/helpers.hpp"
#include "mruby_integration/struct_types.hpp"

struct RClass *Colour_class;

void setup_Colour(mrb_state *mrb, mrb_value object, Color *colour, int red, int green, int blue, int alpha) {
  ivar_attr_int(mrb, object, colour->r, red);
  ivar_attr_int(mrb, object, colour->g, green);
  ivar_attr_int(mrb, object, colour->b, blue);
  ivar_attr_int(mrb, object, colour->a, alpha);
}

mrb_value mrb_Colour_initialize(mrb_state *mrb, mrb_value self) {
  mrb_int red, green, blue, alpha;
  alpha = 255;

  mrb_get_args(mrb, "iii|i", &red, &green, &blue, &alpha);

  Color *colour = (struct Color *)DATA_PTR(self);
  if (colour) { mrb_free(mrb, colour); }
  mrb_data_init(self, nullptr, &Colour_type);
  colour = (Color *)malloc(sizeof(Color));

  setup_Colour(mrb, self, colour, red, green, blue, alpha);

  mrb_data_init(self, colour, &Colour_type);
  return self;
}

mrb_value mrb_Colour_set_red(mrb_state *mrb, mrb_value self) {
  attr_setter_int(mrb, self, Colour_type, Color, r, red);
}

mrb_value mrb_Colour_set_green(mrb_state *mrb, mrb_value self) {
  attr_setter_int(mrb, self, Colour_type, Color, g, green);
}

mrb_value mrb_Colour_set_blue(mrb_state *mrb, mrb_value self) {
  attr_setter_int(mrb, self, Colour_type, Color, b, blue);
}

mrb_value mrb_Colour_set_alpha(mrb_state *mrb, mrb_value self) {
  attr_setter_int(mrb, self, Colour_type, Color, a, alpha);
}

void append_models_Colour(mrb_state *mrb) {
  Colour_class = mrb_define_class(mrb, "Colour", mrb->object_class);
  MRB_SET_INSTANCE_TT(Colour_class, MRB_TT_DATA);
  mrb_define_method(mrb, Colour_class, "initialize", mrb_Colour_initialize, MRB_ARGS_REQ(3)|MRB_ARGS_OPT(1));
  mrb_define_method(mrb, Colour_class, "red=", mrb_Colour_set_red, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, Colour_class, "green=", mrb_Colour_set_green, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, Colour_class, "blue=", mrb_Colour_set_blue, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, Colour_class, "alpha=", mrb_Colour_set_alpha, MRB_ARGS_REQ(1));

  mrb_load_string(mrb, R"(
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

    Color = Colour

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
  )");
}
