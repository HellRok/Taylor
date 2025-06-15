#include "mruby.h"
#include "mruby/class.h"
#include "mruby/data.h"
#include "raylib.h"

#include "mruby_integration/helpers.hpp"
#include "mruby_integration/models/colour.hpp"
#include "mruby_integration/models/rectangle.hpp"
#include "mruby_integration/struct_types.hpp"

#include "ruby/models/rectangle.hpp"

struct RClass* Rectangle_class;

void
Rektangle_init(Rektangle* rectangle)
{
  rectangle->rectangle =
    static_cast<struct Rectangle*>(malloc(sizeof(Rectangle)));
  rectangle->rectangle->x = 0;
  rectangle->rectangle->y = 0;
  rectangle->rectangle->width = 0;
  rectangle->rectangle->height = 0;
  rectangle->thickness = 1.0;
  rectangle->roundness = 0;
  rectangle->segments = 6;
}

auto
mrb_Rectangle_initialize(mrb_state* mrb, mrb_value self) -> mrb_value
{
  Rektangle* rectangle;
  mrb_self_ptr(mrb, self, Rektangle, rectangle);
  Rektangle_init(rectangle);

  // Rectangle.new(
  //   x:,
  //   y:,
  //   width:,
  //   height:,
  //   colour:,
  //   outline: nil,
  //   thickness: 1,
  //   roundness: 0,
  //   segments: 6
  // )
  const mrb_int kw_num = 9;
  const mrb_int kw_required = 5;
  const mrb_sym kw_names[] = {
    mrb_intern_lit(mrb, "x"),         mrb_intern_lit(mrb, "y"),
    mrb_intern_lit(mrb, "width"),     mrb_intern_lit(mrb, "height"),
    mrb_intern_lit(mrb, "colour"),    mrb_intern_lit(mrb, "outline"),
    mrb_intern_lit(mrb, "thickness"), mrb_intern_lit(mrb, "roundness"),
    mrb_intern_lit(mrb, "segments")
  };
  mrb_value kw_values[kw_num];
  mrb_kwargs kwargs = { kw_num, kw_required, kw_names, kw_values, nullptr };
  mrb_get_args(mrb, ":", &kwargs);

  if (!mrb_undef_p(kw_values[0])) {
    rectangle->rectangle->x = mrb_as_float(mrb, kw_values[0]);
  }

  if (!mrb_undef_p(kw_values[1])) {
    rectangle->rectangle->y = mrb_as_float(mrb, kw_values[1]);
  }

  if (!mrb_undef_p(kw_values[2])) {
    rectangle->rectangle->width = mrb_as_float(mrb, kw_values[2]);
  }

  if (!mrb_undef_p(kw_values[3])) {
    rectangle->rectangle->height = mrb_as_float(mrb, kw_values[3]);
  }

  if (!mrb_undef_p(kw_values[4])) {
    rectangle->colour = static_cast<struct Color*> DATA_PTR(kw_values[4]);
    add_owned_object(rectangle->colour);
    mrb_iv_set(mrb,
               self,
               mrb_intern_cstr(mrb, "@colour"),
               mrb_Color_value(mrb, rectangle->colour));
  } else {
    rectangle->colour = nullptr;
  }

  if (!mrb_undef_p(kw_values[5])) {
    rectangle->outline = static_cast<struct Color*> DATA_PTR(kw_values[5]);
    add_owned_object(rectangle->outline);
    mrb_iv_set(mrb,
               self,
               mrb_intern_cstr(mrb, "@outline"),
               mrb_Color_value(mrb, rectangle->outline));
  } else {
    rectangle->outline = nullptr;
  }

  if (!mrb_undef_p(kw_values[6])) {
    rectangle->thickness = mrb_as_float(mrb, kw_values[6]);
  }

  if (rectangle->thickness <= 0) {
    mrb_raise(mrb, E_ARGUMENT_ERROR, "Thickness must be greater than 0");
  }

  if (!mrb_undef_p(kw_values[7])) {
    rectangle->roundness = mrb_as_float(mrb, kw_values[7]);
  }

  if (rectangle->roundness < 0 || rectangle->roundness > 1) {
    mrb_raise(mrb, E_ARGUMENT_ERROR, "Roundness must be within (0.0..1.0)");
  }

  if (!mrb_undef_p(kw_values[8])) {
    rectangle->segments = mrb_as_float(mrb, kw_values[8]);
  }

  if (rectangle->segments <= 0) {
    mrb_raise(mrb, E_ARGUMENT_ERROR, "Segments must be greater than 0");
  }

  add_parent(rectangle, "Rektangle");
  add_owned_object(rectangle->rectangle);

  mrb_data_init(self, rectangle, &Rektangle_type);
  return self;
}

mrb_attr_accessor_with_klasses_and_attrs(mrb,
                                         self,
                                         float,
                                         f,
                                         Rectangle,
                                         Rektangle,
                                         x,
                                         rectangle->x);
mrb_attr_accessor_with_klasses_and_attrs(mrb,
                                         self,
                                         float,
                                         f,
                                         Rectangle,
                                         Rektangle,
                                         y,
                                         rectangle->y);
mrb_attr_accessor_with_klasses_and_attrs(mrb,
                                         self,
                                         float,
                                         f,
                                         Rectangle,
                                         Rektangle,
                                         width,
                                         rectangle->width);
mrb_attr_accessor_with_klasses_and_attrs(mrb,
                                         self,
                                         float,
                                         f,
                                         Rectangle,
                                         Rektangle,
                                         height,
                                         rectangle->height);

mrb_attr_reader_with_klasses(mrb, self, float, Rectangle, Rektangle, thickness);
auto
mrb_Rectangle_set_thickness(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Rektangle, rectangle);
  mrb_float value;
  mrb_get_args(mrb, "f", &value);

  if (value <= 0) {
    mrb_raise(mrb, E_ARGUMENT_ERROR, "Thickness must be greater than 0");
  }

  rectangle->thickness = value;

  return mrb_float_value(mrb, rectangle->thickness);
}

mrb_attr_reader_with_klasses(mrb, self, float, Rectangle, Rektangle, roundness);
auto
mrb_Rectangle_set_roundness(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Rektangle, rectangle);
  mrb_float value;
  mrb_get_args(mrb, "f", &value);

  if (value < 0 || value > 1.0) {
    mrb_raise(mrb, E_ARGUMENT_ERROR, "Roundness must be within (0.0..1.0)");
  }

  rectangle->roundness = value;

  return mrb_float_value(mrb, rectangle->roundness);
}

mrb_attr_reader_with_klasses(mrb, self, int, Rectangle, Rektangle, segments);
auto
mrb_Rectangle_set_segments(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Rektangle, rectangle);
  mrb_int value;
  mrb_get_args(mrb, "i", &value);

  if (value <= 0) {
    mrb_raise(mrb, E_ARGUMENT_ERROR, "Segments must be greater than 0");
  }

  rectangle->segments = value;

  return mrb_int_value(mrb, rectangle->segments);
}

mrb_attr_writer_struct(mrb, self, Rectangle, Rektangle, colour, Color);
mrb_attr_writer_struct(mrb, self, Rectangle, Rektangle, outline, Color);

auto
mrb_Rectangle_draw(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Rektangle, rectangle);

  if (rectangle->roundness == 0) {
    DrawRectangleRec(*rectangle->rectangle, *rectangle->colour);
    if (rectangle->outline != nullptr) {
      DrawRectangleLinesEx(
        *rectangle->rectangle, rectangle->thickness, *rectangle->outline);
    }
  } else {
    DrawRectangleRounded(*rectangle->rectangle,
                         rectangle->roundness,
                         rectangle->segments,
                         *rectangle->colour);
    if (rectangle->outline != nullptr) {
      DrawRectangleRoundedLines(*rectangle->rectangle,
                                rectangle->roundness,
                                rectangle->segments,
                                rectangle->thickness,
                                *rectangle->outline);
    }
  }

  return mrb_nil_value();
}

void
append_models_Rectangle(mrb_state* mrb)
{
  Rectangle_class = mrb_define_class(mrb, "Rectangle", mrb->object_class);
  MRB_SET_INSTANCE_TT(Rectangle_class, MRB_TT_DATA);
  mrb_define_method(mrb,
                    Rectangle_class,
                    "initialize",
                    mrb_Rectangle_initialize,
                    MRB_ARGS_REQ(4));
  mrb_attr_accessor_defines(mrb, Rectangle, x);
  mrb_attr_accessor_defines(mrb, Rectangle, y);
  mrb_attr_accessor_defines(mrb, Rectangle, width);
  mrb_attr_accessor_defines(mrb, Rectangle, height);
  mrb_attr_writer_define(mrb, Rectangle, colour);
  mrb_attr_writer_define(mrb, Rectangle, outline);
  mrb_attr_accessor_defines(mrb, Rectangle, thickness);
  mrb_attr_accessor_defines(mrb, Rectangle, roundness);
  mrb_attr_accessor_defines(mrb, Rectangle, segments);
  mrb_define_method(
    mrb, Rectangle_class, "draw", mrb_Rectangle_draw, MRB_ARGS_NONE());

  load_ruby_models_rectangle(mrb);
}
