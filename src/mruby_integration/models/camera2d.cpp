#include "mruby.h"
#include "mruby/class.h"
#include "mruby/data.h"
#include "mruby/variable.h"
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
  Camera2D* camera = static_cast<struct Camera2D*> DATA_PTR(self);
  if (camera) {
    mrb_free(mrb, camera);
  }
  mrb_data_init(self, nullptr, &Camera2D_type);
  camera = static_cast<Camera2D*>(malloc(sizeof(Camera2D)));

  // def initialize(
  //   target: Vector2[0, 0],
  //   offset: Vector2[0, 0],
  //   rotation: 0,
  //   zoom: 1
  // )
  mrb_int kw_num = 4;
  mrb_int kw_required = 0;
  mrb_sym kw_names[] = { mrb_intern_lit(mrb, "target"),
                         mrb_intern_lit(mrb, "offset"),
                         mrb_intern_lit(mrb, "rotation"),
                         mrb_intern_lit(mrb, "zoom") };
  mrb_value kw_values[kw_num];
  mrb_kwargs kwargs = { kw_num, kw_required, kw_names, kw_values, nullptr };
  mrb_get_args(mrb, ":", &kwargs);

  Vector2* target;
  if (mrb_undef_p(kw_values[0])) {
    auto default_target = Vector2{ 0, 0 };
    target = &default_target;
  } else {
    target = static_cast<struct Vector2*> DATA_PTR(kw_values[0]);
  }

  Vector2* offset;
  if (mrb_undef_p(kw_values[1])) {
    auto default_offset = Vector2{ 0, 0 };
    offset = &default_offset;
  } else {
    offset = static_cast<struct Vector2*> DATA_PTR(kw_values[1]);
  }

  float rotation = 0;
  if (!mrb_undef_p(kw_values[2])) {
    rotation = mrb_as_float(mrb, kw_values[2]);
  }

  float zoom = 1.0;
  if (!mrb_undef_p(kw_values[3])) {
    zoom = mrb_as_float(mrb, kw_values[3]);
  }

  ivar_attr_vector2(mrb, self, camera->target, target);
  ivar_attr_vector2(mrb, self, camera->offset, offset);
  ivar_attr_float(mrb, self, camera->rotation, rotation);
  ivar_attr_float(mrb, self, camera->zoom, zoom);

  add_parent(camera, "Camera2D");
  add_owned_object(&camera->offset);
  add_owned_object(&camera->target);

  mrb_data_init(self, camera, &Camera2D_type);
  return self;
}

auto
mrb_Camera2D_set_rotation(mrb_state* mrb, mrb_value self) -> mrb_value
{
  attr_setter_float(mrb, self, Camera2D_type, Camera2D, rotation, rotation);
}

auto
mrb_Camera2D_set_zoom(mrb_state* mrb, mrb_value self) -> mrb_value
{
  attr_setter_float(mrb, self, Camera2D_type, Camera2D, zoom, zoom);
}

auto
mrb_Camera2D_draw(mrb_state* mrb, mrb_value self) -> mrb_value
{
  Camera2D* camera;
  Data_Get_Struct(mrb, self, &Camera2D_type, camera);
  mrb_assert(camera != nullptr);

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
  Camera2D* camera;
  Data_Get_Struct(mrb, self, &Camera2D_type, camera);
  mrb_assert(camera != nullptr);

  Vector2* vector;
  mrb_get_args(mrb, "d", &vector, &Vector2_type);

  auto* return_vector = static_cast<Vector2*>(malloc(sizeof(Vector2)));
  *return_vector = GetWorldToScreen2D(*vector, *camera);

  return mrb_Vector2_value(mrb, return_vector);
}

auto
mrb_Camera2D_as_in_world(mrb_state* mrb, mrb_value self) -> mrb_value
{
  Camera2D* camera;
  Data_Get_Struct(mrb, self, &Camera2D_type, camera);
  mrb_assert(camera != nullptr);

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
  mrb_define_method(mrb,
                    Camera2D_class,
                    "rotation=",
                    mrb_Camera2D_set_rotation,
                    MRB_ARGS_REQ(1));
  mrb_define_method(
    mrb, Camera2D_class, "zoom=", mrb_Camera2D_set_zoom, MRB_ARGS_REQ(1));
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
