#include "mruby.h"
#include "mruby/class.h"
#include "raylib.h"

#include "ruby/models/gesture.hpp"

struct RClass* Gesture_class;

auto
mrb_Gesture_set_enabled(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int flags;
  mrb_get_args(mrb, "i", &flags);

  SetGesturesEnabled(flags);

  return mrb_nil_value();
}

auto
mrb_Gesture_detected(mrb_state* mrb, mrb_value) -> mrb_value
{
  return mrb_int_value(mrb, GetGestureDetected());
}

auto
mrb_Gesture_detected_question(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int gesture;
  mrb_get_args(mrb, "i", &gesture);

  return mrb_bool_value(IsGestureDetected(gesture));
}

auto
mrb_Gesture_duration(mrb_state* mrb, mrb_value) -> mrb_value
{
  return mrb_float_value(mrb, GetGestureHoldDuration());
}

void
append_models_Gesture(mrb_state* mrb)
{
  Gesture_class = mrb_define_class(mrb, "Gesture", mrb->object_class);
  MRB_SET_INSTANCE_TT(Gesture_class, MRB_TT_DATA);

  mrb_define_class_method(
    mrb, Gesture_class, "enabled=", mrb_Gesture_set_enabled, MRB_ARGS_REQ(1));
  mrb_define_class_method(
    mrb, Gesture_class, "detected", mrb_Gesture_detected, MRB_ARGS_NONE());
  mrb_define_class_method(mrb,
                          Gesture_class,
                          "detected?",
                          mrb_Gesture_detected_question,
                          MRB_ARGS_REQ(1));
  mrb_define_class_method(
    mrb, Gesture_class, "duration", mrb_Gesture_duration, MRB_ARGS_NONE());

  load_ruby_models_gesture(mrb);
}
