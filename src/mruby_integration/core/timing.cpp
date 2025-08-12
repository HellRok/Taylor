#include "mruby.h"
#include "raylib.h"

auto
mrb_get_fps(mrb_state* mrb, mrb_value) -> mrb_value
{
  return mrb_int_value(mrb, GetFPS());
}

auto
mrb_get_frame_time(mrb_state* mrb, mrb_value) -> mrb_value
{
  return mrb_float_value(mrb, GetFrameTime());
}

auto
mrb_get_time(mrb_state* mrb, mrb_value) -> mrb_value
{
  return mrb_float_value(mrb, GetTime());
}
void
append_core_timing(mrb_state* mrb)
{
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
