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

auto mrb_RenderTexture_initialize(mrb_state* mrb, mrb_value self) -> mrb_value
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

  RenderTexture* render_texture;
  mrb_self_ptr(mrb, self, RenderTexture, render_texture);
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

auto mrb_RenderTexture_unload(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, RenderTexture, texture);

  UnloadRenderTexture(*texture);

  return mrb_nil_value();
}

auto mrb_RenderTexture_valid(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, RenderTexture, texture);

  return mrb_bool_value(IsRenderTextureValid(*texture));
}

auto mrb_RenderTexture_begin_drawing(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, RenderTexture, texture);

  BeginTextureMode(*texture);
  return mrb_nil_value();
}

auto mrb_RenderTexture_end_drawing(mrb_state*, mrb_value) -> mrb_value
{
  EndTextureMode();
  return mrb_nil_value();
}

void append_models_RenderTexture(mrb_state* mrb)
{
  RenderTexture_class = mrb_define_class(mrb, "RenderTexture", mrb->object_class);
  MRB_SET_INSTANCE_TT(RenderTexture_class, MRB_TT_DATA);
  mrb_define_method(
    mrb, RenderTexture_class, "initialize", mrb_RenderTexture_initialize, MRB_ARGS_REQ(2));
  mrb_attr_reader_define(mrb, RenderTexture, width);
  mrb_attr_reader_define(mrb, RenderTexture, height);
  mrb_define_method(mrb, RenderTexture_class, "unload", mrb_RenderTexture_unload, MRB_ARGS_NONE());
  mrb_define_method(mrb, RenderTexture_class, "valid?", mrb_RenderTexture_valid, MRB_ARGS_NONE());
  mrb_define_method(
    mrb, RenderTexture_class, "begin_drawing", mrb_RenderTexture_begin_drawing, MRB_ARGS_NONE());
  mrb_define_method(
    mrb, RenderTexture_class, "end_drawing", mrb_RenderTexture_end_drawing, MRB_ARGS_NONE());

  load_ruby_models_render_texture(mrb);
}
