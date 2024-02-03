#include "mruby.h"
#include "mruby/string.h"
#include "raylib.h"

#include "mruby_integration/models/font.hpp"
#include "mruby_integration/models/vector2.hpp"
#include "mruby_integration/struct_types.hpp"

auto
mrb_draw_fps(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int x, y;

  mrb_get_args(mrb, "ii", &x, &y);

  DrawFPS(x, y);
  return mrb_nil_value();
}

void
append_text(mrb_state* mrb)
{
  mrb_define_method(
    mrb, mrb->kernel_module, "draw_fps", mrb_draw_fps, MRB_ARGS_REQ(2));
}
