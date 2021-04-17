#include <cstdlib>
#include "raylib.h"
#include "mruby.h"
#include "mruby/data.h"
#include "mruby/class.h"

#include "mruby_integration/helpers.hpp"
#include "mruby_integration/struct_types.hpp"

struct RClass *texture_class;

mrb_value MrbTexture2DInitialize(mrb_state *mrb, mrb_value self) {
  //mrb_int id, width, height, mipmaps, format;
  //mrb_get_args(mrb, "iiiii", &id, &width, &height, &mipmaps, &format);

  Texture2D *texture = (Texture2D *)DATA_PTR(self);
  if (texture) { mrb_free(mrb, texture); }
  mrb_data_init(self, nullptr, &Texture2D_type);
  texture = (Texture2D *)malloc(sizeof(Texture2D));

  //texture->id = id;
  //texture->width = width;
  //texture->height = height;
  //texture->mipmaps = mipmaps;
  //texture->format = format;
  *texture = LoadTexture("resources/wabbit.png");

  mrb_data_init(self, texture, &Texture2D_type);
  return self;
}

mrb_value MrbTexture2DGetId(mrb_state *mrb, mrb_value self) {
  attr_reader_int(mrb, self, Texture2D_type, Texture2D, id);
}

mrb_value MrbTexture2DSetId(mrb_state *mrb, mrb_value self) {
  attr_setter_int(mrb, self, Texture2D_type, Texture2D, id);
}

mrb_value MrbTexture2DGetWidth(mrb_state *mrb, mrb_value self) {
  attr_reader_int(mrb, self, Texture2D_type, Texture2D, width);
}

mrb_value MrbTexture2DSetWidth(mrb_state *mrb, mrb_value self) {
  attr_setter_int(mrb, self, Texture2D_type, Texture2D, width);
}

mrb_value MrbTexture2DGetHeight(mrb_state *mrb, mrb_value self) {
  attr_reader_int(mrb, self, Texture2D_type, Texture2D, height);
}

mrb_value MrbTexture2DSetHeight(mrb_state *mrb, mrb_value self) {
  attr_setter_int(mrb, self, Texture2D_type, Texture2D, height);
}

mrb_value MrbTexture2DGetMipmaps(mrb_state *mrb, mrb_value self) {
  attr_reader_int(mrb, self, Texture2D_type, Texture2D, mipmaps);
}

mrb_value MrbTexture2DSetMipmaps(mrb_state *mrb, mrb_value self) {
  attr_setter_int(mrb, self, Texture2D_type, Texture2D, mipmaps);
}

mrb_value MrbTexture2DGetFormat(mrb_state *mrb, mrb_value self) {
  attr_reader_int(mrb, self, Texture2D_type, Texture2D, format);
}

mrb_value MrbTexture2DSetFormat(mrb_state *mrb, mrb_value self) {
  attr_setter_int(mrb, self, Texture2D_type, Texture2D, format);
}

mrb_value MrbTexture2DLoad(mrb_state *mrb, mrb_value self) {
  char* path;

  mrb_get_args(mrb, "s", &path);

  Texture2D *texture = (Texture2D *)DATA_PTR(self);
  texture = (Texture2D *)malloc(sizeof(Texture2D));

  *texture = LoadTexture(path);
  mrb_value obj = mrb_obj_new(mrb, texture_class, 0, NULL);

  mrb_data_init(obj, texture, &Texture2D_type);
  return obj;
}

void appendModelsTexture2D(mrb_state *mrb) {
  texture_class = mrb_define_class(mrb, "Texture2D", mrb->object_class);
  MRB_SET_INSTANCE_TT(texture_class, MRB_TT_DATA);
  mrb_define_method(mrb, texture_class, "initialize", MrbTexture2DInitialize, MRB_ARGS_REQ(0));
  mrb_define_class_method(mrb, texture_class, "load", MrbTexture2DLoad, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, texture_class, "id", MrbTexture2DGetId, MRB_ARGS_NONE());
  mrb_define_method(mrb, texture_class, "id=", MrbTexture2DSetId, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, texture_class, "width", MrbTexture2DGetWidth, MRB_ARGS_NONE());
  mrb_define_method(mrb, texture_class, "width=", MrbTexture2DSetWidth, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, texture_class, "height", MrbTexture2DGetHeight, MRB_ARGS_NONE());
  mrb_define_method(mrb, texture_class, "height=", MrbTexture2DSetHeight, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, texture_class, "mipmaps", MrbTexture2DGetMipmaps, MRB_ARGS_NONE());
  mrb_define_method(mrb, texture_class, "mipmaps=", MrbTexture2DSetMipmaps, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, texture_class, "format", MrbTexture2DGetFormat, MRB_ARGS_NONE());
  mrb_define_method(mrb, texture_class, "format=", MrbTexture2DSetFormat, MRB_ARGS_REQ(1));
}
