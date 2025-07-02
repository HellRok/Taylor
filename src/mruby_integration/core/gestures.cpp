#include "mruby.h"
#include "raylib.h"

#include "ruby/core/gestures.hpp"

auto
mrb_get_gesture_detected(mrb_state* mrb, mrb_value) -> mrb_value
{
  return mrb_int_value(mrb, GetGestureDetected());
}

void
append_core_gestures(mrb_state* mrb)
{
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "get_gesture_detected",
                    mrb_get_gesture_detected,
                    MRB_ARGS_NONE());

  load_ruby_core_gestures(mrb);
}
