#include "mruby.h"
#include "raylib.h"

#include "mruby_integration/models/vector2.hpp"
#include "mruby_integration/struct_types.hpp"

#include "ruby/core/input/mouse.hpp"

auto
mrb_set_mouse_cursor(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int cursor;
  mrb_get_args(mrb, "i", &cursor);

  SetMouseCursor(cursor);

  return mrb_nil_value();
}

void
append_core_input_mouse(mrb_state* mrb)
{
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "set_mouse_cursor",
                    mrb_set_mouse_cursor,
                    MRB_ARGS_REQ(1));

  load_ruby_core_input_mouse(mrb);
}
