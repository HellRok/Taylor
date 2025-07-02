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

void
append_models_Gesture(mrb_state* mrb)
{
  Gesture_class = mrb_define_class(mrb, "Gesture", mrb->object_class);
  MRB_SET_INSTANCE_TT(Gesture_class, MRB_TT_DATA);

  mrb_define_class_method(
    mrb, Gesture_class, "enabled=", mrb_Gesture_set_enabled, MRB_ARGS_REQ(1));

  load_ruby_models_gesture(mrb);
}
