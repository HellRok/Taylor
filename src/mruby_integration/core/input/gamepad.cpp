#include "raylib.h"
#include "mruby.h"
#include "mruby/compile.h"
#include "mruby/string.h"

mrb_value mrb_is_gamepad_available(mrb_state *mrb, mrb_value) {
  mrb_int index;
  mrb_get_args(mrb, "i", &index);

  return mrb_bool_value(IsGamepadAvailable(index));
}

mrb_value mrb_get_gamepad_name(mrb_state *mrb, mrb_value) {
  mrb_int index;
  mrb_get_args(mrb, "i", &index);

  const char* name = GetGamepadName(index);
  return mrb_str_new_cstr(mrb, name);
}

mrb_value mrb_is_gamepad_button_down(mrb_state *mrb, mrb_value) {
  mrb_int index, button;
  mrb_get_args(mrb, "ii", &index, &button);

  return mrb_bool_value(IsGamepadButtonDown(index, button));
}

mrb_value mrb_get_gamepad_button_pressed(mrb_state *mrb, mrb_value) {
  return mrb_int_value(mrb, GetGamepadButtonPressed());
}

mrb_value mrb_get_gamepad_axis_count(mrb_state *mrb, mrb_value) {
  mrb_int index;
  mrb_get_args(mrb, "i", &index);

  return mrb_int_value(mrb, GetGamepadAxisCount(index));
}

mrb_value mrb_get_gamepad_axis_movement(mrb_state *mrb, mrb_value) {
  mrb_int index, axis;
  mrb_get_args(mrb, "ii", &index, &axis);

  return mrb_float_value(mrb, GetGamepadAxisMovement(index, axis));
}

void append_core_input_gamepad(mrb_state *mrb) {
  mrb_define_method(mrb, mrb->kernel_module, "is_gamepad_available", mrb_is_gamepad_available, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "get_gamepad_name", mrb_get_gamepad_name, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "is_gamepad_button_down", mrb_is_gamepad_button_down, MRB_ARGS_REQ(2));
  mrb_define_method(mrb, mrb->kernel_module, "get_gamepad_button_pressed", mrb_get_gamepad_button_pressed, MRB_ARGS_NONE());
  mrb_define_method(mrb, mrb->kernel_module, "get_gamepad_axis_count", mrb_get_gamepad_axis_count, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "get_gamepad_axis_movement", mrb_get_gamepad_axis_movement, MRB_ARGS_REQ(2));

  mrb_load_string(mrb, R"(
    GAMEPAD_BUTTON_UNKNOWN = 0

    # This is normally a DPAD
    GAMEPAD_BUTTON_LEFT_FACE_UP = 1
    GAMEPAD_BUTTON_LEFT_FACE_RIGHT = 2
    GAMEPAD_BUTTON_LEFT_FACE_DOWN = 3
    GAMEPAD_BUTTON_LEFT_FACE_LEFT = 4

    # This normally corresponds with PlayStation and Xbox controllers
    # XBOX: [Y,X,A,B]
    # PS3: [Triangle,Square,Cross,Circle]
    # No support for 6 button controllers though..
    GAMEPAD_BUTTON_RIGHT_FACE_UP = 5
    GAMEPAD_BUTTON_RIGHT_FACE_RIGHT = 6
    GAMEPAD_BUTTON_RIGHT_FACE_DOWN = 7
    GAMEPAD_BUTTON_RIGHT_FACE_LEFT = 8

    # Triggers
    GAMEPAD_BUTTON_LEFT_TRIGGER_1 = 9
    GAMEPAD_BUTTON_LEFT_TRIGGER_2 = 10
    GAMEPAD_BUTTON_RIGHT_TRIGGER_1 = 11
    GAMEPAD_BUTTON_RIGHT_TRIGGER_2 = 12

    # These are buttons in the center of the gamepad
    GAMEPAD_BUTTON_MIDDLE_LEFT = 13     # PS3 Select
    GAMEPAD_BUTTON_MIDDLE = 14          # PS Button/XBOX Button
    GAMEPAD_BUTTON_MIDDLE_RIGHT = 15    # PS3 Start

    # These are the joystick press in buttons
    GAMEPAD_BUTTON_LEFT_THUMB = 16
    GAMEPAD_BUTTON_RIGHT_THUM = 17

    # Left stick
    GAMEPAD_AXIS_LEFT_X = 0
    GAMEPAD_AXIS_LEFT_Y = 1

    # Right stick
    GAMEPAD_AXIS_RIGHT_X = 2
    GAMEPAD_AXIS_RIGHT_Y = 3

    # Pressure levels for the back triggers
    GAMEPAD_AXIS_LEFT_TRIGGER = 4       # [1..-1] (pressure-level)
    GAMEPAD_AXIS_RIGHT_TRIGGER = 5      # [1..-1] (pressure-level)
  )");
}
