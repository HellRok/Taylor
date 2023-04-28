#include "raylib.h"
#include "mruby.h"

#include "mruby_integration/struct_types.hpp"
#include "mruby_integration/models/rectangle.hpp"

mrb_value mrb_check_collision_point_rec(mrb_state *mrb, mrb_value) {
  Vector2 *point;
  Rectangle *rectangle;

  mrb_get_args(mrb, "dd", &point, &Vector2_type, &rectangle, &Rectangle_type);

  return mrb_bool_value(CheckCollisionPointRec(*point, *rectangle));
}

RLAPI bool CheckCollisionRecs(Rectangle rec1, Rectangle rec2);

mrb_value mrb_check_collision_recs(mrb_state *mrb, mrb_value) {
  Rectangle *rectangle1;
  Rectangle *rectangle2;

  mrb_get_args(mrb, "dd", &rectangle1, &Rectangle_type, &rectangle2, &Rectangle_type);

  return mrb_bool_value(CheckCollisionRecs(*rectangle1, *rectangle2));
}

mrb_value mrb_get_collision_rec(mrb_state *mrb, mrb_value) {
  Rectangle *rectangle1;
  Rectangle *rectangle2;

  mrb_get_args(mrb, "dd", &rectangle1, &Rectangle_type, &rectangle2, &Rectangle_type);

  Rectangle c = GetCollisionRec(*rectangle1, *rectangle2);

  if (c.x == 0 && c.y == 0 && c.width == 0 && c.height == 0) {
    return mrb_nil_value();
  }

  Rectangle *collision = (Rectangle *)malloc(sizeof(Rectangle));

  mrb_value obj = mrb_obj_value(Data_Wrap_Struct(mrb, Rectangle_class, &Rectangle_type, collision));
  setup_Rectangle(mrb, obj, collision, c.x, c.y, c.width, c.height);

  return obj;
}

void append_shapes_collision(mrb_state *mrb) {
  mrb_define_method(mrb, mrb->kernel_module, "check_collision_point_rec", mrb_check_collision_point_rec, MRB_ARGS_REQ(2));
  mrb_define_method(mrb, mrb->kernel_module, "check_collision_recs", mrb_check_collision_recs, MRB_ARGS_REQ(2));
  mrb_define_method(mrb, mrb->kernel_module, "get_collision_rec", mrb_get_collision_rec, MRB_ARGS_REQ(2));
}
