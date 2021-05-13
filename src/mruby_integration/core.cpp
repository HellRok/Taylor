#include "raylib.h"
#include "mruby.h"

#include "mruby_integration/core/drawing.hpp"
#include "mruby_integration/core/gestures.hpp"
#include "mruby_integration/core/input.hpp"
#include "mruby_integration/core/misc.hpp"
#include "mruby_integration/core/screen_space.hpp"
#include "mruby_integration/core/timing.hpp"
#include "mruby_integration/core/window.hpp"

void append_core(mrb_state *mrb) {
  append_core_drawing(mrb);
  append_core_gestures(mrb);
  append_core_input(mrb);
  append_core_misc(mrb);
  append_core_screen_space(mrb);
  append_core_timing(mrb);
  append_core_window(mrb);
}
