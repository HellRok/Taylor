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

mrb_value mrb_draw_circle_v(mrb_state *mrb, mrb_value) {
  Vector2 *vector;
  mrb_float radius;
  Color *colour;

  mrb_get_args(mrb, "dfd", &vector, &Vector2_type, &radius, &colour, &Colour_type);

  DrawCircleV(*vector, radius, *colour);
  return mrb_nil_value();
}

mrb_value mrb_draw_circle_sector(mrb_state *mrb, mrb_value) {
  Vector2 *vector;
  mrb_float radius, start_angle, end_angle;
  mrb_int segments;
  Color *colour;

  mrb_get_args(mrb, "dfffid", &vector, &Vector2_type, &radius, &start_angle, &end_angle, &segments, &colour, &Colour_type);

  DrawCircleSector(*vector, radius, start_angle, end_angle, segments, *colour);
  return mrb_nil_value();
}

mrb_value mrb_draw_circle_sector_lines(mrb_state *mrb, mrb_value) {
  Vector2 *vector;
  mrb_float radius, start_angle, end_angle;
  mrb_int segments;
  Color *colour;

  mrb_get_args(mrb, "dfffid", &vector, &Vector2_type, &radius, &start_angle, &end_angle, &segments, &colour, &Colour_type);

  DrawCircleSectorLines(*vector, radius, start_angle, end_angle, segments, *colour);
  return mrb_nil_value();
}

void append_shapes_circle(mrb_state *mrb) {
  mrb_define_method(mrb, mrb->kernel_module, "draw_circle", mrb_draw_circle, MRB_ARGS_REQ(4));
  mrb_define_method(mrb, mrb->kernel_module, "draw_circle_v", mrb_draw_circle_v, MRB_ARGS_REQ(3));
  mrb_define_method(mrb, mrb->kernel_module, "draw_circle_sector", mrb_draw_circle_sector, MRB_ARGS_REQ(6));
  mrb_define_method(mrb, mrb->kernel_module, "draw_circle_sector_lines", mrb_draw_circle_sector_lines, MRB_ARGS_REQ(6));
}
