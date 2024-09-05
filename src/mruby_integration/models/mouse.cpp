#include "mruby.h"
#include "mruby/class.h"
#include "mruby/data.h"
#include "raylib.h"

#include "mruby_integration/models/vector2.hpp"
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

auto
mrb_Mouse_released(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int button;
  mrb_get_args(mrb, "i", &button);

  return mrb_bool_value(IsMouseButtonReleased(button));
}

auto
mrb_Mouse_up(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int button;
  mrb_get_args(mrb, "i", &button);

  return mrb_bool_value(IsMouseButtonUp(button));
}

auto
mrb_Mouse_position(mrb_state* mrb, mrb_value) -> mrb_value
{
  auto* position = static_cast<Vector2*>(malloc(sizeof(Vector2)));
  *position = GetMousePosition();

  mrb_value obj = mrb_obj_value(
    Data_Wrap_Struct(mrb, Vector2_class, &Vector2_type, position));

  setup_Vector2(mrb, obj, position, position->x, position->y);

  return obj;
}

auto
mrb_Mouse_set_position(mrb_state* mrb, mrb_value) -> mrb_value
{
  Vector2* vector;
  mrb_get_args(mrb, "d", &vector, &Vector2_type);

  SetMousePosition(vector->x, vector->y);

  return mrb_nil_value();
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
  mrb_define_class_method(
    mrb, Mouse_class, "released?", mrb_Mouse_released, MRB_ARGS_REQ(1));
  mrb_define_class_method(
    mrb, Mouse_class, "up?", mrb_Mouse_up, MRB_ARGS_REQ(1));
  mrb_define_class_method(
    mrb, Mouse_class, "position", mrb_Mouse_position, MRB_ARGS_NONE());
  mrb_define_class_method(
    mrb, Mouse_class, "position=", mrb_Mouse_set_position, MRB_ARGS_REQ(1));

  load_ruby_models_mouse(mrb);
}
