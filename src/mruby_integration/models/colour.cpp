#include "mruby.h"
#include "mruby/class.h"
#include "mruby/data.h"
#include "raylib.h"
#include <cstdlib>

#include "mruby_integration/helpers.hpp"
#include "mruby_integration/struct_types.hpp"

#include "ruby/models/colour.hpp"

struct RClass* Colour_class;

void
setup_Colour(mrb_state* mrb,
             mrb_value object,
             Color* colour,
             int red,
             int green,
             int blue,
             int alpha)
{
  ivar_attr_int(mrb, object, colour->r, red);
  ivar_attr_int(mrb, object, colour->g, green);
  ivar_attr_int(mrb, object, colour->b, blue);
  ivar_attr_int(mrb, object, colour->a, alpha);
}

auto
mrb_Colour_initialize(mrb_state* mrb, mrb_value self) -> mrb_value
{
  // def initialize(
  //   red: 0,
  //   blue: 0,
  //   green: 0,
  //   alpha: 255
  // )
  mrb_int kw_num = 4;
  mrb_int kw_required = 0;
  mrb_sym kw_names[] = { mrb_intern_lit(mrb, "red"),
                         mrb_intern_lit(mrb, "green"),
                         mrb_intern_lit(mrb, "blue"),
                         mrb_intern_lit(mrb, "alpha") };
  mrb_value kw_values[kw_num];
  mrb_kwargs kwargs = { kw_num, kw_required, kw_names, kw_values, nullptr };
  mrb_get_args(mrb, ":", &kwargs);

  float red = 0;
  if (!mrb_undef_p(kw_values[0])) {
    red = mrb_as_int(mrb, kw_values[0]);
  }

  float green = 0;
  if (!mrb_undef_p(kw_values[1])) {
    green = mrb_as_int(mrb, kw_values[1]);
  }

  float blue = 0;
  if (!mrb_undef_p(kw_values[2])) {
    blue = mrb_as_int(mrb, kw_values[2]);
  }

  float alpha = 255;
  if (!mrb_undef_p(kw_values[3])) {
    alpha = mrb_as_int(mrb, kw_values[3]);
  }

  Color* colour = static_cast<struct Color*> DATA_PTR(self);
  if (colour) {
    mrb_free(mrb, colour);
  }
  mrb_data_init(self, nullptr, &Colour_type);
  colour = static_cast<Color*>(malloc(sizeof(Color)));

  setup_Colour(mrb, self, colour, red, green, blue, alpha);

  mrb_data_init(self, colour, &Colour_type);
  return self;
}

auto
mrb_Colour_set_red(mrb_state* mrb, mrb_value self) -> mrb_value
{
  attr_setter_int(mrb, self, Colour_type, Color, r, red);
}

auto
mrb_Colour_set_green(mrb_state* mrb, mrb_value self) -> mrb_value
{
  attr_setter_int(mrb, self, Colour_type, Color, g, green);
}

auto
mrb_Colour_set_blue(mrb_state* mrb, mrb_value self) -> mrb_value
{
  attr_setter_int(mrb, self, Colour_type, Color, b, blue);
}

auto
mrb_Colour_set_alpha(mrb_state* mrb, mrb_value self) -> mrb_value
{
  attr_setter_int(mrb, self, Colour_type, Color, a, alpha);
}

auto
mrb_Colour_fade(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_float alpha;
  mrb_get_args(mrb, "f", &alpha);

  if (alpha < 0 || alpha > 1) {
    mrb_raise(mrb, E_ARGUMENT_ERROR, "Alpha must be within (0.0..1.0)");
  }

  Color* colour;

  Data_Get_Struct(mrb, self, &Colour_type, colour);
  mrb_assert(colour != nullptr);

  auto* return_colour = static_cast<Color*>(malloc(sizeof(Color)));
  *return_colour = Fade(*colour, alpha);

  mrb_value obj = mrb_obj_value(
    Data_Wrap_Struct(mrb, Colour_class, &Colour_type, return_colour));

  setup_Colour(mrb,
               obj,
               return_colour,
               return_colour->r,
               return_colour->g,
               return_colour->b,
               return_colour->a);

  return obj;
}

void
append_models_Colour(mrb_state* mrb)
{
  Colour_class = mrb_define_class(mrb, "Colour", mrb->object_class);
  MRB_SET_INSTANCE_TT(Colour_class, MRB_TT_DATA);
  mrb_define_method(
    mrb, Colour_class, "initialize", mrb_Colour_initialize, MRB_ARGS_REQ(4));
  mrb_define_method(
    mrb, Colour_class, "red=", mrb_Colour_set_red, MRB_ARGS_REQ(1));
  mrb_define_method(
    mrb, Colour_class, "green=", mrb_Colour_set_green, MRB_ARGS_REQ(1));
  mrb_define_method(
    mrb, Colour_class, "blue=", mrb_Colour_set_blue, MRB_ARGS_REQ(1));
  mrb_define_method(
    mrb, Colour_class, "alpha=", mrb_Colour_set_alpha, MRB_ARGS_REQ(1));
  mrb_define_method(
    mrb, Colour_class, "fade", mrb_Colour_fade, MRB_ARGS_REQ(1));

  load_ruby_models_colour(mrb);
}
