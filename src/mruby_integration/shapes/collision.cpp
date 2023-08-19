#include "mruby.h"
#include "raylib.h"

#include "mruby_integration/struct_types.hpp"

mrb_value
mrb_check_collision_point_rec(mrb_state* mrb, mrb_value)
{
  Vector2* point;
  Rectangle* rectangle;

  mrb_get_args(mrb, "dd", &point, &Vector2_type, &rectangle, &Rectangle_type);

  return mrb_bool_value(CheckCollisionPointRec(*point, *rectangle));
}

void
append_shapes_collision(mrb_state* mrb)
{
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "check_collision_point_rec",
                    mrb_check_collision_point_rec,
                    MRB_ARGS_REQ(2));
}
