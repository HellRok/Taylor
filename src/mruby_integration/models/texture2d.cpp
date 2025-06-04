#include "mruby.h"
#include "mruby/class.h"
#include "mruby/data.h"
#include "raylib.h"
#include <cstdlib>

#include "mruby_integration/exceptions.hpp"
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
  char* path;
  mrb_get_args(mrb, "z", &path);

  if (!FileExists(path)) {
    raise_not_found_error(mrb, Texture2D_class, path);
  }

  auto* texture = static_cast<Texture2D*>(malloc(sizeof(Texture2D)));
  if (texture) {
    mrb_free(mrb, texture);
  }
  mrb_data_init(self, nullptr, &Texture2D_type);
  texture = static_cast<Texture2D*>(malloc(sizeof(Texture2D)));

  *texture = LoadTexture(path);

  setup_Texture2D(mrb,
                  self,
                  texture,
                  texture->id,
                  texture->width,
                  texture->height,
                  texture->mipmaps,
                  texture->format);

  mrb_data_init(self, texture, &Texture2D_type);
  return self;
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
                    MRB_ARGS_REQ(1));

  load_ruby_models_texture2d(mrb);
}
