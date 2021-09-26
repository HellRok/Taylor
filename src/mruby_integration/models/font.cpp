#include <cstdlib>
#include "raylib.h"
#include "mruby.h"
#include "mruby/data.h"
#include "mruby/class.h"
#include "mruby/compile.h"

#include "mruby_integration/helpers.hpp"
#include "mruby_integration/struct_types.hpp"

struct RClass *Font_class;

void setup_Font(mrb_state *mrb, mrb_value object, Font *font, int base_size, int chars_count, int chars_padding) { //, Texture2D *texture2d, Rectangle **rectangles) {
  ivar_attr_int(mrb, object, font->baseSize, base_size);
  ivar_attr_int(mrb, object, font->charsCount, chars_count);
  ivar_attr_int(mrb, object, font->charsPadding, chars_padding);
  //  Texture2D texture;      // Characters texture atlas
  //  Rectangle *recs;        // Characters rectangles in texture
  //  CharInfo *chars;        // Characters info data
}

mrb_value mrb_Font_initialize(mrb_state *mrb, mrb_value self) {
  mrb_int base_size, chars_count, chars_padding;
  mrb_get_args(mrb, "iii", &base_size, &chars_count, &chars_padding);

  Font *font = (Font *)DATA_PTR(self);
  if (font) { mrb_free(mrb, font); }
  mrb_data_init(self, nullptr, &Font_type);
  font = (Font *)malloc(sizeof(Font));

  setup_Font(mrb, self, font, base_size, chars_count, chars_padding);

  mrb_data_init(self, font, &Font_type);
  return self;
}

mrb_value mrb_Font_set_base_size(mrb_state *mrb, mrb_value self) {
  attr_setter_int(mrb, self, Font_type, Font, baseSize, base_size);
}

mrb_value mrb_Font_set_chars_count(mrb_state *mrb, mrb_value self) {
  attr_setter_int(mrb, self, Font_type, Font, charsCount, chars_count);
}

mrb_value mrb_Font_set_chars_padding(mrb_state *mrb, mrb_value self) {
  attr_setter_int(mrb, self, Font_type, Font, charsPadding, chars_padding);
}

void append_models_Font(mrb_state *mrb) {
  Font_class = mrb_define_class(mrb, "Font", mrb->object_class);
  MRB_SET_INSTANCE_TT(Font_class, MRB_TT_DATA);
  mrb_define_method(mrb, Font_class, "initialize", mrb_Font_initialize, MRB_ARGS_REQ(5));
  mrb_define_method(mrb, Font_class, "base_size=", mrb_Font_set_base_size, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, Font_class, "chars_count=", mrb_Font_set_chars_count, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, Font_class, "chars_padding=", mrb_Font_set_chars_padding, MRB_ARGS_REQ(1));

  mrb_load_string(mrb, R"(
    class Font
      attr_reader :base_size, :chars_count, :chars_padding

      def to_h
        {
          base_size: base_size,
          chars_count: chars_count,
          chars_padding: chars_padding,
        }
      end

      def self.load(path, size: 32, char_count: 100)
        raise Font::NotFound.new("Could not find font at path \"#{path}\"") unless File.exist?(path)
        load_font_ex(path, size, char_count)
      end

      def unload
        unload_font(self)
      end

      def draw(text, position: Vector2::ZERO, size: 32, padding: 0, colour: BLACK)
        draw_text_ex(self, text, position, size, padding, colour)
      end

      def measure(text, size: 32, padding: 0)
        measure_text_ex(self, text, size, padding)
      end

      class NotFound < StandardError; end
    end
  )");
}
