#include <cstdlib>
#include "raylib.h"
#include "mruby.h"
#include "mruby/data.h"
#include "mruby/class.h"

#include "mruby_integration/struct_types.hpp"

mrb_value MrbLoadTexture(mrb_state *mrb, mrb_value self) {
  char* path;

  mrb_get_args(mrb, "s", &path);

  // 1. Loads the texture and displays it, but fails GC
  Texture2D *texture = (Texture2D *)malloc(sizeof(Texture2D));
  *texture = LoadTexture(path);

  mrb_value obj = mrb_obj_new(mrb, texture_class, 0, NULL);

  mrb_data_init(self, texture, &Texture2D_type);
  //RData *blah = Data_Wrap_Struct(mrb, texture_class, &Texture2D_type, texture);

  return obj;


  // 2. Loads the texture and displays it, but fails GC
  //RData *blah = Data_Wrap_Struct(mrb, texture_class, &Texture2D_type, NULL);
  //Texture2D *texture = (Texture2D *)malloc(sizeof(Texture2D));
  //*texture = LoadTexture(path);
  //blah->data = texture;

  //return mrb_obj_value(blah);

  // 3. Loads the texture and does not display it, but fails GC
  //Texture2D *texture;
  //*texture = LoadTexture(path);
  //RData *return_value;
  //Data_Make_Struct(mrb, texture_class, Texture2D, &Texture2D_type, texture, return_value);

  //return mrb_obj_value(return_value);

  // 4. Loads the texture, fails to return the Texture2D object in Ruby
  //Texture2D *texture = (Texture2D *)DATA_PTR(self);
  //if (texture) { mrb_free(mrb, texture); }
  //mrb_data_init(self, nullptr, &Texture2D_type);
  //texture = (Texture2D *)malloc(sizeof(Texture2D));

  //*texture = LoadTexture(path);

  //return self;

  // 5.
  //Texture2D *texture = (Texture2D *)DATA_PTR(self);
  //if (texture) { mrb_free(mrb, texture); }
  //mrb_data_init(self, nullptr, &Texture2D_type);
  //texture = (Texture2D *)malloc(sizeof(Texture2D));

  //*texture = LoadTexture("resources/wabbit.png");

  //mrb_data_init(self, texture, &Texture2D_type);
  //RData *blah = Data_Wrap_Struct(mrb, texture_class, &Texture2D_type, texture);

  //auto rvalue = mrb_obj_value(blah);

  //return rvalue;
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
