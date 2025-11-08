#include "mruby.h"
#include "mruby/class.h"
#include "mruby/data.h"
#include "raylib.h"
#include <cstdlib>

#include "mruby_integration/helpers.hpp"
#include "mruby_integration/models/colour.hpp"
#include "mruby_integration/struct_types.hpp"

#include "ruby/models/colour.hpp"

struct RClass* Colour_class;

// This is named to match the C struct for macros
auto
mrb_Color_value(mrb_state* mrb, Color* colour) -> mrb_value
{
  mrb_value obj =
    mrb_obj_value(Data_Wrap_Struct(mrb, Colour_class, &Color_type, colour));

  return obj;
}

void
Color_init(Color* colour)
{
  colour->r = 0;
  colour->g = 0;
  colour->b = 0;
  colour->a = 0;
}

auto
mrb_Colour_initialize(mrb_state* mrb, mrb_value self) -> mrb_value
{
  Color* colour;
  mrb_self_ptr(mrb, self, Color, colour);

  // def initialize(
  //   red: 0,
  //   blue: 0,
  //   green: 0,
  //   alpha: 255
  // )
  const mrb_int kw_num = 4;
  const mrb_int kw_required = 0;
  const mrb_sym kw_names[] = { mrb_intern_lit(mrb, "red"),
                               mrb_intern_lit(mrb, "green"),
                               mrb_intern_lit(mrb, "blue"),
                               mrb_intern_lit(mrb, "alpha") };
  mrb_value kw_values[kw_num];
  mrb_kwargs kwargs = { kw_num, kw_required, kw_names, kw_values, nullptr };
  mrb_get_args(mrb, ":", &kwargs);

  colour->r = 0;
  if (!mrb_undef_p(kw_values[0])) {
    colour->r = mrb_as_int(mrb, kw_values[0]);
  }

  colour->g = 0;
  if (!mrb_undef_p(kw_values[1])) {
    colour->g = mrb_as_int(mrb, kw_values[1]);
  }

  colour->b = 0;
  if (!mrb_undef_p(kw_values[2])) {
    colour->b = mrb_as_int(mrb, kw_values[2]);
  }

  colour->a = 255;
  if (!mrb_undef_p(kw_values[3])) {
    colour->a = mrb_as_int(mrb, kw_values[3]);
  }

  mrb_data_init(self, colour, &Color_type);
  return self;
}

mrb_attr_accessor_with_klasses(mrb, self, int, i, Colour, Color, r);
mrb_attr_accessor_with_klasses(mrb, self, int, i, Colour, Color, g);
mrb_attr_accessor_with_klasses(mrb, self, int, i, Colour, Color, b);
mrb_attr_accessor_with_klasses(mrb, self, int, i, Colour, Color, a);

auto
mrb_Colour_fade(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Color, colour);

  mrb_float alpha;
  mrb_get_args(mrb, "f", &alpha);

  if (alpha < 0 || alpha > 1) {
    mrb_raise(mrb, E_ARGUMENT_ERROR, "Alpha must be within (0.0..1.0)");
  }

  auto* return_colour = static_cast<Color*>(malloc(sizeof(Color)));
  *return_colour = Fade(*colour, alpha);

  return mrb_Color_value(mrb, return_colour);
}

auto
mrb_Colour_tint(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Color, colour);

  Color* tint;
  mrb_get_args(mrb, "d", &tint, &Color_type);

  auto* return_colour = static_cast<Color*>(malloc(sizeof(Color)));
  *return_colour = ColorTint(*colour, *tint);

  return mrb_Color_value(mrb, return_colour);
}

void
append_models_Colour(mrb_state* mrb)
{
  Colour_class = mrb_define_class(mrb, "Colour", mrb->object_class);
  MRB_SET_INSTANCE_TT(Colour_class, MRB_TT_DATA);
  mrb_define_method(
    mrb, Colour_class, "initialize", mrb_Colour_initialize, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, Colour_class, "red", mrb_Colour_r, MRB_ARGS_NONE());
  mrb_define_method(
    mrb, Colour_class, "red=", mrb_Colour_set_r, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, Colour_class, "green", mrb_Colour_g, MRB_ARGS_NONE());
  mrb_define_method(
    mrb, Colour_class, "green=", mrb_Colour_set_g, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, Colour_class, "blue", mrb_Colour_b, MRB_ARGS_NONE());
  mrb_define_method(
    mrb, Colour_class, "blue=", mrb_Colour_set_b, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, Colour_class, "alpha", mrb_Colour_a, MRB_ARGS_NONE());
  mrb_define_method(
    mrb, Colour_class, "alpha=", mrb_Colour_set_a, MRB_ARGS_REQ(1));
  mrb_define_method(
    mrb, Colour_class, "fade", mrb_Colour_fade, MRB_ARGS_REQ(1));
  mrb_define_method(
    mrb, Colour_class, "tint", mrb_Colour_tint, MRB_ARGS_REQ(1));

  load_ruby_models_colour(mrb);
}
