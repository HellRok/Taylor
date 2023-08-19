#include "mruby.h"
#include "mruby/class.h"
#include "mruby/data.h"
#include "raylib.h"
#include <cstdlib>

#include "mruby_integration/helpers.hpp"
#include "mruby_integration/struct_types.hpp"

#include "ruby/models/texture2d.hpp"

struct RClass* Texture2D_class;

void
setup_Texture2D(mrb_state* mrb,
                mrb_value object,
                Texture2D* texture,
                int id,
                int width,
                int height,
                int mipmaps,
                int format)
{
  ivar_attr_int(mrb, object, texture->id, id);
  ivar_attr_int(mrb, object, texture->width, width);
  ivar_attr_int(mrb, object, texture->height, height);
  ivar_attr_int(mrb, object, texture->mipmaps, mipmaps);
  ivar_attr_int(mrb, object, texture->format, format);
}

auto
mrb_Texture2D_initialize(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_int id, width, height, mipmaps, format;
  mrb_get_args(mrb, "iiiii", &id, &width, &height, &mipmaps, &format);

  Texture2D* texture = static_cast<Texture2D*> DATA_PTR(self);
  if (texture) {
    mrb_free(mrb, texture);
  }
  mrb_data_init(self, nullptr, &Texture2D_type);
  texture = static_cast<Texture2D*>(malloc(sizeof(Texture2D)));

  setup_Texture2D(mrb, self, texture, id, width, height, mipmaps, format);

  mrb_data_init(self, texture, &Texture2D_type);
  return self;
}

auto
mrb_Texture2D_set_id(mrb_state* mrb, mrb_value self) -> mrb_value
{
  attr_setter_int(mrb, self, Texture2D_type, Texture2D, id, id);
}

auto
mrb_Texture2D_set_width(mrb_state* mrb, mrb_value self) -> mrb_value
{
  attr_setter_int(mrb, self, Texture2D_type, Texture2D, width, width);
}

auto
mrb_Texture2D_set_height(mrb_state* mrb, mrb_value self) -> mrb_value
{
  attr_setter_int(mrb, self, Texture2D_type, Texture2D, height, height);
}

auto
mrb_Texture2D_set_mipmaps(mrb_state* mrb, mrb_value self) -> mrb_value
{
  attr_setter_int(mrb, self, Texture2D_type, Texture2D, mipmaps, mipmaps);
}

auto
mrb_Texture2D_set_format(mrb_state* mrb, mrb_value self) -> mrb_value
{
  attr_setter_int(mrb, self, Texture2D_type, Texture2D, format, format);
}

void
append_models_Texture2D(mrb_state* mrb)
{
  Texture2D_class = mrb_define_class(mrb, "Texture2D", mrb->object_class);
  MRB_SET_INSTANCE_TT(Texture2D_class, MRB_TT_DATA);
  mrb_define_method(mrb,
                    Texture2D_class,
                    "initialize",
                    mrb_Texture2D_initialize,
                    MRB_ARGS_REQ(5));
  mrb_define_method(
    mrb, Texture2D_class, "id=", mrb_Texture2D_set_id, MRB_ARGS_REQ(1));
  mrb_define_method(
    mrb, Texture2D_class, "width=", mrb_Texture2D_set_width, MRB_ARGS_REQ(1));
  mrb_define_method(
    mrb, Texture2D_class, "height=", mrb_Texture2D_set_height, MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    Texture2D_class,
                    "mipmaps=",
                    mrb_Texture2D_set_mipmaps,
                    MRB_ARGS_REQ(1));
  mrb_define_method(
    mrb, Texture2D_class, "format=", mrb_Texture2D_set_format, MRB_ARGS_REQ(1));

  load_ruby_models_texture2d(mrb);
}
