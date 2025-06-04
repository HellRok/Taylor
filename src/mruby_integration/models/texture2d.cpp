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

auto
mrb_Texture2D_unload(mrb_state* mrb, mrb_value self) -> mrb_value
{
  Texture2D* texture;
  Data_Get_Struct(mrb, self, &Texture2D_type, texture);
  mrb_assert(texture != nullptr);

  UnloadTexture(*texture);

  return mrb_nil_value();
}

auto
mrb_Texture2D_filter_equals(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_int filter;
  mrb_get_args(mrb, "i", &filter);

  if (filter < 0 || filter > 5) {
    mrb_raise(mrb,
              E_ARGUMENT_ERROR,
              "Filter must be one of: Texture2D::NO_FILTER, "
              "Texture2D::BILINEAR, Texture2D::TRILINEAR, "
              "Texture2D::ANISOTROPIC_4X, Texture2D::ANISOTROPIC_8X, "
              "or Texture2D::ANISOTROPIC_16X");
  }

  Texture2D* texture;
  Data_Get_Struct(mrb, self, &Texture2D_type, texture);
  mrb_assert(texture != nullptr);

  SetTextureFilter(*texture, filter);

  return mrb_nil_value();
}

auto
mrb_Texture2D_generate_mipmaps(mrb_state* mrb, mrb_value self) -> mrb_value
{
  Texture2D* texture;
  Data_Get_Struct(mrb, self, &Texture2D_type, texture);
  mrb_assert(texture != nullptr);

  GenTextureMipmaps(texture);

  return mrb_nil_value();
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
  mrb_define_method(
    mrb, Texture2D_class, "unload", mrb_Texture2D_unload, MRB_ARGS_NONE());
  mrb_define_method(mrb,
                    Texture2D_class,
                    "filter=",
                    mrb_Texture2D_filter_equals,
                    MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    Texture2D_class,
                    "generate_mipmaps",
                    mrb_Texture2D_generate_mipmaps,
                    MRB_ARGS_NONE());

  load_ruby_models_texture2d(mrb);
}
