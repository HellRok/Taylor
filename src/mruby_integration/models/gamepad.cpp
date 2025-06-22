#include "mruby.h"
#include "mruby/class.h"
#include "raylib.h"

#include "mruby_integration/exceptions.hpp"
#include "mruby_integration/helpers.hpp"
#include "mruby_integration/models/gamepad.hpp"
#include "mruby_integration/struct_types.hpp"

#include "ruby/models/gamepad.hpp"

struct RClass* Gamepad_class;

auto
mrb_Gamepad_value(mrb_state* mrb, Gamepad* gamepad) -> mrb_value
{
  mrb_value obj =
    mrb_obj_value(Data_Wrap_Struct(mrb, Gamepad_class, &Gamepad_type, gamepad));

  return obj;
}

void
Gamepad_init(Gamepad* gamepad, int index)
{
  gamepad->index = index;
}

auto
mrb_Gamepad_initialize(mrb_state* mrb, mrb_value self) -> mrb_value
{
  // def initialize(index:)
  mrb_int kw_num = 1;
  mrb_int kw_required = 1;
  mrb_sym kw_names[] = { mrb_intern_lit(mrb, "index") };
  mrb_value kw_values[kw_num];
  mrb_kwargs kwargs = { kw_num, kw_required, kw_names, kw_values, nullptr };
  mrb_get_args(mrb, ":", &kwargs);

  int index = 0;
  if (!mrb_undef_p(kw_values[0])) {
    index = mrb_as_int(mrb, kw_values[0]);
  }

  Gamepad* gamepad;
  mrb_self_ptr(mrb, self, Gamepad, gamepad);
  Gamepad_init(gamepad, index);

  mrb_data_init(self, gamepad, &Gamepad_type);
  return self;
}

mrb_attr_reader(mrb, self, int, Gamepad, index);

auto
mrb_Gamepad_available(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Gamepad, gamepad);

  return mrb_bool_value(IsGamepadAvailable(gamepad->index));
}

auto
mrb_Gamepad_name(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Gamepad, gamepad);

  return mrb_str_new_cstr(mrb, GetGamepadName(gamepad->index));
}

auto
mrb_Gamepad_pressed(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Gamepad, gamepad);

  mrb_int button;
  mrb_get_args(mrb, "i", &button);

  return mrb_bool_value(IsGamepadButtonPressed(gamepad->index, button));
}

void
append_models_Gamepad(mrb_state* mrb)
{
  Gamepad_class = mrb_define_class(mrb, "Gamepad", mrb->object_class);
  MRB_SET_INSTANCE_TT(Gamepad_class, MRB_TT_DATA);

  mrb_define_method(
    mrb, Gamepad_class, "initialize", mrb_Gamepad_initialize, MRB_ARGS_REQ(1));
  mrb_attr_reader_define(mrb, Gamepad, index);
  mrb_define_method(
    mrb, Gamepad_class, "available?", mrb_Gamepad_available, MRB_ARGS_NONE());
  mrb_define_method(
    mrb, Gamepad_class, "name", mrb_Gamepad_name, MRB_ARGS_NONE());
  mrb_define_method(
    mrb, Gamepad_class, "pressed?", mrb_Gamepad_pressed, MRB_ARGS_REQ(1));

  load_ruby_models_gamepad(mrb);
}
