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

auto
mrb_RenderTexture_initialize(mrb_state* mrb, mrb_value self) -> mrb_value
{
  // RenderTexture.new(width:, height:)
  const mrb_int kw_num = 2;
  const mrb_int kw_required = 2;
  const mrb_sym kw_names[] = {
    mrb_intern_lit(mrb, "width"),
    mrb_intern_lit(mrb, "height"),
  };
  mrb_value kw_values[kw_num];
  mrb_kwargs kwargs = { kw_num, kw_required, kw_names, kw_values, nullptr };
  mrb_get_args(mrb, ":", &kwargs);

  int width = 0;
  if (!mrb_undef_p(kw_values[0])) {
    width = mrb_as_int(mrb, kw_values[0]);
  }

  int height = 0;
  if (!mrb_undef_p(kw_values[1])) {
    height = mrb_as_int(mrb, kw_values[1]);
  }

  auto* render_texture =
    static_cast<RenderTexture*>(malloc(sizeof(RenderTexture)));
  *render_texture = LoadRenderTexture(width, height);

  add_reference(&render_texture->texture);
  mrb_iv_set(mrb,
             self,
             mrb_intern_cstr(mrb, "@texture"),
             mrb_Texture2D_value(mrb, &render_texture->texture));

  mrb_data_init(self, render_texture, &RenderTexture_type);
  return self;
}

mrb_attr_reader_with_klasses_and_attrs(mrb,
                                       self,
                                       int,
                                       RenderTexture,
                                       RenderTexture,
                                       width,
                                       texture.width);
mrb_attr_reader_with_klasses_and_attrs(mrb,
                                       self,
                                       int,
                                       RenderTexture,
                                       RenderTexture,
                                       height,
                                       texture.height);

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
  mrb_attr_reader_define(mrb, RenderTexture, width);
  mrb_attr_reader_define(mrb, RenderTexture, height);
  mrb_define_method(mrb,
                    RenderTexture_class,
                    "unload",
                    mrb_RenderTexture_unload,
                    MRB_ARGS_NONE());

  load_ruby_models_render_texture(mrb);
}
