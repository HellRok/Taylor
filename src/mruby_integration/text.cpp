#include "raylib.h"
#include "mruby.h"

mrb_value mrb_draw_fps(mrb_state *mrb, mrb_value) {
  mrb_int x, y;

  mrb_get_args(mrb, "ii", &x, &y);

  DrawFPS(x, y);
  return mrb_nil_value();
}

void append_text(mrb_state *mrb) {
  mrb_define_method(mrb, mrb->kernel_module, "draw_fps", mrb_draw_fps, MRB_ARGS_REQ(2));
}
