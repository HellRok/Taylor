#include <cstdlib>
#include "raylib.h"
#include "mruby.h"
#include "mruby/data.h"
#include "mruby/class.h"
#include "mruby/string.h"

#include "mruby_integration/struct_types.hpp"

mrb_value MrbLoadTexture(mrb_state *mrb, mrb_value) {
  mrb_value path;
  mrb_get_args(mrb, "S", &path);

  Texture2D *texture = (Texture2D *)malloc(sizeof(Texture2D));
  *texture = LoadTexture(mrb_str_to_cstr(mrb, path));

  return mrb_obj_value(Data_Wrap_Struct(mrb, texture_class, &Texture2D_type, texture));
}

mrb_value MrbDrawTexture(mrb_state *mrb, mrb_value) {
  Texture2D *texture;
  mrb_int x, y;
  Color *color;

  mrb_get_args(mrb, "diid", &texture, &Texture2D_type, &x, &y, &color, &Colour_type);

  DrawTexture(*texture, x, y, *color);

  return mrb_nil_value();
}

void appendTextures(mrb_state *mrb) {
  mrb_define_method(mrb, mrb->kernel_module, "load_texture", MrbLoadTexture, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "draw_texture", MrbDrawTexture, MRB_ARGS_REQ(4));
}
