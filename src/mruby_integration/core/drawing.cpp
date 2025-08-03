#include "mruby.h"
#include "raylib.h"

#include "ruby/core/drawing.hpp"

auto
mrb_begin_blend_mode(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int blend_mode;
  mrb_get_args(mrb, "i", &blend_mode);

  BeginBlendMode(blend_mode);
  return mrb_nil_value();
}

auto
mrb_end_blend_mode(mrb_state*, mrb_value) -> mrb_value
{
  EndBlendMode();
  return mrb_nil_value();
}

void
append_core_drawing(mrb_state* mrb)
{
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "begin_blend_mode",
                    mrb_begin_blend_mode,
                    MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "end_blend_mode",
                    mrb_end_blend_mode,
                    MRB_ARGS_NONE());

  load_ruby_core_drawing(mrb);
}
