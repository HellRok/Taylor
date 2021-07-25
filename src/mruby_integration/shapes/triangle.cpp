#include "raylib.h"
#include "mruby.h"

#include "mruby_integration/struct_types.hpp"

mrb_value mrb_draw_triangle(mrb_state *mrb, mrb_value) {
  Vector2 *left, *right, *top;
  Color *colour;

  mrb_get_args(mrb, "dddd", &left, &Vector2_type, &right, &Vector2_type, &top, &Vector2_type, &colour, &Colour_type);

  DrawTriangle(*left, *right, *top, *colour);
  return mrb_nil_value();
}

mrb_value mrb_draw_triangle_lines(mrb_state *mrb, mrb_value) {
  Vector2 *left, *right, *top;
  Color *colour;

  mrb_get_args(mrb, "dddd", &left, &Vector2_type, &right, &Vector2_type, &top, &Vector2_type, &colour, &Colour_type);

  DrawTriangleLines(*left, *right, *top, *colour);
  return mrb_nil_value();
}

void append_shapes_triangle(mrb_state *mrb) {
  mrb_define_method(mrb, mrb->kernel_module, "draw_triangle", mrb_draw_triangle, MRB_ARGS_REQ(4));
  mrb_define_method(mrb, mrb->kernel_module, "draw_triangle_lines", mrb_draw_triangle_lines, MRB_ARGS_REQ(4));
}
