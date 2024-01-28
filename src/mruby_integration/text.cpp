#include "mruby.h"
#include "mruby/string.h"
#include "raylib.h"

#include "mruby_integration/models/font.hpp"
#include "mruby_integration/models/vector2.hpp"
#include "mruby_integration/struct_types.hpp"

auto
mrb_unload_font(mrb_state* mrb, mrb_value) -> mrb_value
{
  Font* font;
  mrb_get_args(mrb, "d", &font, &Font_type);

  UnloadFont(*font);

  return mrb_nil_value();
}

auto
mrb_draw_fps(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int x, y;

  mrb_get_args(mrb, "ii", &x, &y);

  DrawFPS(x, y);
  return mrb_nil_value();
}

auto
mrb_draw_text(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_value text;
  mrb_int x, y, font_size;
  Color* colour;
  mrb_get_args(mrb, "Siiid", &text, &x, &y, &font_size, &colour, &Colour_type);

  DrawText(mrb_str_to_cstr(mrb, text), x, y, font_size, *colour);
  return mrb_nil_value();
}

auto
mrb_draw_text_ex(mrb_state* mrb, mrb_value) -> mrb_value
{
  Font* font;
  mrb_value text;
  Vector2* position;
  mrb_float font_size, spacing;
  Color* colour;
  mrb_get_args(mrb,
               "dSdffd",
               &font,
               &Font_type,
               &text,
               &position,
               &Vector2_type,
               &font_size,
               &spacing,
               &colour,
               &Colour_type);

  DrawTextEx(
    *font, mrb_str_to_cstr(mrb, text), *position, font_size, spacing, *colour);
  return mrb_nil_value();
}

auto
mrb_measure_text_ex(mrb_state* mrb, mrb_value) -> mrb_value
{
  Font* font;
  mrb_value text;
  mrb_float font_size, spacing;
  mrb_get_args(mrb, "dSff", &font, &Font_type, &text, &font_size, &spacing);

  auto* size = static_cast<Vector2*>(malloc(sizeof(Vector2)));
  *size = MeasureTextEx(*font, mrb_str_to_cstr(mrb, text), font_size, spacing);

  mrb_value obj =
    mrb_obj_value(Data_Wrap_Struct(mrb, Vector2_class, &Vector2_type, size));

  setup_Vector2(mrb, obj, size, size->x, size->y);

  return obj;
}

void
append_text(mrb_state* mrb)
{
  mrb_define_method(
    mrb, mrb->kernel_module, "unload_font", mrb_unload_font, MRB_ARGS_REQ(1));
  mrb_define_method(
    mrb, mrb->kernel_module, "draw_fps", mrb_draw_fps, MRB_ARGS_REQ(2));
  mrb_define_method(
    mrb, mrb->kernel_module, "draw_text", mrb_draw_text, MRB_ARGS_REQ(5));
  mrb_define_method(
    mrb, mrb->kernel_module, "draw_text_ex", mrb_draw_text_ex, MRB_ARGS_REQ(6));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "measure_text_ex",
                    mrb_measure_text_ex,
                    MRB_ARGS_REQ(4));
}
