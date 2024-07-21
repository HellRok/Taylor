#include "mruby.h"
#include "mruby/class.h"
#include "mruby/data.h"
#include "raylib.h"

#include "mruby_integration/struct_types.hpp"

#include "ruby/models/mouse.hpp"

struct RClass* Mouse_class;

auto
mrb_Mouse_pressed(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int button;
  mrb_get_args(mrb, "i", &button);

  return mrb_bool_value(IsMouseButtonPressed(button));
}

auto
mrb_Mouse_down(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int button;
  mrb_get_args(mrb, "i", &button);

  return mrb_bool_value(IsMouseButtonDown(button));
}

void
append_models_Mouse(mrb_state* mrb)
{
  Mouse_class = mrb_define_class(mrb, "Mouse", mrb->object_class);
  MRB_SET_INSTANCE_TT(Mouse_class, MRB_TT_DATA);

  mrb_define_class_method(
    mrb, Mouse_class, "pressed?", mrb_Mouse_pressed, MRB_ARGS_REQ(1));
  mrb_define_class_method(
    mrb, Mouse_class, "down?", mrb_Mouse_down, MRB_ARGS_REQ(1));

  load_ruby_models_mouse(mrb);
}
