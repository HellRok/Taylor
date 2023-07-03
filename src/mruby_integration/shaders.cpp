#include "raylib.h"
#include "mruby.h"
#include "mruby/data.h"
#include "mruby/class.h"
#include "mruby/string.h"

#include "mruby_integration/models/shader.hpp"
#include "mruby_integration/struct_types.hpp"
#include "mruby_integration/helpers.hpp"

mrb_value mrb_load_shader(mrb_state *mrb, mrb_value) {
  char *vertex_shader_path, *fragment_shader_path;
  mrb_get_args(mrb, "zz", &vertex_shader_path, &fragment_shader_path);

  Shader *shader = (Shader *)malloc(sizeof(Shader));
  *shader = LoadShader(vertex_shader_path, fragment_shader_path);

  mrb_value obj = mrb_obj_value(Data_Wrap_Struct(mrb, Shader_class, &Shader_type, shader));

  setup_Shader(mrb, obj, shader, shader->id);

  return obj;
}

mrb_value mrb_unload_shader(mrb_state *mrb, mrb_value) {
  Shader *shader;
  mrb_get_args(mrb, "d", &shader, &Shader_type);

  UnloadShader(*shader);

  return mrb_nil_value();
}

mrb_value mrb_shader_ready(mrb_state *mrb, mrb_value) {
  Shader *shader;
  mrb_get_args(mrb, "d", &shader, &Shader_type);

  return mrb_bool_value(IsShaderReady(*shader));
}

mrb_value mrb_get_shader_location(mrb_state *mrb, mrb_value) {
  Shader *shader;
  char *uniform_name;
  mrb_get_args(mrb, "dz", &shader, &Shader_type, &uniform_name);

  return mrb_int_value(mrb, GetShaderLocation(*shader, uniform_name));
}

void append_shaders(mrb_state *mrb) {
  mrb_define_method(mrb, mrb->kernel_module, "load_shader", mrb_load_shader, MRB_ARGS_REQ(2));
  mrb_define_method(mrb, mrb->kernel_module, "unload_shader", mrb_unload_shader, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "shader_ready?", mrb_shader_ready, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "get_shader_location", mrb_get_shader_location, MRB_ARGS_REQ(2));
}
