#include "mruby.h"
#include "mruby/class.h"
#include "mruby/data.h"
#include "raylib.h"

#include "mruby_integration/helpers.hpp"
#include "mruby_integration/struct_types.hpp"

#include "ruby/models/vector2.hpp"

struct RClass* Vector2_class;

auto
mrb_Vector2_value(mrb_state* mrb, Vector2* vector) -> mrb_value
{
  mrb_value obj =
    mrb_obj_value(Data_Wrap_Struct(mrb, Vector2_class, &Vector2_type, vector));

  return obj;
}

auto
mrb_Vector2_initialize(mrb_state* mrb, mrb_value self) -> mrb_value
{
  Vector2* vector;
  mrb_self_ptr(mrb, self, Vector2, vector);

  const mrb_int kw_num = 2;
  const mrb_int kw_required = 2;
  const mrb_sym kw_names[] = {
    mrb_intern_lit(mrb, "x"),
    mrb_intern_lit(mrb, "y"),
  };
  mrb_value kw_values[kw_num];
  mrb_kwargs kwargs = { kw_num, kw_required, kw_names, kw_values, nullptr };
  mrb_get_args(mrb, ":", &kwargs);

  if (!mrb_undef_p(kw_values[0])) {
    vector->x = mrb_as_float(mrb, kw_values[0]);
  }

  if (!mrb_undef_p(kw_values[1])) {
    vector->y = mrb_as_float(mrb, kw_values[1]);
  }

  mrb_data_init(self, vector, &Vector2_type);
  return self;
}

mrb_attr_accessor(mrb, self, float, f, Vector2, x);
mrb_attr_accessor(mrb, self, float, f, Vector2, y);

auto
mrb_Vector2_draw(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Vector2, vector);
  Color* colour;

  mrb_get_args(mrb, "d", &colour, &Color_type);

  DrawPixelV(*vector, *colour);
  return mrb_nil_value();
}

void
append_models_Vector2(mrb_state* mrb)
{
  Vector2_class = mrb_define_class(mrb, "Vector2", mrb->object_class);
  MRB_SET_INSTANCE_TT(Vector2_class, MRB_TT_DATA);
  mrb_define_method(
    mrb, Vector2_class, "initialize", mrb_Vector2_initialize, MRB_ARGS_REQ(4));
  mrb_attr_accessor_defines(mrb, Vector2, x);
  mrb_attr_accessor_defines(mrb, Vector2, y);
  mrb_define_method(
    mrb, Vector2_class, "draw", mrb_Vector2_draw, MRB_ARGS_REQ(1));

  load_ruby_models_vector2(mrb);
}
