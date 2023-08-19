#include "mruby.h"
#include "mruby/class.h"
#include "mruby/data.h"
#include "raylib.h"
#include <cstdlib>

#include "mruby_integration/helpers.hpp"
#include "mruby_integration/struct_types.hpp"

#include "ruby/models/vector2.hpp"

struct RClass* Vector2_class;

void
setup_Vector2(mrb_state* mrb,
              mrb_value object,
              Vector2* vector,
              float x,
              float y)
{
  ivar_attr_float(mrb, object, vector->x, x);
  ivar_attr_float(mrb, object, vector->y, y);
}

auto
mrb_Vector2_initialize(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_float x, y;
  mrb_get_args(mrb, "ff", &x, &y);

  Vector2* vector = static_cast<struct Vector2*> DATA_PTR(self);
  if (vector) {
    mrb_free(mrb, vector);
  }
  mrb_data_init(self, nullptr, &Vector2_type);
  vector = static_cast<Vector2*>(malloc(sizeof(Vector2)));

  setup_Vector2(mrb, self, vector, x, y);

  mrb_data_init(self, vector, &Vector2_type);
  return self;
}

auto
mrb_Vector2_set_x(mrb_state* mrb, mrb_value self) -> mrb_value
{
  attr_setter_float(mrb, self, Vector2_type, Vector2, x, x);
}

auto
mrb_Vector2_set_y(mrb_state* mrb, mrb_value self) -> mrb_value
{
  attr_setter_float(mrb, self, Vector2_type, Vector2, y, y);
}

void
append_models_Vector2(mrb_state* mrb)
{
  Vector2_class = mrb_define_class(mrb, "Vector2", mrb->object_class);
  MRB_SET_INSTANCE_TT(Vector2_class, MRB_TT_DATA);
  mrb_define_method(
    mrb, Vector2_class, "initialize", mrb_Vector2_initialize, MRB_ARGS_REQ(4));
  mrb_define_method(
    mrb, Vector2_class, "x=", mrb_Vector2_set_x, MRB_ARGS_REQ(1));
  mrb_define_method(
    mrb, Vector2_class, "y=", mrb_Vector2_set_y, MRB_ARGS_REQ(1));

  load_ruby_models_vector2(mrb);
}
