#include "mruby.h"
#include "mruby/class.h"
#include "mruby/data.h"
#include "raylib.h"
#include <cstdlib>

#include "mruby_integration/helpers.hpp"
#include "mruby_integration/models/texture2d.hpp"
#include "mruby_integration/struct_types.hpp"

#include "ruby/models/render_texture.hpp"

struct RClass* RenderTexture_class;

void
setup_RenderTexture(mrb_state* mrb, mrb_value object, int width, int height)
{
  mrb_iv_set(
    mrb, object, mrb_intern_cstr(mrb, "@width"), mrb_int_value(mrb, width));
  mrb_iv_set(
    mrb, object, mrb_intern_cstr(mrb, "@height"), mrb_int_value(mrb, height));
}

auto
mrb_RenderTexture_initialize(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_int width, height;
  mrb_get_args(mrb, "ii", &width, &height);

  auto* render_texture =
    static_cast<RenderTexture*>(malloc(sizeof(RenderTexture)));
  *render_texture = LoadRenderTexture(width, height);

  setup_RenderTexture(mrb, self, width, height);

  Texture2D* texture = &render_texture->texture;

  ivar_attr_texture2d(mrb, self, render_texture->texture, texture);

  add_reference(&render_texture->texture);

  mrb_data_init(self, render_texture, &RenderTexture_type);
  return self;
}

auto
mrb_RenderTexture_unload(mrb_state* mrb, mrb_value self) -> mrb_value
{
  RenderTexture* texture;
  Data_Get_Struct(mrb, self, &RenderTexture_type, texture);
  mrb_assert(texture != nullptr);

  UnloadRenderTexture(*texture);

  return mrb_nil_value();
}

void
append_models_RenderTexture(mrb_state* mrb)
{
  RenderTexture_class =
    mrb_define_class(mrb, "RenderTexture", mrb->object_class);
  MRB_SET_INSTANCE_TT(RenderTexture_class, MRB_TT_DATA);
  mrb_define_method(mrb,
                    RenderTexture_class,
                    "initialize",
                    mrb_RenderTexture_initialize,
                    MRB_ARGS_REQ(2));
  mrb_define_method(mrb,
                    RenderTexture_class,
                    "unload",
                    mrb_RenderTexture_unload,
                    MRB_ARGS_NONE());

  load_ruby_models_render_texture(mrb);
}
