#include <cstdlib>
#include "raylib.h"
#include "mruby.h"
#include "mruby/data.h"
#include "mruby/class.h"
#include "mruby/string.h"

#include "mruby_integration/models/colour.hpp"
#include "mruby_integration/models/texture2d.hpp"
#include "mruby_integration/struct_types.hpp"
#include "mruby_integration/helpers.hpp"

mrb_value mrb_load_texture(mrb_state *mrb, mrb_value) {
  mrb_value path;
  mrb_get_args(mrb, "S", &path);

  Texture2D *texture = (Texture2D *)malloc(sizeof(Texture2D));
  *texture = LoadTexture(mrb_str_to_cstr(mrb, path));

  mrb_value obj = mrb_obj_value(Data_Wrap_Struct(mrb, Texture2D_class, &Texture2D_type, texture));

  setup_Texture2D(mrb, obj, texture, texture->id, texture->width, texture->height, texture->mipmaps, texture->format);

  return obj;
}

mrb_value mrb_unload_texture(mrb_state *mrb, mrb_value) {
  Texture2D *texture;
  mrb_get_args(mrb, "d", &texture, &Texture2D_type);

  UnloadTexture(*texture);

  return mrb_nil_value();
}

mrb_value mrb_draw_texture(mrb_state *mrb, mrb_value) {
  Texture2D *texture;
  mrb_int x, y;
  Color *colour;

  mrb_get_args(mrb, "diid", &texture, &Texture2D_type, &x, &y, &colour, &Colour_type);

  DrawTexture(*texture, x, y, *colour);

  return mrb_nil_value();
}

mrb_value mrb_fade(mrb_state *mrb, mrb_value) {
  Color *colour;
  mrb_float alpha;
  mrb_get_args(mrb, "df", &colour, &Colour_type, &alpha);

  Color *return_colour = (Color *)malloc(sizeof(Color));
  *return_colour = Fade(*colour, alpha);

  mrb_value obj = mrb_obj_value(Data_Wrap_Struct(mrb, Colour_class, &Colour_type, return_colour));

  setup_Colour(mrb, obj, return_colour, return_colour->r, return_colour->g, return_colour->b, return_colour->a);

  return obj;
}

void append_textures(mrb_state *mrb) {
  mrb_define_method(mrb, mrb->kernel_module, "load_texture", mrb_load_texture, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "unload_texture", mrb_unload_texture, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "draw_texture", mrb_draw_texture, MRB_ARGS_REQ(4));

  mrb_define_method(mrb, mrb->kernel_module, "fade", mrb_fade, MRB_ARGS_REQ(2));
}
