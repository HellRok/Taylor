#include "raylib.h"
#include "mruby.h"

#include "mruby_integration/struct_types.hpp"

mrb_value mrb_draw_pixel(mrb_state *mrb, mrb_value) {
  mrb_int x, y;
  Color *colour;

  mrb_get_args(mrb, "iid", &x, &y, &colour, &Colour_type);

  DrawPixel(x, y, *colour);
  return mrb_nil_value();
}

mrb_value mrb_draw_pixel_v(mrb_state *mrb, mrb_value) {
  Vector2 *vector;
  Color *colour;

  mrb_get_args(mrb, "dd", &vector, &Vector2_type, &colour, &Colour_type);

  DrawPixelV(*vector, *colour);
  return mrb_nil_value();
}

mrb_value mrb_draw_line(mrb_state *mrb, mrb_value) {
  mrb_int start_x, start_y, end_x, end_y;
  Color *colour;

  mrb_get_args(mrb, "iiiid", &start_x, &start_y, &end_x, &end_y, &colour, &Colour_type);

  DrawLine(start_x, start_y, end_x, end_y, *colour);
  return mrb_nil_value();
}

mrb_value mrb_draw_line_v(mrb_state *mrb, mrb_value) {
  Vector2 *start, *end;
  Color *colour;

  mrb_get_args(mrb, "ddd", &start, &Vector2_type, &end, &Vector2_type, &colour, &Colour_type);

  DrawLineV(*start, *end, *colour);
  return mrb_nil_value();
}

mrb_value mrb_draw_circle(mrb_state *mrb, mrb_value) {
  mrb_int x, y;
  mrb_float radius;
  Color *colour;

  mrb_get_args(mrb, "iifd", &x, &y, &radius, &colour, &Colour_type);

  DrawCircle(x, y, radius, *colour);
  return mrb_nil_value();
}

mrb_value mrb_draw_circle_v(mrb_state *mrb, mrb_value) {
  Vector2 *vector;
  mrb_float radius;
  Color *colour;

  mrb_get_args(mrb, "dfd", &vector, &Vector2_type, &radius, &colour, &Colour_type);

  DrawCircleV(*vector, radius, *colour);
  return mrb_nil_value();
}

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

mrb_value mrb_draw_triangle(mrb_state *mrb, mrb_value) {
  Vector2 *left, *right, *top;
  Color *colour;

  mrb_get_args(mrb, "dddd", &left, &Vector2_type, &right, &Vector2_type, &top, &Vector2_type, &colour, &Colour_type);

  DrawTriangle(*left, *right, *top, *colour);
  return mrb_nil_value();
}

mrb_value mrb_check_collision_point_rec(mrb_state *mrb, mrb_value) {
  Vector2 *point;
  Rectangle *rectangle;

  mrb_get_args(mrb, "dd", &point, &Vector2_type, &rectangle, &Rectangle_type);

  return mrb_bool_value(CheckCollisionPointRec(*point, *rectangle));
}

void append_shapes(mrb_state *mrb) {
  mrb_define_method(mrb, mrb->kernel_module, "draw_pixel", mrb_draw_pixel, MRB_ARGS_REQ(3));
  mrb_define_method(mrb, mrb->kernel_module, "draw_pixel_v", mrb_draw_pixel_v, MRB_ARGS_REQ(2));

  mrb_define_method(mrb, mrb->kernel_module, "draw_line", mrb_draw_line, MRB_ARGS_REQ(5));
  mrb_define_method(mrb, mrb->kernel_module, "draw_line_v", mrb_draw_line_v, MRB_ARGS_REQ(3));

  mrb_define_method(mrb, mrb->kernel_module, "draw_circle", mrb_draw_circle, MRB_ARGS_REQ(4));
  mrb_define_method(mrb, mrb->kernel_module, "draw_circle_v", mrb_draw_circle_v, MRB_ARGS_REQ(3));

  mrb_define_method(mrb, mrb->kernel_module, "draw_rectangle", mrb_draw_rectangle, MRB_ARGS_REQ(5));
  mrb_define_method(mrb, mrb->kernel_module, "draw_rectangle_rec", mrb_draw_rectangle_rec, MRB_ARGS_REQ(2));
  mrb_define_method(mrb, mrb->kernel_module, "draw_rectangle_lines", mrb_draw_rectangle_lines, MRB_ARGS_REQ(5));
  mrb_define_method(mrb, mrb->kernel_module, "draw_rectangle_lines_ex", mrb_draw_rectangle_lines_ex, MRB_ARGS_REQ(3));

  mrb_define_method(mrb, mrb->kernel_module, "draw_triangle", mrb_draw_triangle, MRB_ARGS_REQ(4));

  mrb_define_method(mrb, mrb->kernel_module, "check_collision_point_rec", mrb_check_collision_point_rec, MRB_ARGS_REQ(2));
}
