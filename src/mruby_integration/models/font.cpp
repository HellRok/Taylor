#include "mruby.h"
#include "mruby/class.h"
#include "mruby/data.h"
#include "mruby/string.h"
#include "raylib.h"
#include <cstdlib>

#include "mruby_integration/helpers.hpp"
#include "mruby_integration/models/colour.hpp"
#include "mruby_integration/models/image.hpp"
#include "mruby_integration/models/texture2d.hpp"
#include "mruby_integration/models/vector2.hpp"
#include "mruby_integration/struct_types.hpp"

#include "ruby/models/font.hpp"

struct RClass* Font_class;

void
setup_Font(mrb_state* mrb,
           mrb_value object,
           Font* font,
           int size,
           int glyph_count,
           int glyph_padding,
           Texture2D* texture)
{ //, Rectangle **rectangles) {
  ivar_attr_int(mrb, object, font->baseSize, size);
  ivar_attr_int(mrb, object, font->glyphCount, glyph_count);
  ivar_attr_int(mrb, object, font->glyphPadding, glyph_padding);
  ivar_attr_texture2d(mrb, object, font->texture, texture);
  //  Rectangle *recs;        // Characters rectangles in texture
  //  CharInfo *chars;        // Characters info data
}

auto
mrb_Font_initialize(mrb_state* mrb, mrb_value self) -> mrb_value
{
  char* path;

  // def initialize(path, size: 32, glyph_count: 95)
  mrb_int kw_num = 2;
  mrb_int kw_required = 0;
  mrb_sym kw_names[] = { mrb_intern_lit(mrb, "size"),
                         mrb_intern_lit(mrb, "glyph_count") };
  mrb_value kw_values[kw_num];
  mrb_kwargs kwargs = { kw_num, kw_required, kw_names, kw_values, nullptr };
  mrb_get_args(mrb, "z:", &path, &kwargs);

  if (mrb_undef_p(kw_values[0])) {
    kw_values[0] = mrb_fixnum_value(32);
  }
  if (mrb_undef_p(kw_values[1])) {
    kw_values[1] = mrb_fixnum_value(95);
  }

  int* font_chars{ nullptr };

  Font* font = static_cast<Font*> DATA_PTR(self);
  if (font) {
    mrb_free(mrb, font);
  }
  mrb_data_init(self, nullptr, &Font_type);
  font = static_cast<Font*>(malloc(sizeof(Font)));

  *font = LoadFontEx(
    path, mrb_fixnum(kw_values[0]), font_chars, mrb_fixnum(kw_values[1]));

  setup_Font(mrb,
             self,
             font,
             font->baseSize,
             font->glyphCount,
             font->glyphPadding,
             &font->texture);

  add_parent(font, "Font");
  add_owned_object(&font->texture);

  mrb_data_init(self, font, &Font_type);
  return self;
}

auto
mrb_Font_default(mrb_state* mrb, mrb_value) -> mrb_value
{
  Font* font = static_cast<Font*>(malloc(sizeof(Font)));
  *font = GetFontDefault();

  mrb_value obj =
    mrb_obj_value(Data_Wrap_Struct(mrb, Font_class, &Font_type, font));

  setup_Font(mrb,
             obj,
             font,
             font->baseSize,
             font->glyphCount,
             font->glyphPadding,
             &font->texture);

  add_parent(font, "Font");
  add_owned_object(&font->texture);

  return obj;
}

auto
mrb_Font_unload(mrb_state* mrb, mrb_value self) -> mrb_value
{
  Font* font;

  Data_Get_Struct(mrb, self, &Font_type, font);
  mrb_assert(font != nullptr);

  UnloadFont(*font);

  return mrb_nil_value();
}

auto
mrb_Font_ready(mrb_state* mrb, mrb_value self) -> mrb_value
{
  Font* font;

  Data_Get_Struct(mrb, self, &Font_type, font);
  mrb_assert(font != nullptr);

  return mrb_bool_value(IsFontReady(*font));
}

auto
mrb_Font_draw(mrb_state* mrb, mrb_value self) -> mrb_value
{
  char* text;

  // def draw(text, size: self.size, spacing: 0, x: 0, y: 0, position:
  // Vector2[x, y], colour: Colour::BLACK)
  mrb_int kw_num = 6;
  mrb_int kw_required = 0;
  mrb_sym kw_names[] = {
    mrb_intern_lit(mrb, "size"),     mrb_intern_lit(mrb, "spacing"),
    mrb_intern_lit(mrb, "x"),        mrb_intern_lit(mrb, "y"),
    mrb_intern_lit(mrb, "position"), mrb_intern_lit(mrb, "colour")
  };
  mrb_value kw_values[kw_num];
  mrb_kwargs kwargs = { kw_num, kw_required, kw_names, kw_values, nullptr };
  mrb_get_args(mrb, "z:", &text, &kwargs);

  Font* font;
  Data_Get_Struct(mrb, self, &Font_type, font);
  mrb_assert(font != nullptr);

  float size = font->baseSize;
  if (!mrb_undef_p(kw_values[0])) {
    size = mrb_as_float(mrb, kw_values[0]);
  }

  float spacing = 0;
  if (!mrb_undef_p(kw_values[1])) {
    spacing = mrb_as_float(mrb, kw_values[1]);
  }

  float x = 0;
  if (!mrb_undef_p(kw_values[2])) {
    x = mrb_as_float(mrb, kw_values[2]);
  }

  float y = 0;
  if (!mrb_undef_p(kw_values[3])) {
    y = mrb_as_float(mrb, kw_values[3]);
  }

  Vector2* position;
  if (mrb_undef_p(kw_values[4])) {
    auto default_position = Vector2{ x, y };
    position = &default_position;
  } else {
    position = static_cast<struct Vector2*> DATA_PTR(kw_values[4]);
  }

  Color* colour;
  if (mrb_undef_p(kw_values[5])) {
    auto default_colour = Color{ 0, 0, 0, 255 };
    colour = &default_colour;
  } else {
    colour = static_cast<struct Color*> DATA_PTR(kw_values[5]);
  }

  DrawTextEx(*font, text, *position, size, spacing, *colour);

  return mrb_nil_value();
}

auto
mrb_Font_measure(mrb_state* mrb, mrb_value self) -> mrb_value
{
  char* text;

  // def measure(text, size: self.size, spacing: 0)
  mrb_int kw_num = 2;
  mrb_int kw_required = 0;
  mrb_sym kw_names[] = {
    mrb_intern_lit(mrb, "size"),
    mrb_intern_lit(mrb, "spacing"),
  };
  mrb_value kw_values[kw_num];
  mrb_kwargs kwargs = { kw_num, kw_required, kw_names, kw_values, nullptr };
  mrb_get_args(mrb, "z:", &text, &kwargs);

  Font* font;
  Data_Get_Struct(mrb, self, &Font_type, font);
  mrb_assert(font != nullptr);

  float size = font->baseSize;
  if (!mrb_undef_p(kw_values[0])) {
    size = mrb_as_float(mrb, kw_values[0]);
  }

  float spacing = 0;
  if (!mrb_undef_p(kw_values[1])) {
    spacing = mrb_as_float(mrb, kw_values[1]);
  }

  auto* text_size = static_cast<Vector2*>(malloc(sizeof(Vector2)));
  *text_size = MeasureTextEx(*font, text, size, spacing);

  mrb_value obj = mrb_obj_value(
    Data_Wrap_Struct(mrb, Vector2_class, &Vector2_type, text_size));

  setup_Vector2(mrb, obj, text_size, text_size->x, text_size->y);

  return obj;
}

auto
mrb_Font_to_image(mrb_state* mrb, mrb_value self) -> mrb_value
{
  char* text;

  // def to_image(text, size: self.size, spacing: 0, colour: Colour::BLACK)
  mrb_int kw_num = 3;
  mrb_int kw_required = 0;
  mrb_sym kw_names[] = {
    mrb_intern_lit(mrb, "size"),
    mrb_intern_lit(mrb, "spacing"),
    mrb_intern_lit(mrb, "colour"),
  };
  mrb_value kw_values[kw_num];
  mrb_kwargs kwargs = { kw_num, kw_required, kw_names, kw_values, nullptr };
  mrb_get_args(mrb, "z:", &text, &kwargs);

  Font* font;
  Data_Get_Struct(mrb, self, &Font_type, font);
  mrb_assert(font != nullptr);

  float size = font->baseSize;
  if (!mrb_undef_p(kw_values[0])) {
    size = mrb_as_float(mrb, kw_values[0]);
  }

  float spacing = 0;
  if (!mrb_undef_p(kw_values[1])) {
    spacing = mrb_as_float(mrb, kw_values[1]);
  }

  Color* colour;
  if (mrb_undef_p(kw_values[2])) {
    auto default_colour = Color{ 0, 0, 0, 255 };
    colour = &default_colour;
  } else {
    colour = static_cast<struct Color*> DATA_PTR(kw_values[2]);
  }

  auto* result = static_cast<Image*>(malloc(sizeof(Image)));
  *result = ImageTextEx(*font, text, size, spacing, *colour);

  mrb_value obj =
    mrb_obj_value(Data_Wrap_Struct(mrb, Image_class, &Image_type, result));

  setup_Image(mrb,
              obj,
              result,
              result->width,
              result->height,
              result->mipmaps,
              result->format);

  return obj;
}

void
append_models_Font(mrb_state* mrb)
{
  Font_class = mrb_define_class(mrb, "Font", mrb->object_class);
  MRB_SET_INSTANCE_TT(Font_class, MRB_TT_DATA);
  mrb_define_class_method(
    mrb, Font_class, "default", mrb_Font_default, MRB_ARGS_NONE());
  mrb_define_method(
    mrb, Font_class, "initialize", mrb_Font_initialize, MRB_ARGS_REQ(1));
  mrb_define_method(
    mrb, Font_class, "unload", mrb_Font_unload, MRB_ARGS_NONE());
  mrb_define_method(mrb, Font_class, "ready?", mrb_Font_ready, MRB_ARGS_NONE());
  mrb_define_method(mrb, Font_class, "draw", mrb_Font_draw, MRB_ARGS_REQ(1));
  mrb_define_method(
    mrb, Font_class, "measure", mrb_Font_measure, MRB_ARGS_REQ(1));
  mrb_define_method(
    mrb, Font_class, "to_image", mrb_Font_to_image, MRB_ARGS_REQ(1));

  load_ruby_models_font(mrb);
}
