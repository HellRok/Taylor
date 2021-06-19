#include "raylib.h"
#include "mruby.h"

#include "mruby_integration/struct_types.hpp"

mrb_value mrb_draw_ellipse(mrb_state *mrb, mrb_value) {
  mrb_int x, y;
  mrb_float radius_h, radius_v;
  Color *colour;

  mrb_get_args(mrb, "iiffd", &x, &y, &radius_h, &radius_v, &colour, &Colour_type);

  DrawEllipse(x, y, radius_h, radius_v, *colour);
  return mrb_nil_value();
}

void append_shapes_ellipse(mrb_state *mrb) {
  mrb_define_method(mrb, mrb->kernel_module, "draw_ellipse", mrb_draw_ellipse, MRB_ARGS_REQ(5));
}
