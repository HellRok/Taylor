#include "mruby.h"
#include "raylib.h"

#include "ruby/core/input/gamepad.hpp"

auto
mrb_get_gamepad_name(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int index;
  mrb_get_args(mrb, "i", &index);

  const char* name = GetGamepadName(index);
  return mrb_str_new_cstr(mrb, name);
}

auto
mrb_gamepad_button_pressed(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int index, button;
  mrb_get_args(mrb, "ii", &index, &button);

  return mrb_bool_value(IsGamepadButtonPressed(index, button));
}

auto
mrb_gamepad_button_down(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int index, button;
  mrb_get_args(mrb, "ii", &index, &button);

  return mrb_bool_value(IsGamepadButtonDown(index, button));
}

auto
mrb_gamepad_button_released(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int index, button;
  mrb_get_args(mrb, "ii", &index, &button);

  return mrb_bool_value(IsGamepadButtonReleased(index, button));
}

auto
mrb_gamepad_button_up(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int index, button;
  mrb_get_args(mrb, "ii", &index, &button);

  return mrb_bool_value(IsGamepadButtonUp(index, button));
}

auto
mrb_get_gamepad_button_pressed(mrb_state* mrb, mrb_value) -> mrb_value
{
  return mrb_int_value(mrb, GetGamepadButtonPressed());
}

auto
mrb_get_gamepad_axis_count(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int index;
  mrb_get_args(mrb, "i", &index);

  return mrb_int_value(mrb, GetGamepadAxisCount(index));
}

auto
mrb_get_gamepad_axis_movement(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int index, axis;
  mrb_get_args(mrb, "ii", &index, &axis);

  return mrb_float_value(mrb, GetGamepadAxisMovement(index, axis));
}

auto
mrb_set_gamepad_mappings(mrb_state* mrb, mrb_value) -> mrb_value
{
  char* mappings;
  mrb_get_args(mrb, "z", &mappings);

  return mrb_int_value(mrb, SetGamepadMappings(mappings));
}

void
append_core_input_gamepad(mrb_state* mrb)
{
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "get_gamepad_name",
                    mrb_get_gamepad_name,
                    MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "gamepad_button_pressed?",
                    mrb_gamepad_button_pressed,
                    MRB_ARGS_REQ(2));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "gamepad_button_down?",
                    mrb_gamepad_button_down,
                    MRB_ARGS_REQ(2));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "gamepad_button_released?",
                    mrb_gamepad_button_released,
                    MRB_ARGS_REQ(2));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "gamepad_button_up?",
                    mrb_gamepad_button_up,
                    MRB_ARGS_REQ(2));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "get_gamepad_button_pressed",
                    mrb_get_gamepad_button_pressed,
                    MRB_ARGS_NONE());
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "get_gamepad_axis_count",
                    mrb_get_gamepad_axis_count,
                    MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "get_gamepad_axis_movement",
                    mrb_get_gamepad_axis_movement,
                    MRB_ARGS_REQ(2));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "set_gamepad_mappings",
                    mrb_set_gamepad_mappings,
                    MRB_ARGS_REQ(1));

  load_ruby_core_input_gamepad(mrb);
}
