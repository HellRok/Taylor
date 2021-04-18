#include <cstdlib>
#include "raylib.h"
#include "mruby.h"
#include "mruby/data.h"
#include "mruby/class.h"

#include "mruby_integration/helpers.hpp"
#include "mruby_integration/struct_types.hpp"

struct RClass *Texture2D_class;

mrb_value mrb_Texture2D_initialize(mrb_state *mrb, mrb_value self) {
  mrb_int id, width, height, mipmaps, format;
  id = 0;
  width = 0;
  height = 0;
  mipmaps = 0;
  format = 0;
  mrb_get_args(mrb, "|iiiii", &id, &width, &height, &mipmaps, &format);

  Texture2D *texture = (Texture2D *)DATA_PTR(self);
  if (texture) { mrb_free(mrb, texture); }
  mrb_data_init(self, nullptr, &Texture2D_type);
  texture = (Texture2D *)malloc(sizeof(Texture2D));

  texture->id = id;
  texture->width = width;
  texture->height = height;
  texture->mipmaps = mipmaps;
  texture->format = format;

  mrb_data_init(self, texture, &Texture2D_type);
  return self;
}

mrb_value mrb_Texture2D_get_id(mrb_state *mrb, mrb_value self) {
  attr_reader_int(mrb, self, Texture2D_type, Texture2D, id);
}

mrb_value mrb_Texture2D_set_id(mrb_state *mrb, mrb_value self) {
  attr_setter_int(mrb, self, Texture2D_type, Texture2D, id);
}

mrb_value mrb_Texture2D_get_width(mrb_state *mrb, mrb_value self) {
  attr_reader_int(mrb, self, Texture2D_type, Texture2D, width);
}

mrb_value mrb_Texture2D_set_width(mrb_state *mrb, mrb_value self) {
  attr_setter_int(mrb, self, Texture2D_type, Texture2D, width);
}

mrb_value mrb_Texture2D_get_height(mrb_state *mrb, mrb_value self) {
  attr_reader_int(mrb, self, Texture2D_type, Texture2D, height);
}

mrb_value mrb_Texture2D_set_height(mrb_state *mrb, mrb_value self) {
  attr_setter_int(mrb, self, Texture2D_type, Texture2D, height);
}

mrb_value mrb_Texture2D_get_mipmaps(mrb_state *mrb, mrb_value self) {
  attr_reader_int(mrb, self, Texture2D_type, Texture2D, mipmaps);
}

mrb_value mrb_Texture2D_set_mipmaps(mrb_state *mrb, mrb_value self) {
  attr_setter_int(mrb, self, Texture2D_type, Texture2D, mipmaps);
}

mrb_value mrb_Texture2D_get_format(mrb_state *mrb, mrb_value self) {
  attr_reader_int(mrb, self, Texture2D_type, Texture2D, format);
}

mrb_value mrb_Texture2D_set_format(mrb_state *mrb, mrb_value self) {
  attr_setter_int(mrb, self, Texture2D_type, Texture2D, format);
}

void append_models_Texture2D(mrb_state *mrb) {
  Texture2D_class = mrb_define_class(mrb, "Texture2D", mrb->object_class);
  MRB_SET_INSTANCE_TT(Texture2D_class, MRB_TT_DATA);
  mrb_define_method(mrb, Texture2D_class, "initialize", mrb_Texture2D_initialize, MRB_ARGS_ARG(0, 5));
  mrb_define_method(mrb, Texture2D_class, "id", mrb_Texture2D_get_id, MRB_ARGS_NONE());
  mrb_define_method(mrb, Texture2D_class, "id=", mrb_Texture2D_set_id, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, Texture2D_class, "width", mrb_Texture2D_get_width, MRB_ARGS_NONE());
  mrb_define_method(mrb, Texture2D_class, "width=", mrb_Texture2D_set_width, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, Texture2D_class, "height", mrb_Texture2D_get_height, MRB_ARGS_NONE());
  mrb_define_method(mrb, Texture2D_class, "height=", mrb_Texture2D_set_height, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, Texture2D_class, "mipmaps", mrb_Texture2D_get_mipmaps, MRB_ARGS_NONE());
  mrb_define_method(mrb, Texture2D_class, "mipmaps=", mrb_Texture2D_set_mipmaps, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, Texture2D_class, "format", mrb_Texture2D_get_format, MRB_ARGS_NONE());
  mrb_define_method(mrb, Texture2D_class, "format=", mrb_Texture2D_set_format, MRB_ARGS_REQ(1));
}
