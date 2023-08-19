#include "mruby.h"
#include "raylib.h"

#include "mruby_integration/models/vector2.hpp"
#include "mruby_integration/struct_types.hpp"

mrb_value
mrb_get_world_to_screen2D(mrb_state* mrb, mrb_value)
{
  Vector2* vector;
  Camera2D* camera;
  mrb_get_args(mrb, "dd", &vector, &Vector2_type, &camera, &Camera2D_type);

  Vector2* new_vector = (Vector2*)malloc(sizeof(Vector2));
  *new_vector = GetWorldToScreen2D(*vector, *camera);
  mrb_value obj = mrb_obj_value(
    Data_Wrap_Struct(mrb, Vector2_class, &Vector2_type, new_vector));

  setup_Vector2(mrb, obj, new_vector, new_vector->x, new_vector->y);

  return obj;
}

mrb_value
mrb_get_screen_to_world2D(mrb_state* mrb, mrb_value)
{
  Vector2* vector;
  Camera2D* camera;
  mrb_get_args(mrb, "dd", &vector, &Vector2_type, &camera, &Camera2D_type);

  Vector2* new_vector = (Vector2*)malloc(sizeof(Vector2));
  *new_vector = GetScreenToWorld2D(*vector, *camera);
  mrb_value obj = mrb_obj_value(
    Data_Wrap_Struct(mrb, Vector2_class, &Vector2_type, new_vector));

  setup_Vector2(mrb, obj, new_vector, new_vector->x, new_vector->y);

  return obj;
}

void
append_core_screen_space(mrb_state* mrb)
{
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "get_world_to_screen2D",
                    mrb_get_world_to_screen2D,
                    MRB_ARGS_REQ(2));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "get_screen_to_world2D",
                    mrb_get_screen_to_world2D,
                    MRB_ARGS_REQ(2));
}
