#include <cstdlib>
#include "raylib.h"
#include "mruby.h"
#include "mruby/data.h"
#include "mruby/class.h"

#include "mruby_integration/helpers.hpp"
#include "mruby_integration/struct_types.hpp"

#include "ruby/models/colour.hpp"

struct RClass *Colour_class;

void setup_Colour(mrb_state *mrb, mrb_value object, Color *colour, int red, int green, int blue, int alpha) {
  ivar_attr_int(mrb, object, colour->r, red);
  ivar_attr_int(mrb, object, colour->g, green);
  ivar_attr_int(mrb, object, colour->b, blue);
  ivar_attr_int(mrb, object, colour->a, alpha);
}

mrb_value mrb_Colour_initialize(mrb_state *mrb, mrb_value self) {
  mrb_int red, green, blue, alpha;
  mrb_get_args(mrb, "iiii", &red, &green, &blue, &alpha);

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
  mrb_define_method(mrb, Colour_class, "initialize", mrb_Colour_initialize, MRB_ARGS_REQ(4));
  mrb_define_method(mrb, Colour_class, "red=", mrb_Colour_set_red, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, Colour_class, "green=", mrb_Colour_set_green, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, Colour_class, "blue=", mrb_Colour_set_blue, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, Colour_class, "alpha=", mrb_Colour_set_alpha, MRB_ARGS_REQ(1));

  load_ruby_models_colour(mrb);
}
