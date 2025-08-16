#include "mruby.h"
#include "mruby/class.h"
#include "mruby/variable.h"
#include "raylib.h"

#include "mruby_integration/exceptions.hpp"
#include "mruby_integration/models/image.hpp"
#include "mruby_integration/models/monitor.hpp"
#include "mruby_integration/models/vector2.hpp"
#include "mruby_integration/struct_types.hpp"

#include "ruby/models/window.hpp"

struct RClass* Window_class;

auto
mrb_Window_open(mrb_state* mrb, mrb_value) -> mrb_value
{
  if (IsWindowReady()) {
    raise_error(mrb,
                Window_class,
                "AlreadyOpenError",
                "You can only open one Window at a time");
    return mrb_nil_value();
  }

  // def self.open(width: 800, height: 480, title: "Taylor Game")
  const mrb_int kw_num = 3;
  const mrb_int kw_required = 0;
  const mrb_sym kw_names[] = { mrb_intern_lit(mrb, "width"),
                               mrb_intern_lit(mrb, "height"),
                               mrb_intern_lit(mrb, "title") };
  mrb_value kw_values[kw_num];
  mrb_kwargs kwargs = { kw_num, kw_required, kw_names, kw_values, nullptr };
  mrb_get_args(mrb, ":", &kwargs);

  int width = 0;
  if (!mrb_undef_p(kw_values[0])) {
    width = mrb_as_int(mrb, kw_values[0]);
  }

  int height = 0;
  if (!mrb_undef_p(kw_values[1])) {
    height = mrb_as_int(mrb, kw_values[1]);
  }

  const char* title;
  if (mrb_undef_p(kw_values[2])) {
    title = "Taylor Game";
  } else {
    mrb_sym sym = mrb_obj_to_sym(mrb, kw_values[2]);
    title = mrb_sym_name(mrb, sym);
  }

  mrb_mod_cv_set(mrb,
                 Window_class,
                 mrb_intern_cstr(mrb, "@@title"),
                 mrb_str_new_cstr(mrb, title));
  mrb_mod_cv_set(mrb,
                 Window_class,
                 mrb_intern_cstr(mrb, "@@opacity"),
                 mrb_float_value(mrb, 1.0));

  InitWindow(width, height, title);
  return mrb_nil_value();
}

auto
mrb_Window_close(mrb_state* mrb, mrb_value) -> mrb_value
{
  EXIT_UNLESS_WINDOW_READY("You must call Window.open before Window.close")

  mrb_mod_cv_set(mrb,
                 Window_class,
                 mrb_intern_cstr(mrb, "@@minimum_resolution"),
                 mrb_nil_value());
  mrb_mod_cv_set(
    mrb, Window_class, mrb_intern_cstr(mrb, "@@title"), mrb_nil_value());
  mrb_mod_cv_set(
    mrb, Window_class, mrb_intern_cstr(mrb, "@@opacity"), mrb_nil_value());

  CloseWindow();
  return mrb_nil_value();
}

auto
mrb_Window_ready(mrb_state*, mrb_value) -> mrb_value
{
  return mrb_bool_value(IsWindowReady());
}

auto
mrb_Window_begin_drawing(mrb_state*, mrb_value) -> mrb_value
{
  BeginDrawing();
  return mrb_nil_value();
}

auto
mrb_Window_end_drawing(mrb_state*, mrb_value) -> mrb_value
{
  EndDrawing();
  return mrb_nil_value();
}

auto
mrb_Window_width(mrb_state* mrb, mrb_value) -> mrb_value
{
  EXIT_UNLESS_WINDOW_READY("You must call Window.open before Window.width")

  return mrb_int_value(mrb, GetScreenWidth());
}

auto
mrb_Window_height(mrb_state* mrb, mrb_value) -> mrb_value
{
  EXIT_UNLESS_WINDOW_READY("You must call Window.open before Window.height")

  return mrb_int_value(mrb, GetScreenHeight());
}

auto
mrb_Window_set_title(mrb_state* mrb, mrb_value) -> mrb_value
{
  EXIT_UNLESS_WINDOW_READY("You must call Window.open before Window.title=")

  const char* title;
  mrb_get_args(mrb, "z", &title);

  mrb_mod_cv_set(mrb,
                 Window_class,
                 mrb_intern_cstr(mrb, "@@title"),
                 mrb_str_new_cstr(mrb, title));

  SetWindowTitle(title);
  return mrb_nil_value();
}

auto
mrb_Window_close_question(mrb_state* mrb, mrb_value) -> mrb_value
{
  EXIT_UNLESS_WINDOW_READY("You must call Window.open before Window.close?")

  return mrb_bool_value(WindowShouldClose());
}

auto
mrb_Window_flag_question(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int flag;
  mrb_get_args(mrb, "i", &flag);

  return mrb_bool_value(IsWindowState(flag));
}

auto
mrb_Window_flags_equal(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int flag;
  mrb_get_args(mrb, "i", &flag);

  SetWindowState(flag);
  return mrb_nil_value();
}

auto
mrb_Window_config_equals(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int flag;
  mrb_get_args(mrb, "i", &flag);

  SetConfigFlags(flag);
  return mrb_nil_value();
}

auto
mrb_Window_clear_flag(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int flag;
  mrb_get_args(mrb, "i", &flag);

  ClearWindowState(flag);
  return mrb_nil_value();
}

auto
mrb_Window_set_exit_key(mrb_state* mrb, mrb_value) -> mrb_value
{
  EXIT_UNLESS_WINDOW_READY("You must call Window.open before Window.exit_key=")

  mrb_int key;
  mrb_get_args(mrb, "i", &key);

  SetExitKey(key);

  return mrb_nil_value();
}

auto
mrb_Window_resized(mrb_state* mrb, mrb_value) -> mrb_value
{
  EXIT_UNLESS_WINDOW_READY("You must call Window.open before Window.resized?")

  return mrb_bool_value(IsWindowResized());
}

auto
mrb_Window_toggle_fullscreen(mrb_state* mrb, mrb_value) -> mrb_value
{
  EXIT_UNLESS_WINDOW_READY(
    "You must call Window.open before Window.toggle_fullscreen")

  ToggleFullscreen();
  return mrb_nil_value();
}

auto
mrb_Window_maximise(mrb_state* mrb, mrb_value) -> mrb_value
{
  EXIT_UNLESS_WINDOW_READY("You must call Window.open before Window.maximise")

  MaximizeWindow();
  return mrb_nil_value();
}

auto
mrb_Window_minimise(mrb_state* mrb, mrb_value) -> mrb_value
{
  EXIT_UNLESS_WINDOW_READY("You must call Window.open before Window.minimise")

  MinimizeWindow();
  return mrb_nil_value();
}

auto
mrb_Window_restore(mrb_state* mrb, mrb_value) -> mrb_value
{
  EXIT_UNLESS_WINDOW_READY("You must call Window.open before Window.restore")

  RestoreWindow();
  return mrb_nil_value();
}

auto
mrb_Window_set_icon(mrb_state* mrb, mrb_value) -> mrb_value
{
  EXIT_UNLESS_WINDOW_READY("You must call Window.open before Window.icon=")

  Image* image;

  mrb_get_args(mrb, "d", &image, &Image_type);

  SetWindowIcon(*image);
  return mrb_nil_value();
}

auto
mrb_Window_position(mrb_state* mrb, mrb_value) -> mrb_value
{
  EXIT_UNLESS_WINDOW_READY("You must call Window.open before Window.position")

  auto* position = static_cast<Vector2*>(malloc(sizeof(Vector2)));
  *position = GetWindowPosition();

  return mrb_Vector2_value(mrb, position);
}

auto
mrb_Window_set_position(mrb_state* mrb, mrb_value) -> mrb_value
{
  EXIT_UNLESS_WINDOW_READY("You must call Window.open before Window.position=")

  Vector2* vector;

  mrb_get_args(mrb, "d", &vector, &Vector2_type);

  SetWindowPosition(vector->x, vector->y);
  return mrb_nil_value();
}

auto
mrb_Window_set_resolution(mrb_state* mrb, mrb_value) -> mrb_value
{
  EXIT_UNLESS_WINDOW_READY(
    "You must call Window.open before Window.resolution=")

  Vector2* vector;

  mrb_get_args(mrb, "d", &vector, &Vector2_type);

  SetWindowSize(vector->x, vector->y);
  return mrb_nil_value();
}

auto
mrb_Window_set_minimum_resolution(mrb_state* mrb, mrb_value) -> mrb_value
{
  EXIT_UNLESS_WINDOW_READY(
    "You must call Window.open before Window.minimum_resolution=")

  auto* minimum_resolution = static_cast<Vector2*>(malloc(sizeof(Vector2)));
  mrb_get_args(mrb, "d", &minimum_resolution, &Vector2_type);

  mrb_value obj = mrb_Vector2_value(mrb, minimum_resolution);

  mrb_mod_cv_set(
    mrb, Window_class, mrb_intern_cstr(mrb, "@@minimum_resolution"), obj);

  add_reference(minimum_resolution);

  SetWindowMinSize(minimum_resolution->x, minimum_resolution->y);
  return mrb_nil_value();
}

auto
mrb_Window_set_opacity(mrb_state* mrb, mrb_value) -> mrb_value
{
  EXIT_UNLESS_WINDOW_READY("You must call Window.open before Window.opacity=")

  mrb_float opacity;
  mrb_get_args(mrb, "f", &opacity);

  if (opacity < 0.0 || opacity > 1.0) {
    mrb_raise(mrb, E_ARGUMENT_ERROR, "Opacity must be within (0.0..1.0)");
  }

  mrb_mod_cv_set(mrb,
                 Window_class,
                 mrb_intern_cstr(mrb, "@@opacity"),
                 mrb_float_value(mrb, opacity));

  SetWindowOpacity(opacity);
  return mrb_nil_value();
}

auto
mrb_Window_to_image(mrb_state* mrb, mrb_value) -> mrb_value
{
  EXIT_UNLESS_WINDOW_READY("You must call Window.open before Window.to_image")

  auto* image = static_cast<Image*>(malloc(sizeof(Image)));
  *image = LoadImageFromScreen();

  mrb_value obj =
    mrb_obj_value(Data_Wrap_Struct(mrb, Image_class, &Image_type, image));

  setup_Image(mrb,
              obj,
              image,
              image->width,
              image->height,
              image->mipmaps,
              image->format);

  return obj;
}

auto
mrb_Window_set_monitor(mrb_state* mrb, mrb_value) -> mrb_value
{
  EXIT_UNLESS_WINDOW_READY("You must call Window.open before Window.monitor=")

  Monitor* monitor;
  mrb_get_args(mrb, "d", &monitor, &Monitor_type);
  SetWindowMonitor(monitor->id);

  return mrb_nil_value();
}

auto
mrb_Window_scale(mrb_state* mrb, mrb_value) -> mrb_value
{
  EXIT_UNLESS_WINDOW_READY("You must call Window.open before Window.scale")

  auto* scale = static_cast<Vector2*>(malloc(sizeof(Vector2)));
  *scale = GetWindowScaleDPI();

  return mrb_Vector2_value(mrb, scale);
}

auto
mrb_Window_clear(mrb_state* mrb, mrb_value) -> mrb_value
{
  EXIT_UNLESS_WINDOW_READY("You must call Window.open before Window.clear")

  // def self.clear(colour: Colour::BLACK)
  const mrb_int kw_num = 1;
  const mrb_int kw_required = 0;
  const mrb_sym kw_names[] = { mrb_intern_lit(mrb, "colour") };
  mrb_value kw_values[kw_num];
  mrb_kwargs kwargs = { kw_num, kw_required, kw_names, kw_values, nullptr };
  mrb_get_args(mrb, ":", &kwargs);

  Color* colour;
  if (mrb_undef_p(kw_values[0])) {
    auto default_colour = BLACK;
    colour = &default_colour;
  } else {
    colour = static_cast<struct Color*> DATA_PTR(kw_values[0]);
  }

  ClearBackground(*colour);
  return mrb_nil_value();
}

auto
mrb_Window_screenshot(mrb_state* mrb, mrb_value) -> mrb_value
{
  EXIT_UNLESS_WINDOW_READY("You must call Window.open before Window.screenshot")

  char* filename;
  mrb_get_args(mrb, "z", &filename);
  TakeScreenshot(filename);

  return mrb_nil_value();
}

auto
mrb_Window_set_target_frame_rate(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int frame_rate;
  mrb_get_args(mrb, "i", &frame_rate);

  SetTargetFPS(frame_rate);

  return mrb_nil_value();
}

auto
mrb_Window_frame_rate(mrb_state* mrb, mrb_value) -> mrb_value
{
  return mrb_int_value(mrb, GetFPS());
}

auto
mrb_Window_frame_time(mrb_state* mrb, mrb_value) -> mrb_value
{
  return mrb_float_value(mrb, GetFrameTime());
}

auto
mrb_Window_seconds_open(mrb_state* mrb, mrb_value) -> mrb_value
{
  return mrb_float_value(mrb, GetTime());
}

auto
mrb_Window_draw_frame_rate(mrb_state* mrb, mrb_value) -> mrb_value
{
  EXIT_UNLESS_WINDOW_READY(
    "You must call Window.open before Window.draw_frame_rate")

  // def self.draw_frame_rate(x: 10, y: 10)
  const mrb_int kw_num = 2;
  const mrb_int kw_required = 0;
  const mrb_sym kw_names[] = { mrb_intern_lit(mrb, "x"),
                               mrb_intern_lit(mrb, "y") };
  mrb_value kw_values[kw_num];
  mrb_kwargs kwargs = { kw_num, kw_required, kw_names, kw_values, nullptr };
  mrb_get_args(mrb, ":", &kwargs);

  int x = 10;
  if (!mrb_undef_p(kw_values[0])) {
    x = mrb_as_int(mrb, kw_values[0]);
  }

  int y = 10;
  if (!mrb_undef_p(kw_values[1])) {
    y = mrb_as_int(mrb, kw_values[1]);
  }

  DrawFPS(x, y);

  return mrb_nil_value();
}

void
append_models_Window(mrb_state* mrb)
{
  Window_class = mrb_define_module(mrb, "Window");
  mrb_define_class_method(
    mrb, Window_class, "open", mrb_Window_open, MRB_ARGS_REQ(1));
  mrb_define_class_method(
    mrb, Window_class, "close", mrb_Window_close, MRB_ARGS_NONE());
  mrb_define_class_method(
    mrb, Window_class, "ready?", mrb_Window_ready, MRB_ARGS_NONE());
  mrb_define_class_method(mrb,
                          Window_class,
                          "begin_drawing",
                          mrb_Window_begin_drawing,
                          MRB_ARGS_NONE());
  mrb_define_class_method(
    mrb, Window_class, "end_drawing", mrb_Window_end_drawing, MRB_ARGS_NONE());
  mrb_define_class_method(
    mrb, Window_class, "width", mrb_Window_width, MRB_ARGS_NONE());
  mrb_define_class_method(
    mrb, Window_class, "height", mrb_Window_height, MRB_ARGS_NONE());
  mrb_define_class_method(
    mrb, Window_class, "title=", mrb_Window_set_title, MRB_ARGS_REQ(1));
  mrb_define_class_method(
    mrb, Window_class, "close?", mrb_Window_close_question, MRB_ARGS_NONE());
  mrb_define_class_method(
    mrb, Window_class, "flag?", mrb_Window_flag_question, MRB_ARGS_REQ(1));
  mrb_define_class_method(
    mrb, Window_class, "flags=", mrb_Window_flags_equal, MRB_ARGS_REQ(1));
  mrb_define_class_method(
    mrb, Window_class, "config=", mrb_Window_config_equals, MRB_ARGS_REQ(1));
  mrb_define_class_method(
    mrb, Window_class, "clear_flag", mrb_Window_clear_flag, MRB_ARGS_REQ(1));
  mrb_define_class_method(
    mrb, Window_class, "exit_key=", mrb_Window_set_exit_key, MRB_ARGS_REQ(1));
  mrb_define_class_method(
    mrb, Window_class, "resized?", mrb_Window_resized, MRB_ARGS_NONE());
  mrb_define_class_method(mrb,
                          Window_class,
                          "toggle_fullscreen",
                          mrb_Window_toggle_fullscreen,
                          MRB_ARGS_NONE());
  mrb_define_class_method(
    mrb, Window_class, "maximise", mrb_Window_maximise, MRB_ARGS_NONE());
  mrb_define_class_method(
    mrb, Window_class, "minimise", mrb_Window_minimise, MRB_ARGS_NONE());
  mrb_define_class_method(
    mrb, Window_class, "restore", mrb_Window_restore, MRB_ARGS_NONE());
  mrb_define_class_method(
    mrb, Window_class, "icon=", mrb_Window_set_icon, MRB_ARGS_REQ(1));
  mrb_define_class_method(
    mrb, Window_class, "position", mrb_Window_position, MRB_ARGS_NONE());
  mrb_define_class_method(
    mrb, Window_class, "position=", mrb_Window_set_position, MRB_ARGS_REQ(1));
  mrb_define_class_method(mrb,
                          Window_class,
                          "resolution=",
                          mrb_Window_set_resolution,
                          MRB_ARGS_REQ(1));
  mrb_define_class_method(mrb,
                          Window_class,
                          "minimum_resolution=",
                          mrb_Window_set_minimum_resolution,
                          MRB_ARGS_REQ(1));
  mrb_define_class_method(
    mrb, Window_class, "opacity=", mrb_Window_set_opacity, MRB_ARGS_REQ(1));
  mrb_define_class_method(
    mrb, Window_class, "to_image", mrb_Window_to_image, MRB_ARGS_NONE());
  mrb_define_class_method(
    mrb, Window_class, "monitor=", mrb_Window_set_monitor, MRB_ARGS_REQ(1));
  mrb_define_class_method(
    mrb, Window_class, "scale", mrb_Window_scale, MRB_ARGS_NONE());
  mrb_define_class_method(
    mrb, Window_class, "clear", mrb_Window_clear, MRB_ARGS_REQ(1));
  mrb_define_class_method(
    mrb, Window_class, "screenshot", mrb_Window_screenshot, MRB_ARGS_REQ(1));
  mrb_define_class_method(mrb,
                          Window_class,
                          "target_frame_rate=",
                          mrb_Window_set_target_frame_rate,
                          MRB_ARGS_REQ(1));
  mrb_define_class_method(
    mrb, Window_class, "frame_rate", mrb_Window_frame_rate, MRB_ARGS_NONE());
  mrb_define_class_method(
    mrb, Window_class, "frame_time", mrb_Window_frame_time, MRB_ARGS_NONE());
  mrb_define_class_method(mrb,
                          Window_class,
                          "seconds_open",
                          mrb_Window_seconds_open,
                          MRB_ARGS_NONE());
  mrb_define_class_method(mrb,
                          Window_class,
                          "draw_frame_rate",
                          mrb_Window_draw_frame_rate,
                          MRB_ARGS_REQ(1));

  load_ruby_models_window(mrb);
}
