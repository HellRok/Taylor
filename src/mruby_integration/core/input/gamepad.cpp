#include "mruby.h"
#include "raylib.h"

auto
mrb_set_gamepad_mappings(mrb_state* mrb, mrb_value) -> mrb_value
{
  char* mappings;
  mrb_get_args(mrb, "z", &mappings);

  return mrb_int_value(mrb, SetGamepadMappings(mappings));
}

void
append_core_input_gamepad(mrb_state* mrb)
{
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "set_gamepad_mappings",
                    mrb_set_gamepad_mappings,
                    MRB_ARGS_REQ(1));
}
