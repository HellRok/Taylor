#include "mruby.h"

#include "mruby_integration/core/input/gamepad.hpp"
#include "mruby_integration/core/input/keyboard.hpp"
#include "mruby_integration/core/input/mouse.hpp"
#include "mruby_integration/core/input/touch.hpp"

void append_core_input(mrb_state *mrb) {
  append_core_input_gamepad(mrb);
  append_core_input_keyboard(mrb);
  append_core_input_mouse(mrb);
  append_core_input_touch(mrb);
}
