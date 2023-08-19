#include "mruby.h"
#include "raylib.h"

mrb_value
mrb_set_target_fps(mrb_state* mrb, mrb_value)
{
  mrb_int fps;
  mrb_get_args(mrb, "i", &fps);

  SetTargetFPS(fps);
  return mrb_nil_value();
}

mrb_value
mrb_get_fps(mrb_state* mrb, mrb_value)
{
  return mrb_int_value(mrb, GetFPS());
}

mrb_value
mrb_get_frame_time(mrb_state* mrb, mrb_value)
{
  return mrb_float_value(mrb, GetFrameTime());
}

mrb_value
mrb_get_time(mrb_state* mrb, mrb_value)
{
  return mrb_float_value(mrb, GetTime());
}
void
append_core_timing(mrb_state* mrb)
{
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "set_target_fps",
                    mrb_set_target_fps,
                    MRB_ARGS_REQ(1));
  mrb_define_method(
    mrb, mrb->kernel_module, "get_fps", mrb_get_fps, MRB_ARGS_NONE());
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "get_frame_time",
                    mrb_get_frame_time,
                    MRB_ARGS_NONE());
  mrb_define_method(
    mrb, mrb->kernel_module, "get_time", mrb_get_time, MRB_ARGS_NONE());
}
