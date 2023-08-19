#include "mruby.h"
#include "raylib.h"

#include "mruby_integration/struct_types.hpp"

mrb_value
mrb_draw_pixel(mrb_state* mrb, mrb_value)
{
  mrb_int x, y;
  Color* colour;

  mrb_get_args(mrb, "iid", &x, &y, &colour, &Colour_type);

  DrawPixel(x, y, *colour);
  return mrb_nil_value();
}

mrb_value
mrb_draw_pixel_v(mrb_state* mrb, mrb_value)
{
  Vector2* vector;
  Color* colour;

  mrb_get_args(mrb, "dd", &vector, &Vector2_type, &colour, &Colour_type);

  DrawPixelV(*vector, *colour);
  return mrb_nil_value();
}

void
append_shapes_pixel(mrb_state* mrb)
{
  mrb_define_method(
    mrb, mrb->kernel_module, "draw_pixel", mrb_draw_pixel, MRB_ARGS_REQ(3));
  mrb_define_method(
    mrb, mrb->kernel_module, "draw_pixel_v", mrb_draw_pixel_v, MRB_ARGS_REQ(2));
}
