#include "mruby.h"
#include "raylib.h"

#include "ruby/core/gestures.hpp"

mrb_value
mrb_set_gestures_enabled(mrb_state* mrb, mrb_value)
{
  mrb_int flags;
  mrb_get_args(mrb, "i", &flags);

  SetGesturesEnabled(flags);

  return mrb_nil_value();
}

mrb_value
mrb_get_gesture_detected(mrb_state* mrb, mrb_value)
{
  return mrb_int_value(mrb, GetGestureDetected());
}

void
append_core_gestures(mrb_state* mrb)
{
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "set_gestures_enabled",
                    mrb_get_gesture_detected,
                    MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "get_gesture_detected",
                    mrb_get_gesture_detected,
                    MRB_ARGS_NONE());

  load_ruby_core_gestures(mrb);
}
