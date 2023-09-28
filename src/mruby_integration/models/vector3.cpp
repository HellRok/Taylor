#include <cstdlib>
#include "raylib.h"
#include "mruby.h"
#include "mruby/data.h"
#include "mruby/class.h"
#include "mruby/compile.h"

#include "mruby_integration/helpers.hpp"
#include "mruby_integration/struct_types.hpp"

struct RClass *Vector3_class;

void setup_Vector3(mrb_state *mrb, mrb_value object, Vector3 *vector, float x, float y, float z) {
  ivar_attr_float(mrb, object, vector->x, x);
  ivar_attr_float(mrb, object, vector->y, y);
  ivar_attr_float(mrb, object, vector->z, z);
}

mrb_value mrb_Vector3_initialize(mrb_state *mrb, mrb_value self) {
  mrb_float x, y, z;
  mrb_get_args(mrb, "fff", &x, &y, &z);

  Vector3 *vector = (struct Vector3 *)DATA_PTR(self);
  if (vector) { mrb_free(mrb, vector); }
  mrb_data_init(self, nullptr, &Vector3_type);
  vector = (Vector3 *)malloc(sizeof(Vector3));

  setup_Vector3(mrb, self, vector, x, y, z);

  mrb_data_init(self, vector, &Vector3_type);
  return self;
}

mrb_value mrb_Vector3_set_x(mrb_state *mrb, mrb_value self) {
  attr_setter_float(mrb, self, Vector3_type, Vector3, x, x);
}

mrb_value mrb_Vector3_set_y(mrb_state *mrb, mrb_value self) {
  attr_setter_float(mrb, self, Vector3_type, Vector3, y, y);
}

mrb_value mrb_Vector3_set_z(mrb_state *mrb, mrb_value self) {
  attr_setter_float(mrb, self, Vector3_type, Vector3, z, z);
}

void append_models_Vector3(mrb_state *mrb) {
  Vector3_class = mrb_define_class(mrb, "Vector3", mrb->object_class);
  MRB_SET_INSTANCE_TT(Vector3_class, MRB_TT_DATA);
  mrb_define_method(mrb, Vector3_class, "initialize", mrb_Vector3_initialize, MRB_ARGS_REQ(5));
  mrb_define_method(mrb, Vector3_class, "x=", mrb_Vector3_set_x, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, Vector3_class, "y=", mrb_Vector3_set_y, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, Vector3_class, "z=", mrb_Vector3_set_z, MRB_ARGS_REQ(1));

  mrb_load_string(mrb, R"(
    class Vector3
      attr_reader :x, :y, :z

      class << self
        alias :[] :new
      end

      def ==(other)
        self.x == other.x &&
          self.y == other.y &&
            self.z == other.z
      end

      def +(other)
        Vector3.new(
          self.x + other.x,
          self.y + other.y,
          self.z + other.z,
        )
      end

      def -(other)
        Vector3.new(
          self.x - other.x,
          self.y - other.y,
          self.z - other.z,
        )
      end

      alias :difference :-

      def scale(scalar)
        Vector3.new(
          self.x * scalar,
          self.y * scalar,
          self.z * scalar,
        )
      end

      def length
        Math.sqrt(x**2 + y**2 + z**2)
      end

      def to_h
        {
          x: x,
          y: y,
          z: z,
        }
      end

      ZERO = Vector3.new(0, 0, 0)
    end
  )");
}
