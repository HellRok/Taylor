#include <cstdlib>
#include "raylib.h"
#include "mruby.h"
#include "mruby/data.h"
#include "mruby/class.h"
#include "mruby/string.h"

#include "mruby_integration/models/texture2d.hpp"
#include "mruby_integration/struct_types.hpp"

mrb_value mrb_load_texture(mrb_state *mrb, mrb_value) {
  mrb_value path;
  mrb_get_args(mrb, "S", &path);

  Texture2D *texture = (Texture2D *)malloc(sizeof(Texture2D));
  *texture = LoadTexture(mrb_str_to_cstr(mrb, path));

  return mrb_obj_value(Data_Wrap_Struct(mrb, Texture2D_class, &Texture2D_type, texture));
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

void append_textures(mrb_state *mrb) {
  mrb_define_method(mrb, mrb->kernel_module, "load_texture", mrb_load_texture, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "unload_texture", mrb_unload_texture, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "draw_texture", mrb_draw_texture, MRB_ARGS_REQ(4));
}
