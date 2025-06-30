#include "mruby.h"
#include "mruby/class.h"
#include "mruby/data.h"
#include "raylib.h"

#include "mruby_integration/helpers.hpp"
#include "mruby_integration/models/colour.hpp"
#include "mruby_integration/models/vector2.hpp"
#include "mruby_integration/struct_types.hpp"

#include "ruby/models/line.hpp"

struct RClass* Line_class;

struct Line
{
  Vector2* start;
  Vector2* end;
  float thickness;
  Color* colour;
};

void
Line_init(Line* line)
{
  line->thickness = 0;
}

auto
mrb_Line_initialize(mrb_state* mrb, mrb_value self) -> mrb_value
{
  Line* line;
  mrb_self_ptr(mrb, self, Line, line);
  Line_init(line);

  // Line.new(
  //   start:,
  //   end:,
  //   colour:,
  //   thickness: 1,
  // )
  mrb_int kw_num = 4;
  mrb_int kw_required = 3;
  mrb_sym kw_names[] = {
    mrb_intern_lit(mrb, "start"),
    mrb_intern_lit(mrb, "end"),
    mrb_intern_lit(mrb, "colour"),
    mrb_intern_lit(mrb, "thickness"),
  };
  mrb_value kw_values[kw_num];
  mrb_kwargs kwargs = { kw_num, kw_required, kw_names, kw_values, nullptr };
  mrb_get_args(mrb, ":", &kwargs);

  if (!mrb_undef_p(kw_values[0])) {
    line->start = static_cast<struct Vector2*> DATA_PTR(kw_values[0]);
    add_reference(line->start);
    mrb_iv_set(mrb,
               self,
               mrb_intern_cstr(mrb, "@start"),
               mrb_Vector2_value(mrb, line->start));
  } else {
    line->start = nullptr;
  }

  if (!mrb_undef_p(kw_values[1])) {
    line->end = static_cast<struct Vector2*> DATA_PTR(kw_values[1]);
    add_reference(line->end);
    mrb_iv_set(mrb,
               self,
               mrb_intern_cstr(mrb, "@end"),
               mrb_Vector2_value(mrb, line->end));
  } else {
    line->end = nullptr;
  }

  if (!mrb_undef_p(kw_values[2])) {
    line->colour = static_cast<struct Color*> DATA_PTR(kw_values[2]);
    add_reference(line->colour);
    mrb_iv_set(mrb,
               self,
               mrb_intern_cstr(mrb, "@colour"),
               mrb_Color_value(mrb, line->colour));
  } else {
    line->colour = nullptr;
  }

  line->thickness = 1.0;
  if (!mrb_undef_p(kw_values[3])) {
    line->thickness = mrb_as_float(mrb, kw_values[3]);
  }

  if (line->thickness <= 0) {
    mrb_raise(mrb, E_ARGUMENT_ERROR, "Thickness must be greater than 0");
  }

  mrb_data_init(self, line, &Line_type);
  return self;
}

mrb_attr_reader(mrb, self, float, Line, thickness);
auto
mrb_Line_set_thickness(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Line, line);
  mrb_float value;
  mrb_get_args(mrb, "f", &value);

  if (value <= 0) {
    mrb_raise(mrb, E_ARGUMENT_ERROR, "Thickness must be greater than 0");
  }

  line->thickness = value;

  return mrb_float_value(mrb, line->thickness);
}

mrb_attr_writer_struct(mrb, self, Line, Line, start, Vector2);
mrb_attr_writer_struct(mrb, self, Line, Line, end, Vector2);
mrb_attr_writer_struct(mrb, self, Line, Line, colour, Color);

auto
mrb_Line_draw(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Line, line);

  DrawLineEx(*line->start, *line->end, line->thickness, *line->colour);

  return mrb_nil_value();
}
void
append_models_Line(mrb_state* mrb)
{
  Line_class = mrb_define_class(mrb, "Line", mrb->object_class);
  MRB_SET_INSTANCE_TT(Line_class, MRB_TT_DATA);
  mrb_define_method(
    mrb, Line_class, "initialize", mrb_Line_initialize, MRB_ARGS_REQ(4));
  mrb_define_method(
    mrb, Line_class, "start=", mrb_Line_set_start, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, Line_class, "end=", mrb_Line_set_end, MRB_ARGS_REQ(1));
  mrb_define_method(
    mrb, Line_class, "colour=", mrb_Line_set_colour, MRB_ARGS_REQ(1));
  mrb_attr_accessor_defines(mrb, Line, thickness);
  mrb_define_method(mrb, Line_class, "draw", mrb_Line_draw, MRB_ARGS_NONE());

  load_ruby_models_line(mrb);
}
