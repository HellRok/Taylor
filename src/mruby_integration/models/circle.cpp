#include "mruby.h"
#include "mruby/class.h"
#include "mruby/data.h"
#include "raylib.h"

#include "mruby_integration/helpers.hpp"
#include "mruby_integration/models/colour.hpp"
#include "mruby_integration/struct_types.hpp"

#include "ruby/models/circle.hpp"

struct RClass* Circle_class;

struct Circle
{
  float x;
  float y;
  float radius;
  Color* colour;
  Color* outline;
  float thickness;
  Color* gradient;
};

auto
mrb_Circle_initialize(mrb_state* mrb, mrb_value self) -> mrb_value
{
  Circle* circle;
  mrb_self_ptr(mrb, self, Circle, circle);

  // Circle.new(
  //   x:,
  //   y:,
  //   radius:,
  //   colour:,
  //   outline: nil,
  //   thickness: 1,
  //   gradient: nil
  // )
  mrb_int kw_num = 7;
  mrb_int kw_required = 4;
  mrb_sym kw_names[] = {
    mrb_intern_lit(mrb, "x"),       mrb_intern_lit(mrb, "y"),
    mrb_intern_lit(mrb, "radius"),  mrb_intern_lit(mrb, "colour"),
    mrb_intern_lit(mrb, "outline"), mrb_intern_lit(mrb, "thickness"),
    mrb_intern_lit(mrb, "gradient")
  };
  mrb_value kw_values[kw_num];
  mrb_kwargs kwargs = { kw_num, kw_required, kw_names, kw_values, nullptr };
  mrb_get_args(mrb, ":", &kwargs);

  circle->x = 0;
  if (!mrb_undef_p(kw_values[0])) {
    circle->x = mrb_as_float(mrb, kw_values[0]);
  }

  circle->y = 0.0;
  if (!mrb_undef_p(kw_values[1])) {
    circle->y = mrb_as_float(mrb, kw_values[1]);
  }

  circle->radius = 0.0;
  if (!mrb_undef_p(kw_values[2])) {
    circle->radius = mrb_as_float(mrb, kw_values[2]);
  }

  if (!mrb_undef_p(kw_values[3])) {
    circle->colour = static_cast<struct Color*> DATA_PTR(kw_values[3]);
    add_owned_object(circle->colour);
    mrb_iv_set(mrb,
               self,
               mrb_intern_cstr(mrb, "@colour"),
               mrb_Color_value(mrb, circle->colour));
  }

  if (!mrb_undef_p(kw_values[4])) {
    circle->outline = static_cast<struct Color*> DATA_PTR(kw_values[4]);
    add_owned_object(circle->outline);
    mrb_iv_set(mrb,
               self,
               mrb_intern_cstr(mrb, "@outline"),
               mrb_Color_value(mrb, circle->outline));
  }

  circle->thickness = 1.0;
  if (!mrb_undef_p(kw_values[5])) {
    circle->thickness = mrb_as_float(mrb, kw_values[5]);
  }

  if (!mrb_undef_p(kw_values[6])) {
    circle->gradient = static_cast<struct Color*> DATA_PTR(kw_values[6]);
    add_owned_object(circle->gradient);
    mrb_iv_set(mrb,
               self,
               mrb_intern_cstr(mrb, "@gradient"),
               mrb_Color_value(mrb, circle->gradient));
  }

  add_parent(circle, "Circle");

  mrb_data_init(self, circle, &Circle_type);
  return self;
}

mrb_attr_accessor(mrb, self, float, f, Circle, x);
mrb_attr_accessor(mrb, self, float, f, Circle, y);
mrb_attr_accessor(mrb, self, float, f, Circle, radius);
mrb_attr_accessor(mrb, self, float, f, Circle, thickness);

mrb_attr_writer_struct(mrb, self, Circle, colour, Color);
mrb_attr_writer_struct(mrb, self, Circle, outline, Color);
mrb_attr_writer_struct(mrb, self, Circle, gradient, Color);

void
append_models_Circle(mrb_state* mrb)
{
  Circle_class = mrb_define_class(mrb, "Circle", mrb->object_class);
  MRB_SET_INSTANCE_TT(Circle_class, MRB_TT_DATA);
  mrb_define_method(
    mrb, Circle_class, "initialize", mrb_Circle_initialize, MRB_ARGS_REQ(4));
  mrb_attr_accessor_defines(mrb, Circle, x);
  mrb_attr_accessor_defines(mrb, Circle, y);
  mrb_attr_accessor_defines(mrb, Circle, radius);
  mrb_attr_accessor_defines(mrb, Circle, thickness);
  mrb_define_method(
    mrb, Circle_class, "colour=", mrb_Circle_set_colour, MRB_ARGS_REQ(1));
  mrb_define_method(
    mrb, Circle_class, "outline=", mrb_Circle_set_outline, MRB_ARGS_REQ(1));
  mrb_define_method(
    mrb, Circle_class, "gradient=", mrb_Circle_set_gradient, MRB_ARGS_REQ(1));

  load_ruby_models_circle(mrb);
}
