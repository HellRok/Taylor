#include "raylib.h"
#include "mruby.h"
#include "mruby/string.h"

#include "mruby_integration/struct_types.hpp"

mrb_value mrb_draw_fps(mrb_state *mrb, mrb_value) {
  mrb_int x, y;

  mrb_get_args(mrb, "ii", &x, &y);

  DrawFPS(x, y);
  return mrb_nil_value();
}

mrb_value mrb_draw_text(mrb_state *mrb, mrb_value) {
  mrb_value text;
  mrb_int x, y, font_size;
  Color *colour;
  mrb_get_args(mrb, "Siiid", &text, &x, &y, &font_size, &colour, &Colour_type);

  DrawText(mrb_str_to_cstr(mrb, text), x, y, font_size, *colour);
  return mrb_nil_value();
}

void append_text(mrb_state *mrb) {
  mrb_define_method(mrb, mrb->kernel_module, "draw_fps", mrb_draw_fps, MRB_ARGS_REQ(2));
  mrb_define_method(mrb, mrb->kernel_module, "draw_text", mrb_draw_text, MRB_ARGS_REQ(5));
}
