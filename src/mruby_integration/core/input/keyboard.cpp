#include "mruby.h"
#include "raylib.h"

#include "ruby/core/input/keyboard.hpp"

auto
mrb_key_pressed(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int key;
  mrb_get_args(mrb, "i", &key);

  return mrb_bool_value(IsKeyPressed(key));
}

auto
mrb_key_down(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int key;
  mrb_get_args(mrb, "i", &key);

  return mrb_bool_value(IsKeyDown(key));
}

auto
mrb_key_released(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int key;
  mrb_get_args(mrb, "i", &key);

  return mrb_bool_value(IsKeyReleased(key));
}

auto
mrb_key_up(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int key;
  mrb_get_args(mrb, "i", &key);

  return mrb_bool_value(IsKeyUp(key));
}

auto
mrb_set_exit_key(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int key;
  mrb_get_args(mrb, "i", &key);

  SetExitKey(key);

  return mrb_nil_value();
}

auto
mrb_get_key_pressed(mrb_state* mrb, mrb_value) -> mrb_value
{
  return mrb_int_value(mrb, GetKeyPressed());
}

auto
mrb_get_char_pressed(mrb_state* mrb, mrb_value) -> mrb_value
{
  return mrb_int_value(mrb, GetCharPressed());
}

void
append_core_input_keyboard(mrb_state* mrb)
{
  mrb_define_method(
    mrb, mrb->kernel_module, "key_pressed?", mrb_key_pressed, MRB_ARGS_REQ(1));
  mrb_define_method(
    mrb, mrb->kernel_module, "key_down?", mrb_key_down, MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "key_released?",
                    mrb_key_released,
                    MRB_ARGS_REQ(1));
  mrb_define_method(
    mrb, mrb->kernel_module, "key_up?", mrb_key_up, MRB_ARGS_REQ(1));
  mrb_define_method(
    mrb, mrb->kernel_module, "set_exit_key", mrb_set_exit_key, MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "get_key_pressed",
                    mrb_get_key_pressed,
                    MRB_ARGS_NONE());
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "get_char_pressed",
                    mrb_get_char_pressed,
                    MRB_ARGS_NONE());

  load_ruby_core_input_keyboard(mrb);
}
