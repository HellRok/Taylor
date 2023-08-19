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
           int base_size,
           int glyph_count,
           int glyph_padding,
           Texture2D* texture)
{ //, Rectangle **rectangles) {
  ivar_attr_int(mrb, object, font->baseSize, base_size);
  ivar_attr_int(mrb, object, font->glyphCount, glyph_count);
  ivar_attr_int(mrb, object, font->glyphPadding, glyph_padding);
  ivar_attr_texture2d(mrb, object, font->texture, texture);
  //  Rectangle *recs;        // Characters rectangles in texture
  //  CharInfo *chars;        // Characters info data
}

auto
mrb_Font_initialize(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_int base_size, glyph_count, glyph_padding;
  mrb_get_args(mrb, "iii", &base_size, &glyph_count, &glyph_padding);

  Font* font = static_cast<Font*> DATA_PTR(self);
  if (font) {
    mrb_free(mrb, font);
  }
  mrb_data_init(self, nullptr, &Font_type);
  font = static_cast<Font*>(malloc(sizeof(Font)));

  Texture2D* texture = &font->texture;

  setup_Font(mrb, self, font, base_size, glyph_count, glyph_padding, texture);

  add_parent(font, "Font");
  add_owned_object(&font->texture);

  mrb_data_init(self, font, &Font_type);
  return self;
}

auto
mrb_Font_set_base_size(mrb_state* mrb, mrb_value self) -> mrb_value
{
  attr_setter_int(mrb, self, Font_type, Font, baseSize, base_size);
}

auto
mrb_Font_set_glyph_count(mrb_state* mrb, mrb_value self) -> mrb_value
{
  attr_setter_int(mrb, self, Font_type, Font, glyphCount, glyph_count);
}

auto
mrb_Font_set_glyph_padding(mrb_state* mrb, mrb_value self) -> mrb_value
{
  attr_setter_int(mrb, self, Font_type, Font, glyphPadding, glyph_padding);
}

void
append_models_Font(mrb_state* mrb)
{
  Font_class = mrb_define_class(mrb, "Font", mrb->object_class);
  MRB_SET_INSTANCE_TT(Font_class, MRB_TT_DATA);
  mrb_define_method(
    mrb, Font_class, "initialize", mrb_Font_initialize, MRB_ARGS_REQ(5));
  mrb_define_method(
    mrb, Font_class, "base_size=", mrb_Font_set_base_size, MRB_ARGS_REQ(1));
  mrb_define_method(
    mrb, Font_class, "glyph_count=", mrb_Font_set_glyph_count, MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    Font_class,
                    "glyph_padding=",
                    mrb_Font_set_glyph_padding,
                    MRB_ARGS_REQ(1));

  load_ruby_models_font(mrb);
}
