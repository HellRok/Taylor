#include "mruby.h"
#include "mruby/class.h"
#include "raylib.h"

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
mrb_Window_close_question(mrb_state* mrb, mrb_value) -> mrb_value
{
  return mrb_bool_value(WindowShouldClose());
}

void
append_models_Window(mrb_state* mrb)
{
  Window_class = mrb_define_class(mrb, "Window", mrb->object_class);
  MRB_SET_INSTANCE_TT(Window_class, MRB_TT_DATA);
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
    mrb, Window_class, "close?", mrb_Window_close_question, MRB_ARGS_NONE());

  load_ruby_models_window(mrb);
}
