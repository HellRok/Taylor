#include "mruby.h"
#include "mruby/class.h"
#include "mruby/data.h"
#include "raylib.h"
#include <cstdlib>

#include "mruby_integration/helpers.hpp"
#include "mruby_integration/models/vector2.hpp"
#include "mruby_integration/struct_types.hpp"

#include "ruby/models/camera2d.hpp"

struct RClass* Camera2D_class;

auto
mrb_Camera2D_initialize(mrb_state* mrb, mrb_value self) -> mrb_value
{
  Camera2D* camera;
  mrb_self_ptr(mrb, self, Camera2D, camera);

  // def initialize(
  //   target: Vector2[0, 0],
  //   offset: Vector2[0, 0],
  //   rotation: 0,
  //   zoom: 1
  // )
  const mrb_int kw_num = 4;
  const mrb_int kw_required = 0;
  const mrb_sym kw_names[] = { mrb_intern_lit(mrb, "target"),
                               mrb_intern_lit(mrb, "offset"),
                               mrb_intern_lit(mrb, "rotation"),
                               mrb_intern_lit(mrb, "zoom") };
  mrb_value kw_values[kw_num];
  mrb_kwargs kwargs = { kw_num, kw_required, kw_names, kw_values, nullptr };
  mrb_get_args(mrb, ":", &kwargs);

  if (mrb_undef_p(kw_values[0])) {
    auto default_target = Vector2{ 0, 0 };
    camera->target = default_target;
  } else {
    camera->target = *static_cast<struct Vector2*> DATA_PTR(kw_values[0]);
  }

  if (mrb_undef_p(kw_values[1])) {
    auto default_offset = Vector2{ 0, 0 };
    camera->offset = default_offset;
  } else {
    camera->offset = *static_cast<struct Vector2*> DATA_PTR(kw_values[1]);
  }

  camera->rotation = 0;
  if (!mrb_undef_p(kw_values[2])) {
    camera->rotation = mrb_as_float(mrb, kw_values[2]);
  }

  camera->zoom = 1.0;
  if (!mrb_undef_p(kw_values[3])) {
    camera->zoom = mrb_as_float(mrb, kw_values[3]);
  }

  add_reference(&camera->offset);
  mrb_iv_set(mrb,
             self,
             mrb_intern_cstr(mrb, "@offset"),
             mrb_Vector2_value(mrb, &camera->offset));
  add_reference(&camera->target);
  mrb_iv_set(mrb,
             self,
             mrb_intern_cstr(mrb, "@target"),
             mrb_Vector2_value(mrb, &camera->target));

  mrb_data_init(self, camera, &Camera2D_type);
  return self;
}

mrb_attr_accessor(mrb, self, float, f, Camera2D, rotation);
mrb_attr_accessor(mrb, self, float, f, Camera2D, zoom);

auto
mrb_Camera2D_draw(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Camera2D, camera);

  mrb_value block;
  mrb_get_args(mrb, "&!", &block);

  BeginMode2D(*camera);

  mrb_yield(mrb, block, mrb_nil_value());

  EndMode2D();

  return mrb_nil_value();
}

auto
mrb_Camera2D_as_in_viewport(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Camera2D, camera);

  Vector2* vector;
  mrb_get_args(mrb, "d", &vector, &Vector2_type);

  auto* return_vector = static_cast<Vector2*>(malloc(sizeof(Vector2)));
  *return_vector = GetWorldToScreen2D(*vector, *camera);

  return mrb_Vector2_value(mrb, return_vector);
}

auto
mrb_Camera2D_as_in_world(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Camera2D, camera);

  Vector2* vector;
  mrb_get_args(mrb, "d", &vector, &Vector2_type);

  auto* return_vector = static_cast<Vector2*>(malloc(sizeof(Vector2)));
  *return_vector = GetScreenToWorld2D(*vector, *camera);

  return mrb_Vector2_value(mrb, return_vector);
}

void
append_models_Camera2D(mrb_state* mrb)
{
  Camera2D_class = mrb_define_class(mrb, "Camera2D", mrb->object_class);
  MRB_SET_INSTANCE_TT(Camera2D_class, MRB_TT_DATA);
  mrb_define_method(mrb,
                    Camera2D_class,
                    "initialize",
                    mrb_Camera2D_initialize,
                    MRB_ARGS_REQ(4));
  mrb_attr_accessor_defines(mrb, Camera2D, rotation);
  mrb_attr_accessor_defines(mrb, Camera2D, zoom);
  mrb_define_method(
    mrb, Camera2D_class, "draw", mrb_Camera2D_draw, MRB_ARGS_BLOCK());
  mrb_define_method(mrb,
                    Camera2D_class,
                    "as_in_viewport",
                    mrb_Camera2D_as_in_viewport,
                    MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    Camera2D_class,
                    "as_in_world",
                    mrb_Camera2D_as_in_world,
                    MRB_ARGS_REQ(1));

  load_ruby_models_camera2d(mrb);
}
