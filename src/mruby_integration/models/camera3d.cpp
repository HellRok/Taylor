#include <cstdlib>
#include "raylib.h"
#include "mruby.h"
#include "mruby/class.h"
#include "mruby/compile.h"
#include "mruby/data.h"
#include "mruby/variable.h"

#include "mruby_integration/helpers.hpp"
#include "mruby_integration/struct_types.hpp"
#include "mruby_integration/models/vector3.hpp"

struct RClass *Camera3D_class;

mrb_value mrb_Camera3D_initialize(mrb_state *mrb, mrb_value self) {
  Camera3D *camera = (struct Camera3D *)DATA_PTR(self);
  if (camera) { mrb_free(mrb, camera); }
  mrb_data_init(self, nullptr, &Camera3D_type); 
  camera = (Camera3D *)malloc(sizeof(Camera3D));

  mrb_float fovy;
  mrb_int projection;
  Vector3 *position, *target, *up;
  mrb_get_args(mrb, "dddfi", &position, &Vector3_type, &target, &Vector3_type, &up, &Vector3_type, &fovy, &projection);

  ivar_attr_vector3(mrb, self, camera->position, position);
  ivar_attr_vector3(mrb, self, camera->target, target);
  ivar_attr_vector3(mrb, self, camera->up, up);
  ivar_attr_float(mrb, self, camera->fovy, fovy);
  ivar_attr_int(mrb, self, camera->projection, projection);

  add_parent(camera, "Camera3D");
  add_owned_object(&camera->position);
  add_owned_object(&camera->target);
  add_owned_object(&camera->up);

  mrb_data_init(self, camera, &Camera3D_type);
  return self;
}

mrb_value mrb_Camera3D_update(mrb_state *mrb, mrb_value self) {
  Camera3D *camera = (struct Camera3D *)DATA_PTR(self);
  mrb_int cameraMode;

  mrb_get_args(mrb, "i", &cameraMode);
  SetCameraMode(*camera, cameraMode);
  UpdateCamera(camera);

  return self;
}

mrb_value mrb_Camera3D_set_fovy(mrb_state *mrb, mrb_value self) {
  attr_setter_float(mrb, self, Camera3D_type, Camera3D, fovy, fovy);
}

mrb_value mrb_Camera3D_set_projection(mrb_state *mrb, mrb_value self) {
  attr_setter_int(mrb, self, Camera3D_type, Camera3D, projection, projection);
}

void append_models_Camera3D(mrb_state *mrb) {
  Camera3D_class = mrb_define_class(mrb, "Camera3D", mrb->object_class);
  MRB_SET_INSTANCE_TT(Camera3D_class, MRB_TT_DATA);
  mrb_define_method(mrb, Camera3D_class, "initialize", mrb_Camera3D_initialize, MRB_ARGS_REQ(5));
  mrb_define_method(mrb, Camera3D_class, "fovy=", mrb_Camera3D_set_fovy, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, Camera3D_class, "projection=", mrb_Camera3D_set_projection, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, Camera3D_class, "update", mrb_Camera3D_update, MRB_ARGS_REQ(1));

  mrb_load_string(mrb, R"(
    CAMERA_CUSTOM = 0
    CAMERA_FREE = 1
    CAMERA_ORBITAL = 2
    CAMERA_FIRST_PERSON = 3
    CAMERA_THIRD_PERSON = 4

    CAMERA_PERSPECTIVE = 0
    CAMERA_ORTHOGRAPHIC = 1

    class Camera3D
      attr_reader :position, :target, :up, :fovy, :projection

      def position=(other)
        @position.x = other.x
        @position.y = other.y
        @position.z = other.z
        @position
      end

      def target=(other)
        @target.x = other.x
        @target.y = other.y
        @target.z = other.z
      end

      def to_h
        {
          position: @position.to_h,
          target: @target.to_h,
          fovy: @fovy,
          projection: @projection,
        }
      end

      def drawing(&block)
        begin_mode3D(self)
        block.call
      ensure
        end_mode3D
      end

      def as_in_viewport(vector)
        get_world_to_screen3D(vector, self)
      end

      def as_in_world(vector)
        get_screen_to_world3D(vector, self)
      end
    end

    Camera = Camera3D
  )");
}
