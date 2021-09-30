#include <cstdlib>
#include "raylib.h"
#include "mruby.h"
#include "mruby/class.h"
#include "mruby/compile.h"
#include "mruby/data.h"
#include "mruby/variable.h"

#include "mruby_integration/helpers.hpp"
#include "mruby_integration/struct_types.hpp"
#include "mruby_integration/models/vector2.hpp"

struct RClass *Camera2D_class;

mrb_value mrb_Camera2D_initialize(mrb_state *mrb, mrb_value self) {
  Camera2D *camera = (struct Camera2D *)DATA_PTR(self);
  if (camera) { mrb_free(mrb, camera); }
  mrb_data_init(self, nullptr, &Camera2D_type);
  camera = (Camera2D *)malloc(sizeof(Camera2D));

  mrb_float rotation, zoom;
  Vector2 *offset, *target;
  mrb_get_args(mrb, "ddff", &offset, &Vector2_type, &target, &Vector2_type, &rotation, &zoom);

  ivar_attr_vector2(mrb, self, camera->offset, offset);
  ivar_attr_vector2(mrb, self, camera->target, target);
  ivar_attr_float(mrb, self, camera->rotation, rotation);
  ivar_attr_float(mrb, self, camera->zoom, zoom);

  add_parent(camera, "Camera2D");
  add_owned_object(&camera->offset);
  add_owned_object(&camera->target);

  mrb_data_init(self, camera, &Camera2D_type);
  return self;
}

mrb_value mrb_Camera2D_set_rotation(mrb_state *mrb, mrb_value self) {
  attr_setter_float(mrb, self, Camera2D_type, Camera2D, rotation, rotation);
}

mrb_value mrb_Camera2D_set_zoom(mrb_state *mrb, mrb_value self) {
  attr_setter_float(mrb, self, Camera2D_type, Camera2D, zoom, zoom);
}

void append_models_Camera2D(mrb_state *mrb) {
  Camera2D_class = mrb_define_class(mrb, "Camera2D", mrb->object_class);
  MRB_SET_INSTANCE_TT(Camera2D_class, MRB_TT_DATA);
  mrb_define_method(mrb, Camera2D_class, "initialize", mrb_Camera2D_initialize, MRB_ARGS_REQ(4));
  mrb_define_method(mrb, Camera2D_class, "rotation=", mrb_Camera2D_set_rotation, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, Camera2D_class, "zoom=", mrb_Camera2D_set_zoom, MRB_ARGS_REQ(1));

  mrb_load_string(mrb, R"(
    class Camera2D
      attr_reader :offset, :target, :rotation, :zoom

      def offset=(other)
        offset.x = other.x
        offset.y = other.y
        offset
      end

      def target=(other)
        target.x = other.x
        target.y = other.y
        target
      end

      def to_h
        {
          offset: offset.to_h,
          target: target.to_h,
          rotation: rotation,
          zoom: zoom,
        }
      end

      def drawing(&block)
        begin_mode2D(self)
        block.call
      ensure
        end_mode2D
      end

      def as_in_viewport(vector)
        get_world_to_screen2D(vector, self)
      end

      def as_in_world(vector)
        get_screen_to_world2D(vector, self)
      end
    end
  )");
}
