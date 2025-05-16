#include "mruby.h"
#include "mruby/class.h"
#include "mruby/internal.h"
#include "mruby/variable.h"
#include "raylib.h"

#include "mruby_integration/exceptions.hpp"
#include "mruby_integration/models/vector2.hpp"
#include "mruby_integration/struct_types.hpp"
#include "ruby/models/window.hpp"

struct RClass* Window_class;

const char* title;

auto
mrb_Window_open(mrb_state* mrb, mrb_value) -> mrb_value
{
  // def self.open(width: 800, height: 480, title: "Taylor Game")
  mrb_int kw_num = 3;
  mrb_int kw_required = 0;
  mrb_sym kw_names[] = { mrb_intern_lit(mrb, "width"),
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

  if (mrb_undef_p(kw_values[2])) {
    title = "Taylor Game";
  } else {
    mrb_sym sym = mrb_obj_to_sym(mrb, kw_values[2]);
    title = mrb_sym_name(mrb, sym);
  }

  InitWindow(width, height, title);
  return mrb_nil_value();
}

auto
mrb_Window_close(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_mod_cv_set(
    mrb, Window_class, mrb_intern_cstr(mrb, "@@minimum_size"), mrb_nil_value());
  CloseWindow();
  return mrb_nil_value();
}

auto
mrb_Window_ready(mrb_state*, mrb_value) -> mrb_value
{
  return mrb_bool_value(IsWindowReady());
}

auto
mrb_Window_width(mrb_state* mrb, mrb_value) -> mrb_value
{
  return mrb_int_value(mrb, GetScreenWidth());
}

auto
mrb_Window_height(mrb_state* mrb, mrb_value) -> mrb_value
{
  return mrb_int_value(mrb, GetScreenHeight());
}

auto
mrb_Window_title(mrb_state* mrb, mrb_value) -> mrb_value
{
  return mrb_str_new_cstr(mrb, title);
}

auto
mrb_Window_set_title(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_get_args(mrb, "z", &title);

  SetWindowTitle(title);
  return mrb_nil_value();
}

auto
mrb_Window_close_question(mrb_state*, mrb_value) -> mrb_value
{
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
  mrb_int key;
  mrb_get_args(mrb, "i", &key);

  SetExitKey(key);

  return mrb_nil_value();
}

auto
mrb_Window_resized(mrb_state*, mrb_value) -> mrb_value
{
  return mrb_bool_value(IsWindowResized());
}

auto
mrb_Window_toggle_fullscreen(mrb_state*, mrb_value) -> mrb_value
{
  ToggleFullscreen();
  return mrb_nil_value();
}

auto
mrb_Window_maximise(mrb_state*, mrb_value) -> mrb_value
{
  MaximizeWindow();
  return mrb_nil_value();
}

auto
mrb_Window_minimise(mrb_state*, mrb_value) -> mrb_value
{
  MinimizeWindow();
  return mrb_nil_value();
}

auto
mrb_Window_restore(mrb_state*, mrb_value) -> mrb_value
{
  RestoreWindow();
  return mrb_nil_value();
}

auto
mrb_Window_set_icon(mrb_state* mrb, mrb_value) -> mrb_value
{
  Image* image;

  mrb_get_args(mrb, "d", &image, &Image_type);

  SetWindowIcon(*image);
  return mrb_nil_value();
}

auto
mrb_Window_set_position(mrb_state* mrb, mrb_value) -> mrb_value
{
  if (!IsWindowReady()) {
    raise_error(mrb,
                Window_class,
                "NotReadyError",
                "You must open the window before setting a position");
    return mrb_nil_value();
  }

  Vector2* vector;

  mrb_get_args(mrb, "d", &vector, &Vector2_type);

  SetWindowPosition(vector->x, vector->y);
  return mrb_nil_value();
}

auto
mrb_Window_set_minimum_size(mrb_state* mrb, mrb_value) -> mrb_value
{
  if (!IsWindowReady()) {
    raise_error(mrb,
                Window_class,
                "NotReadyError",
                "You must open the window before setting a minimum size");
    return mrb_nil_value();
  }

  auto* minimum_size = static_cast<Vector2*>(malloc(sizeof(Vector2)));
  mrb_get_args(mrb, "d", &minimum_size, &Vector2_type);

  mrb_value obj = mrb_obj_value(
    Data_Wrap_Struct(mrb, Vector2_class, &Vector2_type, minimum_size));
  setup_Vector2(mrb, obj, minimum_size, minimum_size->x, minimum_size->y);

  mrb_mod_cv_set(
    mrb, Window_class, mrb_intern_cstr(mrb, "@@minimum_size"), obj);

  add_owned_object(&obj);

  SetWindowMinSize(minimum_size->x, minimum_size->y);
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
  mrb_define_class_method(
    mrb, Window_class, "width", mrb_Window_width, MRB_ARGS_NONE());
  mrb_define_class_method(
    mrb, Window_class, "height", mrb_Window_height, MRB_ARGS_NONE());
  mrb_define_class_method(
    mrb, Window_class, "title", mrb_Window_title, MRB_ARGS_NONE());
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
    mrb, Window_class, "position=", mrb_Window_set_position, MRB_ARGS_REQ(1));
  mrb_define_class_method(mrb,
                          Window_class,
                          "minimum_size=",
                          mrb_Window_set_minimum_size,
                          MRB_ARGS_REQ(1));

  load_ruby_models_window(mrb);
}
