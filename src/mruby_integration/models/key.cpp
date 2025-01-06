#include "mruby.h"
#include "mruby/class.h"
#include "mruby/data.h"
#include "raylib.h"
#include <cstdlib>

#include "mruby_integration/exceptions.hpp"
#include "mruby_integration/helpers.hpp"
#include "mruby_integration/struct_types.hpp"

#include "ruby/models/key.hpp"

struct RClass* Key_class;

auto
mrb_Key_pressed(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int key;

  mrb_get_args(mrb, "i", &key);
  return mrb_bool_value(IsKeyPressed(key));
}

auto
mrb_Key_down(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int key;

  mrb_get_args(mrb, "i", &key);
  return mrb_bool_value(IsKeyDown(key));
}

auto
mrb_Key_released(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int key;

  mrb_get_args(mrb, "i", &key);
  return mrb_bool_value(IsKeyReleased(key));
}

auto
mrb_Key_up(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int key;

  mrb_get_args(mrb, "i", &key);
  return mrb_bool_value(IsKeyUp(key));
}

auto
mrb_Key_get_pressed(mrb_state* mrb, mrb_value) -> mrb_value
{
  int key_code = GetKeyPressed();

  if (key_code > 0) {
    return mrb_int_value(mrb, key_code);
  } else {
    return mrb_nil_value();
  }
}

void
append_models_Key(mrb_state* mrb)
{
  Key_class = mrb_define_class(mrb, "Key", mrb->object_class);
  MRB_SET_INSTANCE_TT(Key_class, MRB_TT_DATA);
  mrb_define_class_method(
    mrb, Key_class, "pressed?", mrb_Key_pressed, MRB_ARGS_REQ(1));
  mrb_define_class_method(
    mrb, Key_class, "down?", mrb_Key_down, MRB_ARGS_REQ(1));
  mrb_define_class_method(
    mrb, Key_class, "released?", mrb_Key_released, MRB_ARGS_REQ(1));
  mrb_define_class_method(mrb, Key_class, "up?", mrb_Key_up, MRB_ARGS_REQ(1));
  mrb_define_class_method(
    mrb, Key_class, "pressed", mrb_Key_get_pressed, MRB_ARGS_NONE());

  load_ruby_models_key(mrb);
}
