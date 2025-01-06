#include "mruby.h"
#include "raylib.h"

auto
mrb_set_exit_key(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int key;
  mrb_get_args(mrb, "i", &key);

  SetExitKey(key);

  return mrb_nil_value();
}

auto
mrb_get_char_pressed(mrb_state* mrb, mrb_value) -> mrb_value
{
  return mrb_int_value(mrb, GetCharPressed());
}

void
append_core_input_keyboard(mrb_state* mrb)
{
  mrb_define_method(
    mrb, mrb->kernel_module, "set_exit_key", mrb_set_exit_key, MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "get_char_pressed",
                    mrb_get_char_pressed,
                    MRB_ARGS_NONE());
}
