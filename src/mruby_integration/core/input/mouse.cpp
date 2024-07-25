#include "mruby.h"
#include "raylib.h"

#include "mruby_integration/models/vector2.hpp"
#include "mruby_integration/struct_types.hpp"

#include "ruby/core/input/mouse.hpp"

auto
mrb_set_mouse_position(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int x, y;
  mrb_get_args(mrb, "ii", &x, &y);

  SetMousePosition(x, y);

  return mrb_nil_value();
}

auto
mrb_set_mouse_offset(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int x, y;
  mrb_get_args(mrb, "ii", &x, &y);

  SetMouseOffset(x, y);

  return mrb_nil_value();
}

auto
mrb_set_mouse_scale(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int x, y;
  mrb_get_args(mrb, "ff", &x, &y);

  SetMouseScale(x, y);

  return mrb_nil_value();
}

auto
mrb_get_mouse_wheel_move(mrb_state* mrb, mrb_value) -> mrb_value
{
  return mrb_float_value(mrb, GetMouseWheelMove());
}

auto
mrb_set_mouse_cursor(mrb_state* mrb, mrb_value) -> mrb_value
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
