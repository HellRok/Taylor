#include "raylib.h"
#include "mruby.h"

#include "mruby_integration/struct_types.hpp"

mrb_value mrb_draw_circle(mrb_state *mrb, mrb_value) {
  mrb_int x, y;
  mrb_float radius;
  Color *colour;

  mrb_get_args(mrb, "iifd", &x, &y, &radius, &colour, &Colour_type);

  DrawCircle(x, y, radius, *colour);
  return mrb_nil_value();
}

mrb_value mrb_draw_rectangle(mrb_state *mrb, mrb_value) {
  mrb_int x, y, width, height;
  Color *colour;

  mrb_get_args(mrb, "iiiid", &x, &y, &width, &height, &colour, &Colour_type);

  DrawRectangle(x, y, width, height, *colour);
  return mrb_nil_value();
}

mrb_value mrb_draw_circle_v(mrb_state *mrb, mrb_value) {
  Vector2 *vector2;
  mrb_float radius;
  Color *colour;

  mrb_get_args(mrb, "dfd", &vector2, &Vector2_type, &radius, &colour, &Colour_type);

  DrawCircleV(*vector2, radius, *colour);
  return mrb_nil_value();
}

mrb_value mrb_draw_triangle(mrb_state *mrb, mrb_value) {
  Vector2 *left, *right, *top;
  Color *colour;

  mrb_get_args(mrb, "dddd", &left, &Vector2_type, &right, &Vector2_type, &top, &Vector2_type, &colour, &Colour_type);

  DrawTriangle(*left, *right, *top, *colour);
  return mrb_nil_value();
}

void append_shapes(mrb_state *mrb) {
  mrb_define_method(mrb, mrb->kernel_module, "draw_circle", mrb_draw_circle, MRB_ARGS_REQ(4));
  mrb_define_method(mrb, mrb->kernel_module, "draw_circle_v", mrb_draw_circle_v, MRB_ARGS_REQ(3));
  mrb_define_method(mrb, mrb->kernel_module, "draw_rectangle", mrb_draw_rectangle, MRB_ARGS_REQ(5));
  mrb_define_method(mrb, mrb->kernel_module, "draw_triangle", mrb_draw_triangle, MRB_ARGS_REQ(4));
}
