#include "mruby.h"
#include "mruby/class.h"
#include "mruby/data.h"
#include "raylib.h"

#include "mruby_integration/models/vector2.hpp"
#include "mruby_integration/struct_types.hpp"

#include "ruby/models/touch.hpp"

struct RClass* Touch_class;

auto
mrb_Touch_position_for(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int index;
  mrb_get_args(mrb, "i", &index);

  auto* position = static_cast<Vector2*>(malloc(sizeof(Vector2)));
  *position = GetTouchPosition(index);

  mrb_value obj = mrb_obj_value(
    Data_Wrap_Struct(mrb, Vector2_class, &Vector2_type, position));

  setup_Vector2(mrb, obj, position, position->x, position->y);

  return obj;
}

void
append_models_Touch(mrb_state* mrb)
{
  Touch_class = mrb_define_class(mrb, "Touch", mrb->object_class);
  MRB_SET_INSTANCE_TT(Touch_class, MRB_TT_DATA);

  mrb_define_class_method(
    mrb, Touch_class, "position_for", mrb_Touch_position_for, MRB_ARGS_REQ(1));

  load_ruby_models_touch(mrb);
}
