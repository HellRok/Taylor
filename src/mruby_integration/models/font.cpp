#include "mruby.h"
#include "mruby/class.h"
#include "mruby/data.h"
#include "raylib.h"
#include <cstdlib>

#include "mruby_integration/helpers.hpp"
#include "mruby_integration/models/texture2d.hpp"
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

void
append_models_Font(mrb_state* mrb)
{
  Font_class = mrb_define_class(mrb, "Font", mrb->object_class);
  MRB_SET_INSTANCE_TT(Font_class, MRB_TT_DATA);
  mrb_define_method(
    mrb, Font_class, "initialize", mrb_Font_initialize, MRB_ARGS_REQ(5));

  load_ruby_models_font(mrb);
}
