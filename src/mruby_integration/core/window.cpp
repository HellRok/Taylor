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
mrb_get_monitor_count(mrb_state* mrb, mrb_value) -> mrb_value
{
  return mrb_int_value(mrb, GetMonitorCount());
}

auto
mrb_get_current_monitor(mrb_state* mrb, mrb_value) -> mrb_value
{
  return mrb_int_value(mrb, GetCurrentMonitor());
}

auto
mrb_get_monitor_position(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int monitor;
  mrb_get_args(mrb, "i", &monitor);

  auto* position = static_cast<Vector2*>(malloc(sizeof(Vector2)));
  *position = GetMonitorPosition(monitor);

  mrb_value obj = mrb_obj_value(
    Data_Wrap_Struct(mrb, Vector2_class, &Vector2_type, position));

  setup_Vector2(mrb, obj, position, position->x, position->y);

  return obj;
}

auto
mrb_get_monitor_width(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int monitor;
  mrb_get_args(mrb, "i", &monitor);

  return mrb_int_value(mrb, GetMonitorWidth(monitor));
}

auto
mrb_get_monitor_height(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int monitor;
  mrb_get_args(mrb, "i", &monitor);

  return mrb_int_value(mrb, GetMonitorHeight(monitor));
}

auto
mrb_get_monitor_refresh_rate(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int monitor;
  mrb_get_args(mrb, "i", &monitor);

  return mrb_int_value(mrb, GetMonitorRefreshRate(monitor));
}

auto
mrb_get_window_scale_dpi(mrb_state* mrb, mrb_value) -> mrb_value
{
  auto* scale = static_cast<Vector2*>(malloc(sizeof(Vector2)));
  *scale = GetWindowScaleDPI();

  mrb_value obj =
    mrb_obj_value(Data_Wrap_Struct(mrb, Vector2_class, &Vector2_type, scale));

  setup_Vector2(mrb, obj, scale, scale->x, scale->y);

  return obj;
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
                    "get_monitor_count",
                    mrb_get_monitor_count,
                    MRB_ARGS_NONE());
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "get_current_monitor",
                    mrb_get_current_monitor,
                    MRB_ARGS_NONE());
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "get_monitor_position",
                    mrb_get_monitor_position,
                    MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "get_monitor_width",
                    mrb_get_monitor_width,
                    MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "get_monitor_height",
                    mrb_get_monitor_height,
                    MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "get_monitor_refresh_rate",
                    mrb_get_monitor_refresh_rate,
                    MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "get_window_scale_dpi",
                    mrb_get_window_scale_dpi,
                    MRB_ARGS_NONE());
}
