#include "raylib.h"
#include "mruby.h"

#include "mruby_integration/struct_types.hpp"

mrb_value MrbDrawRectangle(mrb_state *mrb, mrb_value) {
  mrb_int x, y, width, height;
  Color *colour;

  mrb_get_args(mrb, "iiiid", &x, &y, &width, &height, &colour, &Colour_type);

  DrawRectangle(x, y, width, height, *colour);
  return mrb_nil_value();
}

void appendShapes(mrb_state *mrb) {
  mrb_define_method(mrb, mrb->kernel_module, "draw_rectangle", MrbDrawRectangle, MRB_ARGS_REQ(5));
}
