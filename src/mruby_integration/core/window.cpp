#include "mruby.h"
#include "raylib.h"

#include "mruby_integration/models/vector2.hpp"
#include "mruby_integration/struct_types.hpp"

#include "ruby/core/window.hpp"

auto
mrb_window_state(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int flag;
  mrb_get_args(mrb, "i", &flag);

  return mrb_bool_value(IsWindowState(flag));
}

auto
mrb_set_window_state(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int flag;
  mrb_get_args(mrb, "i", &flag);

  SetWindowState(flag);
  return mrb_nil_value();
}

auto
mrb_window_fullscreen(mrb_state*, mrb_value) -> mrb_value
{
  return mrb_bool_value(IsWindowFullscreen());
}

auto
mrb_window_hidden(mrb_state*, mrb_value) -> mrb_value
{
  return mrb_bool_value(IsWindowHidden());
}

auto
mrb_window_minimised(mrb_state*, mrb_value) -> mrb_value
{
  return mrb_bool_value(IsWindowMinimized());
}

auto
mrb_window_maximised(mrb_state*, mrb_value) -> mrb_value
{
  return mrb_bool_value(IsWindowMaximized());
}

auto
mrb_window_focused(mrb_state*, mrb_value) -> mrb_value
{
  return mrb_bool_value(IsWindowFocused());
}

auto
mrb_window_resized(mrb_state*, mrb_value) -> mrb_value
{
  return mrb_bool_value(IsWindowResized());
}

auto
mrb_clear_window_state(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int flag;
  mrb_get_args(mrb, "i", &flag);

  ClearWindowState(flag);
  return mrb_nil_value();
}

auto
mrb_toggle_fullscreen(mrb_state*, mrb_value) -> mrb_value
{
  ToggleFullscreen();
  return mrb_nil_value();
}

auto
mrb_maximise_window(mrb_state*, mrb_value) -> mrb_value
{
  MaximizeWindow();
  return mrb_nil_value();
}

auto
mrb_minimise_window(mrb_state*, mrb_value) -> mrb_value
{
  MinimizeWindow();
  return mrb_nil_value();
}

auto
mrb_restore_window(mrb_state*, mrb_value) -> mrb_value
{
  RestoreWindow();
  return mrb_nil_value();
}

auto
mrb_set_window_icon(mrb_state* mrb, mrb_value) -> mrb_value
{
  Image* image;

  mrb_get_args(mrb, "d", &image, &Image_type);

  SetWindowIcon(*image);
  return mrb_nil_value();
}

auto
mrb_set_window_title(mrb_state* mrb, mrb_value) -> mrb_value
{
  char* title;

  mrb_get_args(mrb, "z", &title);

  SetWindowTitle(title);
  return mrb_nil_value();
}

auto
mrb_set_window_position(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int x, y;

  mrb_get_args(mrb, "ii", &x, &y);

  SetWindowPosition(x, y);
  return mrb_nil_value();
}

auto
mrb_set_window_monitor(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int monitor;

  mrb_get_args(mrb, "i", &monitor);

  SetWindowMonitor(monitor);
  return mrb_nil_value();
}

auto
mrb_set_window_min_size(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int width, height;

  mrb_get_args(mrb, "ii", &width, &height);

  SetWindowMinSize(width, height);
  return mrb_nil_value();
}

auto
mrb_set_window_size(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int width, height;

  mrb_get_args(mrb, "ii", &width, &height);

  SetWindowSize(width, height);
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
mrb_get_window_position(mrb_state* mrb, mrb_value) -> mrb_value
{
  auto* position = static_cast<Vector2*>(malloc(sizeof(Vector2)));
  *position = GetWindowPosition();

  mrb_value obj = mrb_obj_value(
    Data_Wrap_Struct(mrb, Vector2_class, &Vector2_type, position));

  setup_Vector2(mrb, obj, position, position->x, position->y);

  return obj;
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
                    "window_fullscreen?",
                    mrb_window_fullscreen,
                    MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "window_hidden?",
                    mrb_window_hidden,
                    MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "window_minimised?",
                    mrb_window_minimised,
                    MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "window_maximised?",
                    mrb_window_maximised,
                    MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "window_focused?",
                    mrb_window_focused,
                    MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "window_resized?",
                    mrb_window_resized,
                    MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "window_state?",
                    mrb_window_state,
                    MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "set_window_state",
                    mrb_set_window_state,
                    MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "clear_window_state",
                    mrb_clear_window_state,
                    MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "toggle_fullscreen",
                    mrb_toggle_fullscreen,
                    MRB_ARGS_NONE());
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "maximise_window",
                    mrb_maximise_window,
                    MRB_ARGS_NONE());
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "minimise_window",
                    mrb_minimise_window,
                    MRB_ARGS_NONE());
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "restore_window",
                    mrb_restore_window,
                    MRB_ARGS_NONE());
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "set_window_icon",
                    mrb_set_window_icon,
                    MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "set_window_title",
                    mrb_set_window_title,
                    MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "set_window_position",
                    mrb_set_window_position,
                    MRB_ARGS_REQ(2));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "set_window_monitor",
                    mrb_set_window_monitor,
                    MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "set_window_min_size",
                    mrb_set_window_min_size,
                    MRB_ARGS_REQ(2));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "set_window_size",
                    mrb_set_window_size,
                    MRB_ARGS_REQ(2));
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
                    "get_window_position",
                    mrb_get_window_position,
                    MRB_ARGS_NONE());
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "get_window_scale_dpi",
                    mrb_get_window_scale_dpi,
                    MRB_ARGS_NONE());

  load_ruby_core_window(mrb);
}
