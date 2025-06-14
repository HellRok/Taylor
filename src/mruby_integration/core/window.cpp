#include "mruby.h"
#include "raylib.h"

#include "mruby_integration/models/vector2.hpp"
#include "mruby_integration/struct_types.hpp"

auto
mrb_set_window_monitor(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int monitor;

  mrb_get_args(mrb, "i", &monitor);

  SetWindowMonitor(monitor);
  return mrb_nil_value();
}

auto
mrb_get_window_scale_dpi(mrb_state* mrb, mrb_value) -> mrb_value
{
  auto* scale = static_cast<Vector2*>(malloc(sizeof(Vector2)));
  *scale = GetWindowScaleDPI();

  return mrb_Vector2_value(mrb, scale);
}

void
append_core_window(mrb_state* mrb)
{
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "set_window_monitor",
                    mrb_set_window_monitor,
                    MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "get_window_scale_dpi",
                    mrb_get_window_scale_dpi,
                    MRB_ARGS_NONE());
}
