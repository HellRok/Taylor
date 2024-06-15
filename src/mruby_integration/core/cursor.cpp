#include "mruby.h"
#include "raylib.h"

auto
mrb_cursor_on_screen(mrb_state*, mrb_value) -> mrb_value
{
  return mrb_bool_value(IsCursorOnScreen());
}

void
append_core_cursor(mrb_state* mrb)
{
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "cursor_on_screen?",
                    mrb_cursor_on_screen,
                    MRB_ARGS_NONE());
}
