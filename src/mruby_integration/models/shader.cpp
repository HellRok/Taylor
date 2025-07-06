#include "mruby.h"
#include "mruby/class.h"
#include "mruby/data.h"
#include "raylib.h"
#include <cstdlib>
#include <sstream>

#include "mruby_integration/exceptions.hpp"
#include "mruby_integration/helpers.hpp"
#include "mruby_integration/struct_types.hpp"

#include "ruby/models/shader.hpp"

struct RClass* Shader_class;

void
setup_Shader(mrb_state* mrb, mrb_value object, Shader* shader, int id)
{
  ivar_attr_int(mrb, object, shader->id, id);
}

auto
mrb_Shader_initialize(mrb_state* mrb, mrb_value self) -> mrb_value
{
  Shader* shader;
  mrb_self_ptr(mrb, self, Shader, shader);

  // def initialize(fragment:, vertex:)
  const mrb_int kw_num = 2;
  const mrb_int kw_required = 0;
  const mrb_sym kw_names[] = { mrb_intern_lit(mrb, "fragment"),
                               mrb_intern_lit(mrb, "vertex") };
  mrb_value kw_values[kw_num];
  mrb_kwargs kwargs = { kw_num, kw_required, kw_names, kw_values, nullptr };
  mrb_get_args(mrb, ":", &kwargs);

  bool fragment_shader_found = true;
  bool vertex_shader_found = true;

  const char* fragment_shader_path = nullptr;
  if (!mrb_undef_p(kw_values[0])) {
    mrb_sym sym = mrb_obj_to_sym(mrb, kw_values[0]);
    fragment_shader_path = mrb_sym_name(mrb, sym);
    fragment_shader_found = FileExists(fragment_shader_path);
  }

  const char* vertex_shader_path = nullptr;
  if (!mrb_undef_p(kw_values[1])) {
    mrb_sym sym = mrb_obj_to_sym(mrb, kw_values[1]);
    vertex_shader_path = mrb_sym_name(mrb, sym);
    vertex_shader_found = FileExists(vertex_shader_path);
  }

  if (!fragment_shader_found || !vertex_shader_found) {
    std::stringstream message;
    message << "Unable to find ";
    if (!fragment_shader_found) {
      message << "'" << fragment_shader_path << "'";
    }

    if (!fragment_shader_found && !vertex_shader_found) {
      message << " and ";
    }

    if (!vertex_shader_found) {
      message << "'" << vertex_shader_path << "'";
    }

    raise_error(mrb, Shader_class, "NotFoundError", message.str());
  }

  *shader = LoadShader(vertex_shader_path, fragment_shader_path);

  mrb_data_init(self, shader, &Shader_type);
  return self;
}

mrb_attr_reader(mrb, self, int, Shader, id);

auto
mrb_Shader_unload(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Shader, shader);

  UnloadShader(*shader);

  return mrb_nil_value();
}

auto
mrb_Shader_ready(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Shader, shader);

  return mrb_bool_value(IsShaderReady(*shader));
}

void
append_models_Shader(mrb_state* mrb)
{
  Shader_class = mrb_define_class(mrb, "Shader", mrb->object_class);
  MRB_SET_INSTANCE_TT(Shader_class, MRB_TT_DATA);
  mrb_define_method(
    mrb, Shader_class, "initialize", mrb_Shader_initialize, MRB_ARGS_REQ(1));
  mrb_attr_reader_define(mrb, Shader, id);
  mrb_define_method(
    mrb, Shader_class, "unload", mrb_Shader_unload, MRB_ARGS_NONE());
  mrb_define_method(
    mrb, Shader_class, "ready?", mrb_Shader_ready, MRB_ARGS_NONE());

  load_ruby_models_shader(mrb);
}
