#include "raylib.h"
#include "mruby.h"

#include "mruby_integration/struct_types.hpp"

mrb_value mrb_draw_rectangle(mrb_state *mrb, mrb_value) {
  mrb_int x, y, width, height;
  Color *colour;

  mrb_get_args(mrb, "iiiid", &x, &y, &width, &height, &colour, &Colour_type);

  DrawRectangle(x, y, width, height, *colour);
  return mrb_nil_value();
}

mrb_value mrb_draw_rectangle_rec(mrb_state *mrb, mrb_value) {
  Rectangle *rectangle;
  Color *colour;

  mrb_get_args(mrb, "dd", &rectangle, &Rectangle_type, &colour, &Colour_type);

  DrawRectangleRec(*rectangle, *colour);
  return mrb_nil_value();
}

mrb_value mrb_draw_rectangle_pro(mrb_state *mrb, mrb_value) {
  Rectangle *rectangle;
  Vector2 *origin;
  mrb_float rotation;
  Color *colour;

  mrb_get_args(mrb, "ddfd", &rectangle, &Rectangle_type, &origin, &Vector2_type, &rotation, &colour, &Colour_type);

  DrawRectanglePro(*rectangle, *origin, rotation, *colour);
  return mrb_nil_value();
}

mrb_value mrb_draw_rectangle_lines(mrb_state *mrb, mrb_value) {
  mrb_int x, y, width, height;
  Color *colour;

  mrb_get_args(mrb, "iiiid", &x, &y, &width, &height, &colour, &Colour_type);

  DrawRectangleLines(x, y, width, height, *colour);
  return mrb_nil_value();
}

mrb_value mrb_draw_rectangle_lines_ex(mrb_state *mrb, mrb_value) {
  Rectangle *rectangle;
  mrb_int thickness;
  Color *colour;

  mrb_get_args(mrb, "did", &rectangle, &Rectangle_type, &thickness, &colour, &Colour_type);

  DrawRectangleLinesEx(*rectangle, thickness, *colour);
  return mrb_nil_value();
}

void append_shapes_rectangle(mrb_state *mrb) {
  mrb_define_method(mrb, mrb->kernel_module, "draw_rectangle", mrb_draw_rectangle, MRB_ARGS_REQ(5));
  mrb_define_method(mrb, mrb->kernel_module, "draw_rectangle_rec", mrb_draw_rectangle_rec, MRB_ARGS_REQ(2));
  mrb_define_method(mrb, mrb->kernel_module, "draw_rectangle_pro", mrb_draw_rectangle_pro, MRB_ARGS_REQ(4));
  mrb_define_method(mrb, mrb->kernel_module, "draw_rectangle_lines", mrb_draw_rectangle_lines, MRB_ARGS_REQ(5));
  mrb_define_method(mrb, mrb->kernel_module, "draw_rectangle_lines_ex", mrb_draw_rectangle_lines_ex, MRB_ARGS_REQ(3));
}
