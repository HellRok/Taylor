#include "raylib.h"
#include "mruby.h"
#include "mruby/compile.h"

#include "mruby_integration/models/vector2.hpp"
#include "mruby_integration/struct_types.hpp"

mrb_value mrb_init_window(mrb_state *mrb, mrb_value) {
  mrb_int width, height;
  char* title;
  mrb_get_args(mrb, "iiz", &width, &height, &title);

  InitWindow(width, height, title);
  return mrb_nil_value();
}

mrb_value mrb_window_should_close(mrb_state*, mrb_value) {
  return mrb_bool_value(WindowShouldClose());
}

mrb_value mrb_close_window(mrb_state*, mrb_value) {
  CloseWindow();
  return mrb_nil_value();
}

mrb_value mrb_is_window_ready(mrb_state*, mrb_value) {
  return mrb_bool_value(IsWindowReady());
}

mrb_value mrb_is_window_state(mrb_state *mrb, mrb_value) {
  mrb_int flag;
  mrb_get_args(mrb, "i", &flag);

  return mrb_bool_value(IsWindowState(flag));
}

mrb_value mrb_set_window_state(mrb_state *mrb, mrb_value) {
  mrb_int flag;
  mrb_get_args(mrb, "i", &flag);

  SetWindowState(flag);
  return mrb_nil_value();
}

mrb_value mrb_is_window_fullscreen(mrb_state*, mrb_value) {
  return mrb_bool_value(IsWindowFullscreen());
}

mrb_value mrb_is_window_hidden(mrb_state*, mrb_value) {
  return mrb_bool_value(IsWindowHidden());
}

mrb_value mrb_is_window_minimised(mrb_state*, mrb_value) {
  return mrb_bool_value(IsWindowMinimized());
}

mrb_value mrb_is_window_maximised(mrb_state*, mrb_value) {
  return mrb_bool_value(IsWindowMaximized());
}

mrb_value mrb_is_window_focused(mrb_state*, mrb_value) {
  return mrb_bool_value(IsWindowFocused());
}

mrb_value mrb_is_window_resized(mrb_state*, mrb_value) {
  return mrb_bool_value(IsWindowResized());
}

mrb_value mrb_clear_window_state(mrb_state *mrb, mrb_value) {
  mrb_int flag;
  mrb_get_args(mrb, "i", &flag);

  ClearWindowState(flag);
  return mrb_nil_value();
}

mrb_value mrb_toggle_fullscreen(mrb_state*, mrb_value) {
  ToggleFullscreen();
  return mrb_nil_value();
}

mrb_value mrb_maximise_window(mrb_state*, mrb_value) {
  MaximizeWindow();
  return mrb_nil_value();
}

mrb_value mrb_minimise_window(mrb_state*, mrb_value) {
  MinimizeWindow();
  return mrb_nil_value();
}

mrb_value mrb_restore_window(mrb_state*, mrb_value) {
  RestoreWindow();
  return mrb_nil_value();
}

mrb_value mrb_set_window_icon(mrb_state *mrb, mrb_value) {
  Image *image;

  mrb_get_args(mrb, "d", &image, &Image_type);

  SetWindowIcon(*image);
  return mrb_nil_value();
}

mrb_value mrb_set_window_title(mrb_state *mrb, mrb_value) {
  char* title;

  mrb_get_args(mrb, "z", &title);

  SetWindowTitle(title);
  return mrb_nil_value();
}

mrb_value mrb_set_window_position(mrb_state *mrb, mrb_value) {
  mrb_int x, y;

  mrb_get_args(mrb, "ii", &x, &y);

  SetWindowPosition(x, y);
  return mrb_nil_value();
}

mrb_value mrb_set_window_monitor(mrb_state *mrb, mrb_value) {
  mrb_int monitor;

  mrb_get_args(mrb, "i", &monitor);

  SetWindowMonitor(monitor);
  return mrb_nil_value();
}

mrb_value mrb_set_window_min_size(mrb_state *mrb, mrb_value) {
  mrb_int width, height;

  mrb_get_args(mrb, "ii", &width, &height);

  SetWindowMinSize(width, height);
  return mrb_nil_value();
}

mrb_value mrb_set_window_size(mrb_state *mrb, mrb_value) {
  mrb_int width, height;

  mrb_get_args(mrb, "ii", &width, &height);

  SetWindowSize(width, height);
  return mrb_nil_value();
}

mrb_value mrb_get_screen_width(mrb_state *mrb, mrb_value) {
  return mrb_int_value(mrb, GetScreenWidth());
}

mrb_value mrb_get_screen_height(mrb_state *mrb, mrb_value) {
  return mrb_int_value(mrb, GetScreenHeight());
}

mrb_value mrb_get_monitor_count(mrb_state *mrb, mrb_value) {
  return mrb_int_value(mrb, GetMonitorCount());
}

mrb_value mrb_get_current_monitor(mrb_state *mrb, mrb_value) {
  return mrb_int_value(mrb, GetCurrentMonitor());
}

mrb_value mrb_get_monitor_position(mrb_state *mrb, mrb_value) {
  mrb_int monitor;
  mrb_get_args(mrb, "i", &monitor);

  Vector2 *position = (Vector2 *)malloc(sizeof(Vector2));
  *position = GetMonitorPosition(monitor);

  mrb_value obj = mrb_obj_value(Data_Wrap_Struct(mrb, Vector2_class, &Vector2_type, position));

  setup_Vector2(mrb, obj, position, position->x, position->y);

  return obj;
}

mrb_value mrb_get_monitor_width(mrb_state *mrb, mrb_value) {
  mrb_int monitor;
  mrb_get_args(mrb, "i", &monitor);

  return mrb_int_value(mrb, GetMonitorWidth(monitor));
}

mrb_value mrb_get_monitor_height(mrb_state *mrb, mrb_value) {
  mrb_int monitor;
  mrb_get_args(mrb, "i", &monitor);

  return mrb_int_value(mrb, GetMonitorHeight(monitor));
}

mrb_value mrb_get_monitor_refresh_rate(mrb_state *mrb, mrb_value) {
  mrb_int monitor;
  mrb_get_args(mrb, "i", &monitor);

  return mrb_int_value(mrb, GetMonitorRefreshRate(monitor));
}

mrb_value mrb_get_window_position(mrb_state *mrb, mrb_value) {
  Vector2 *position = (Vector2 *)malloc(sizeof(Vector2));
  *position = GetWindowPosition();

  mrb_value obj = mrb_obj_value(Data_Wrap_Struct(mrb, Vector2_class, &Vector2_type, position));

  setup_Vector2(mrb, obj, position, position->x, position->y);

  return obj;
}

mrb_value mrb_get_window_scale_dpi(mrb_state *mrb, mrb_value) {
  Vector2 *scale = (Vector2 *)malloc(sizeof(Vector2));
  *scale = GetWindowScaleDPI();

  mrb_value obj = mrb_obj_value(Data_Wrap_Struct(mrb, Vector2_class, &Vector2_type, scale));

  setup_Vector2(mrb, obj, scale, scale->x, scale->y);

  return obj;
}

void append_core_window(mrb_state *mrb) {
  mrb_define_method(mrb, mrb->kernel_module, "init_window", mrb_init_window, MRB_ARGS_REQ(3));
  mrb_define_method(mrb, mrb->kernel_module, "window_should_close?", mrb_window_should_close, MRB_ARGS_NONE());
  mrb_define_method(mrb, mrb->kernel_module, "close_window", mrb_close_window, MRB_ARGS_NONE());
  mrb_define_method(mrb, mrb->kernel_module, "is_window_ready?", mrb_is_window_ready, MRB_ARGS_NONE());
  mrb_define_method(mrb, mrb->kernel_module, "is_window_fullscreen?", mrb_is_window_fullscreen, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "is_window_hidden?", mrb_is_window_hidden, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "is_window_minimised?", mrb_is_window_minimised, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "is_window_maximised?", mrb_is_window_maximised, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "is_window_focused?", mrb_is_window_focused, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "is_window_resized?", mrb_is_window_resized, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "is_window_state?", mrb_is_window_state, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "set_window_state", mrb_set_window_state, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "clear_window_state", mrb_clear_window_state, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "toggle_fullscreen", mrb_toggle_fullscreen, MRB_ARGS_NONE());
  mrb_define_method(mrb, mrb->kernel_module, "maximise_window", mrb_maximise_window, MRB_ARGS_NONE());
  mrb_define_method(mrb, mrb->kernel_module, "minimise_window", mrb_minimise_window, MRB_ARGS_NONE());
  mrb_define_method(mrb, mrb->kernel_module, "restore_window", mrb_restore_window, MRB_ARGS_NONE());
  mrb_define_method(mrb, mrb->kernel_module, "set_window_icon", mrb_set_window_icon, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "set_window_title", mrb_set_window_title, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "set_window_position", mrb_set_window_position, MRB_ARGS_REQ(2));
  mrb_define_method(mrb, mrb->kernel_module, "set_window_monitor", mrb_set_window_monitor, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "set_window_min_size", mrb_set_window_min_size, MRB_ARGS_REQ(2));
  mrb_define_method(mrb, mrb->kernel_module, "set_window_size", mrb_set_window_size, MRB_ARGS_REQ(2));
  mrb_define_method(mrb, mrb->kernel_module, "get_screen_width", mrb_get_screen_width, MRB_ARGS_NONE());
  mrb_define_method(mrb, mrb->kernel_module, "get_screen_height", mrb_get_screen_height, MRB_ARGS_NONE());
  mrb_define_method(mrb, mrb->kernel_module, "get_monitor_count", mrb_get_monitor_count, MRB_ARGS_NONE());
  mrb_define_method(mrb, mrb->kernel_module, "get_current_monitor", mrb_get_current_monitor, MRB_ARGS_NONE());
  mrb_define_method(mrb, mrb->kernel_module, "get_monitor_position", mrb_get_monitor_position, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "get_monitor_width", mrb_get_monitor_width, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "get_monitor_height", mrb_get_monitor_height, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "get_monitor_refresh_rate", mrb_get_monitor_refresh_rate, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "get_window_position", mrb_get_window_position, MRB_ARGS_NONE());
  mrb_define_method(mrb, mrb->kernel_module, "get_window_scale_dpi", mrb_get_window_scale_dpi, MRB_ARGS_NONE());

  mrb_load_string(mrb, R"(
    FLAG_VSYNC_HINT         = 0x00000040   # Set to try enabling V-Sync on GPU
    FLAG_FULLSCREEN_MODE    = 0x00000002   # Set to run program in fullscreen
    FLAG_WINDOW_RESIZABLE   = 0x00000004   # Set to allow resizable window
    FLAG_WINDOW_UNDECORATED = 0x00000008   # Set to disable window decoration (frame and buttons)
    FLAG_WINDOW_HIDDEN      = 0x00000080   # Set to hide window
    FLAG_WINDOW_MINIMISED   = 0x00000200   # Set to minimize window (iconify)
    FLAG_WINDOW_MAXIMISED   = 0x00000400   # Set to maximize window (expanded to monitor)
    FLAG_WINDOW_UNFOCUSED   = 0x00000800   # Set to window non focused
    FLAG_WINDOW_TOPMOST     = 0x00001000   # Set to window always on top
    FLAG_WINDOW_ALWAYS_RUN  = 0x00000100   # Set to allow windows running while minimized
    FLAG_WINDOW_TRANSPARENT = 0x00000010   # Set to allow transparent framebuffer
    FLAG_WINDOW_HIGHDPI     = 0x00002000   # Set to support HighDPI
    FLAG_MSAA_4X_HINT       = 0x00000020   # Set to try enabling MSAA 4X
    FLAG_INTERLACED_HINT    = 0x00010000   # Set to try enabling interlaced video format (for V3D)
    )");
}
