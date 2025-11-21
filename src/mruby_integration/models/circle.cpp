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

void
Circle_init(Circle* circle)
{
  circle->x = 0;
  circle->y = 0;
  circle->radius = 0;
  circle->thickness = 0;
}

auto
mrb_Circle_initialize(mrb_state* mrb, mrb_value self) -> mrb_value
{
  Circle* circle;
  mrb_self_ptr(mrb, self, Circle, circle);
  Circle_init(circle);

  // Circle.new(
  //   x:,
  //   y:,
  //   radius:,
  //   colour: Colour::BLACK,
  //   outline: nil,
  //   thickness: 1,
  //   gradient: nil
  // )
  mrb_int kw_num = 7;
  mrb_int kw_required = 3;
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
    circle->x = mrb_as_int(mrb, kw_values[0]);
  }

  circle->y = 0.0;
  if (!mrb_undef_p(kw_values[1])) {
    circle->y = mrb_as_int(mrb, kw_values[1]);
  }

  circle->radius = 0.0;
  if (!mrb_undef_p(kw_values[2])) {
    circle->radius = mrb_as_float(mrb, kw_values[2]);
  }

  if (circle->radius <= 0) {
    mrb_raise(mrb, E_ARGUMENT_ERROR, "Radius must be greater than 0");
  }

  if (!mrb_undef_p(kw_values[3])) {
    circle->colour = static_cast<struct Color*> DATA_PTR(kw_values[3]);
  } else {
    circle->colour = static_cast<Color*>(malloc(sizeof(Color)));
    circle->colour->r = 0;
    circle->colour->g = 0;
    circle->colour->b = 0;
    circle->colour->a = 255;
  }
  add_reference(circle->colour);
  mrb_iv_set(mrb,
             self,
             mrb_intern_cstr(mrb, "@colour"),
             mrb_Color_value(mrb, circle->colour));

  if (!mrb_undef_p(kw_values[4])) {
    circle->outline = static_cast<struct Color*> DATA_PTR(kw_values[4]);
    add_reference(circle->outline);
    mrb_iv_set(mrb,
               self,
               mrb_intern_cstr(mrb, "@outline"),
               mrb_Color_value(mrb, circle->outline));
  } else {
    circle->outline = nullptr;
  }

  circle->thickness = 1.0;
  if (!mrb_undef_p(kw_values[5])) {
    circle->thickness = mrb_as_float(mrb, kw_values[5]);
  }

  if (circle->thickness <= 0) {
    mrb_raise(mrb, E_ARGUMENT_ERROR, "Thickness must be greater than 0");
  }

  if (!mrb_undef_p(kw_values[6])) {
    circle->gradient = static_cast<struct Color*> DATA_PTR(kw_values[6]);
    add_reference(circle->gradient);
    mrb_iv_set(mrb,
               self,
               mrb_intern_cstr(mrb, "@gradient"),
               mrb_Color_value(mrb, circle->gradient));
  } else {
    circle->gradient = nullptr;
  }

  mrb_data_init(self, circle, &Circle_type);
  return self;
}

mrb_attr_accessor(mrb, self, float, f, Circle, x);
mrb_attr_accessor(mrb, self, float, f, Circle, y);

mrb_attr_reader(mrb, self, float, Circle, radius);
auto
mrb_Circle_set_radius(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Circle, circle);
  mrb_float value;
  mrb_get_args(mrb, "f", &value);

  if (value <= 0) {
    mrb_raise(mrb, E_ARGUMENT_ERROR, "Radius must be greater than 0");
  }

  circle->radius = value;

  return mrb_float_value(mrb, circle->radius);
}

mrb_attr_reader(mrb, self, float, Circle, thickness);
auto
mrb_Circle_set_thickness(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Circle, circle);
  mrb_float value;
  mrb_get_args(mrb, "f", &value);

  if (value <= 0) {
    mrb_raise(mrb, E_ARGUMENT_ERROR, "Thickness must be greater than 0");
  }

  circle->thickness = value;

  return mrb_float_value(mrb, circle->thickness);
}

mrb_attr_writer_struct(mrb, self, Circle, Circle, colour, Color);
mrb_attr_writer_struct(mrb, self, Circle, Circle, outline, Color);
mrb_attr_writer_struct(mrb, self, Circle, Circle, gradient, Color);

auto
mrb_Circle_draw(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Circle, circle);

  if (circle->gradient == nullptr) {
    DrawCircle(circle->x, circle->y, circle->radius, *circle->colour);
  } else {
    DrawCircleGradient(
      circle->x, circle->y, circle->radius, *circle->colour, *circle->gradient);
  }

  if (circle->outline != nullptr) {
    // There's no way to draw a circle outline with differing thickness in
    // Raylib, this does it pretty well but I think it might be expensive.
    DrawPolyLinesEx(
      Vector2{ static_cast<float>(circle->x), static_cast<float>(circle->y) },
      60,
      circle->radius,
      0,
      circle->thickness,
      *circle->outline);
  }

  return mrb_nil_value();
}

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
  mrb_define_method(
    mrb, Circle_class, "draw", mrb_Circle_draw, MRB_ARGS_NONE());

  load_ruby_models_circle(mrb);
}
