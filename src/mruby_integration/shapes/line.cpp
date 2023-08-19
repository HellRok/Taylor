#include "mruby.h"
#include "mruby/array.h"
#include "raylib.h"

#include "mruby_integration/struct_types.hpp"

auto
mrb_draw_line(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int start_x, start_y, end_x, end_y;
  Color* colour;

  mrb_get_args(
    mrb, "iiiid", &start_x, &start_y, &end_x, &end_y, &colour, &Colour_type);

  DrawLine(start_x, start_y, end_x, end_y, *colour);
  return mrb_nil_value();
}

auto
mrb_draw_line_v(mrb_state* mrb, mrb_value) -> mrb_value
{
  Vector2 *start, *end;
  Color* colour;

  mrb_get_args(mrb,
               "ddd",
               &start,
               &Vector2_type,
               &end,
               &Vector2_type,
               &colour,
               &Colour_type);

  DrawLineV(*start, *end, *colour);
  return mrb_nil_value();
}

auto
mrb_draw_line_ex(mrb_state* mrb, mrb_value) -> mrb_value
{
  Vector2 *start, *end;
  mrb_float thickness;
  Color* colour;

  mrb_get_args(mrb,
               "ddfd",
               &start,
               &Vector2_type,
               &end,
               &Vector2_type,
               &thickness,
               &colour,
               &Colour_type);

  DrawLineEx(*start, *end, thickness, *colour);
  return mrb_nil_value();
}

auto
mrb_draw_line_bezier(mrb_state* mrb, mrb_value) -> mrb_value
{
  Vector2 *start, *end;
  mrb_float thickness;
  Color* colour;

  mrb_get_args(mrb,
               "ddfd",
               &start,
               &Vector2_type,
               &end,
               &Vector2_type,
               &thickness,
               &colour,
               &Colour_type);

  DrawLineBezier(*start, *end, thickness, *colour);
  return mrb_nil_value();
}

auto
mrb_draw_line_bezier_quad(mrb_state* mrb, mrb_value) -> mrb_value
{
  Vector2 *start, *end, *control;
  mrb_float thickness;
  Color* colour;

  mrb_get_args(mrb,
               "dddfd",
               &start,
               &Vector2_type,
               &end,
               &Vector2_type,
               &control,
               &Vector2_type,
               &thickness,
               &colour,
               &Colour_type);

  DrawLineBezierQuad(*start, *end, *control, thickness, *colour);
  return mrb_nil_value();
}

auto
mrb_draw_line_strip(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_value vectors;
  Color* colour;

  mrb_get_args(mrb, "Ad", &vectors, &colour, &Colour_type);

  mrb_int array_length = RARRAY_LEN(vectors);

  Vector2* raw_vectors[array_length];

  for (mrb_int i = 0; i < array_length; i++) {
    raw_vectors[i] =
      DATA_GET_PTR(mrb, mrb_ary_ref(mrb, vectors, i), &Vector2_type, Vector2);
  }

  DrawLineStrip(*raw_vectors, array_length, *colour);
  return mrb_nil_value();
}

void
append_shapes_line(mrb_state* mrb)
{
  mrb_define_method(
    mrb, mrb->kernel_module, "draw_line", mrb_draw_line, MRB_ARGS_REQ(5));
  mrb_define_method(
    mrb, mrb->kernel_module, "draw_line_v", mrb_draw_line_v, MRB_ARGS_REQ(3));
  mrb_define_method(
    mrb, mrb->kernel_module, "draw_line_ex", mrb_draw_line_ex, MRB_ARGS_REQ(4));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "draw_line_bezier",
                    mrb_draw_line_bezier,
                    MRB_ARGS_REQ(4));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "draw_line_bezier_quad",
                    mrb_draw_line_bezier_quad,
                    MRB_ARGS_REQ(5));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "draw_line_strip",
                    mrb_draw_line_strip,
                    MRB_ARGS_REQ(2));
}
