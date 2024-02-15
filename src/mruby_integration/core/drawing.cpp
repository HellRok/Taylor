#include "mruby.h"
#include "raylib.h"

#include "mruby_integration/struct_types.hpp"

#include "ruby/core/drawing.hpp"

auto
mrb_clear_background(mrb_state* mrb, mrb_value) -> mrb_value
{
  Color* colour;
  mrb_get_args(mrb, "d", &colour, &Colour_type);

  ClearBackground(*colour);
  return mrb_nil_value();
}

auto
mrb_begin_drawing(mrb_state*, mrb_value) -> mrb_value
{
  BeginDrawing();
  return mrb_nil_value();
}

auto
mrb_end_drawing(mrb_state*, mrb_value) -> mrb_value
{
  EndDrawing();
  return mrb_nil_value();
}

auto
mrb_begin_texture_mode(mrb_state* mrb, mrb_value) -> mrb_value
{
  RenderTexture* texture;
  mrb_get_args(mrb, "d", &texture, &RenderTexture_type);

  BeginTextureMode(*texture);
  return mrb_nil_value();
}

auto
mrb_end_texture_mode(mrb_state*, mrb_value) -> mrb_value
{
  EndTextureMode();
  return mrb_nil_value();
}

auto
mrb_begin_shader_mode(mrb_state* mrb, mrb_value) -> mrb_value
{
  Shader* shader;
  mrb_get_args(mrb, "d", &shader, &Shader_type);

  BeginShaderMode(*shader);
  return mrb_nil_value();
}

auto
mrb_end_shader_mode(mrb_state*, mrb_value) -> mrb_value
{
  EndShaderMode();
  return mrb_nil_value();
}

auto
mrb_begin_scissor_mode(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int x, y, width, height;
  mrb_get_args(mrb, "iiii", &x, &y, &width, &height);

  BeginScissorMode(x, y, width, height);
  return mrb_nil_value();
}

auto
mrb_end_scissor_mode(mrb_state*, mrb_value) -> mrb_value
{
  EndScissorMode();
  return mrb_nil_value();
}

void
append_core_drawing(mrb_state* mrb)
{
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "clear_background",
                    mrb_clear_background,
                    MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "begin_drawing",
                    mrb_begin_drawing,
                    MRB_ARGS_NONE());
  mrb_define_method(
    mrb, mrb->kernel_module, "end_drawing", mrb_end_drawing, MRB_ARGS_NONE());
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "begin_texture_mode",
                    mrb_begin_texture_mode,
                    MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "end_texture_mode",
                    mrb_end_texture_mode,
                    MRB_ARGS_NONE());
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "begin_shader_mode",
                    mrb_begin_shader_mode,
                    MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "end_shader_mode",
                    mrb_end_shader_mode,
                    MRB_ARGS_NONE());
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "begin_scissor_mode",
                    mrb_begin_scissor_mode,
                    MRB_ARGS_REQ(4));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "end_scissor_mode",
                    mrb_end_scissor_mode,
                    MRB_ARGS_NONE());

  load_ruby_core_drawing(mrb);
}
