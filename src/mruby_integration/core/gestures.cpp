#include "raylib.h"
#include "mruby.h"
#include "mruby/compile.h"

mrb_value mrb_set_gestures_enabled(mrb_state *mrb, mrb_value) {
  mrb_int flags;
  mrb_get_args(mrb, "i", &flags);

  SetGesturesEnabled(flags);

  return mrb_nil_value();
}

mrb_value mrb_get_gesture_detected(mrb_state *mrb, mrb_value) {
  return mrb_int_value(mrb, GetGestureDetected());
}

void append_core_gestures(mrb_state *mrb) {
  mrb_define_method(mrb, mrb->kernel_module, "set_gestures_enabled", mrb_get_gesture_detected, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "get_gesture_detected", mrb_get_gesture_detected, MRB_ARGS_NONE());

  mrb_load_string(mrb, R"(
    GESTURE_NONE        = 0
    GESTURE_TAP         = 1
    GESTURE_DOUBLETAP   = 2
    GESTURE_HOLD        = 4
    GESTURE_DRAG        = 8
    GESTURE_SWIPE_RIGHT = 16
    GESTURE_SWIPE_LEFT  = 32
    GESTURE_SWIPE_UP    = 64
    GESTURE_SWIPE_DOWN  = 128
    GESTURE_PINCH_IN    = 256
    GESTURE_PINCH_OUT   = 512
  )");
}
