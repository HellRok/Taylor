#include "mruby.h"
#include "raylib.h"

#include "mruby_integration/models/vector2.hpp"
#include "mruby_integration/struct_types.hpp"

#include "ruby/core/input/mouse.hpp"

mrb_value
mrb_mouse_button_pressed(mrb_state* mrb, mrb_value)
{
  mrb_int button;
  mrb_get_args(mrb, "i", &button);

  return mrb_bool_value(IsMouseButtonPressed(button));
}

mrb_value
mrb_mouse_button_down(mrb_state* mrb, mrb_value)
{
  mrb_int button;
  mrb_get_args(mrb, "i", &button);

  return mrb_bool_value(IsMouseButtonDown(button));
}

mrb_value
mrb_mouse_button_released(mrb_state* mrb, mrb_value)
{
  mrb_int button;
  mrb_get_args(mrb, "i", &button);

  return mrb_bool_value(IsMouseButtonReleased(button));
}

mrb_value
mrb_mouse_button_up(mrb_state* mrb, mrb_value)
{
  mrb_int button;
  mrb_get_args(mrb, "i", &button);

  return mrb_bool_value(IsMouseButtonUp(button));
}

mrb_value
mrb_get_mouse_x(mrb_state* mrb, mrb_value)
{
  return mrb_int_value(mrb, GetMouseX());
}

mrb_value
mrb_get_mouse_y(mrb_state* mrb, mrb_value)
{
  return mrb_int_value(mrb, GetMouseY());
}

mrb_value
mrb_get_mouse_position(mrb_state* mrb, mrb_value)
{
  Vector2* position = (Vector2*)malloc(sizeof(Vector2));
  *position = GetMousePosition();

  mrb_value obj = mrb_obj_value(
    Data_Wrap_Struct(mrb, Vector2_class, &Vector2_type, position));

  setup_Vector2(mrb, obj, position, position->x, position->y);

  return obj;
}

mrb_value
mrb_set_mouse_position(mrb_state* mrb, mrb_value)
{
  mrb_int x, y;
  mrb_get_args(mrb, "ii", &x, &y);

  SetMousePosition(x, y);

  return mrb_nil_value();
}

mrb_value
mrb_set_mouse_offset(mrb_state* mrb, mrb_value)
{
  mrb_int x, y;
  mrb_get_args(mrb, "ii", &x, &y);

  SetMouseOffset(x, y);

  return mrb_nil_value();
}

mrb_value
mrb_set_mouse_scale(mrb_state* mrb, mrb_value)
{
  mrb_int x, y;
  mrb_get_args(mrb, "ff", &x, &y);

  SetMouseScale(x, y);

  return mrb_nil_value();
}

mrb_value
mrb_get_mouse_wheel_move(mrb_state* mrb, mrb_value)
{
  return mrb_float_value(mrb, GetMouseWheelMove());
}

mrb_value
mrb_set_mouse_cursor(mrb_state* mrb, mrb_value)
{
  mrb_int cursor;
  mrb_get_args(mrb, "i", &cursor);

  SetMouseCursor(cursor);

  return mrb_nil_value();
}

void
append_core_input_mouse(mrb_state* mrb)
{
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "mouse_button_pressed?",
                    mrb_mouse_button_pressed,
                    MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "mouse_button_down?",
                    mrb_mouse_button_down,
                    MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "mouse_button_released?",
                    mrb_mouse_button_released,
                    MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "mouse_button_up?",
                    mrb_mouse_button_up,
                    MRB_ARGS_REQ(1));
  mrb_define_method(
    mrb, mrb->kernel_module, "get_mouse_x", mrb_get_mouse_x, MRB_ARGS_NONE());
  mrb_define_method(
    mrb, mrb->kernel_module, "get_mouse_y", mrb_get_mouse_y, MRB_ARGS_NONE());
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "get_mouse_position",
                    mrb_get_mouse_position,
                    MRB_ARGS_NONE());
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "set_mouse_position",
                    mrb_set_mouse_position,
                    MRB_ARGS_REQ(2));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "set_mouse_offset",
                    mrb_set_mouse_offset,
                    MRB_ARGS_REQ(2));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "set_mouse_scale",
                    mrb_set_mouse_scale,
                    MRB_ARGS_REQ(2));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "get_mouse_wheel_move",
                    mrb_get_mouse_wheel_move,
                    MRB_ARGS_NONE());
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "set_mouse_cursor",
                    mrb_set_mouse_cursor,
                    MRB_ARGS_REQ(1));

  load_ruby_core_input_mouse(mrb);
}
