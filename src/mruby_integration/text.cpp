#include "raylib.h"
#include "mruby.h"

mrb_value MrbDrawFPS(mrb_state *mrb, mrb_value) {
  mrb_int x, y;

  mrb_get_args(mrb, "ii", &x, &y);

  DrawFPS(x, y);
  return mrb_nil_value();
}

void appendText(mrb_state *mrb) {
  mrb_define_method(mrb, mrb->kernel_module, "draw_fps", MrbDrawFPS, MRB_ARGS_REQ(2));
}
