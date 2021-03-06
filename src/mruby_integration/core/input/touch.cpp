#include "raylib.h"
#include "mruby.h"

#include "mruby_integration/models/vector2.hpp"
#include "mruby_integration/struct_types.hpp"

mrb_value mrb_get_touch_position(mrb_state *mrb, mrb_value) {
  mrb_int index;
  mrb_get_args(mrb, "i", &index);

  Vector2 *position = (Vector2 *)malloc(sizeof(Vector2));
  *position = GetTouchPosition(index);

  mrb_value obj = mrb_obj_value(Data_Wrap_Struct(mrb, Vector2_class, &Vector2_type, position));

  setup_Vector2(mrb, obj, position, position->x, position->y);

  return obj;
}

void append_core_input_touch(mrb_state *mrb) {
  mrb_define_method(mrb, mrb->kernel_module, "get_touch_position", mrb_get_touch_position, MRB_ARGS_REQ(1));
}
