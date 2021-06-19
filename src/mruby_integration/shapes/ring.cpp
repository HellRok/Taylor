#include "raylib.h"
#include "mruby.h"

#include "mruby_integration/struct_types.hpp"

mrb_value mrb_draw_ring(mrb_state *mrb, mrb_value) {
  Vector2 *vector;
  mrb_float inner_radius, outer_radius, start_angle, end_angle;
  mrb_int segments;
  Color *colour;

  mrb_get_args(mrb, "dffffid",
      &vector, &Vector2_type,
      &inner_radius,
      &outer_radius,
      &start_angle,
      &end_angle,
      &segments,
      &colour, &Colour_type);

  DrawRing(*vector, inner_radius, outer_radius, start_angle, end_angle, segments, *colour);
  return mrb_nil_value();
}

mrb_value mrb_draw_ring_lines(mrb_state *mrb, mrb_value) {
  Vector2 *vector;
  mrb_float inner_radius, outer_radius, start_angle, end_angle;
  mrb_int segments;
  Color *colour;

  mrb_get_args(mrb, "dffffid",
      &vector, &Vector2_type,
      &inner_radius,
      &outer_radius,
      &start_angle,
      &end_angle,
      &segments,
      &colour, &Colour_type);

  DrawRingLines(*vector, inner_radius, outer_radius, start_angle, end_angle, segments, *colour);
  return mrb_nil_value();
}

void append_shapes_ring(mrb_state *mrb) {
  mrb_define_method(mrb, mrb->kernel_module, "draw_ring", mrb_draw_ring, MRB_ARGS_REQ(7));
  mrb_define_method(mrb, mrb->kernel_module, "draw_ring_lines", mrb_draw_ring_lines, MRB_ARGS_REQ(7));
}
