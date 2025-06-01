#include "mruby.h"

#include "mruby_integration/core/input/gamepad.hpp"

void
append_core_input(mrb_state* mrb)
{
  append_core_input_gamepad(mrb);
}
