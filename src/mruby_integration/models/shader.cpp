#include "mruby.h"
#include "mruby/array.h"
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

auto
mrb_Shader_load_code(mrb_state* mrb, mrb_value) -> mrb_value
{
  // def self.load_code(fragment: nil, vertex: nil)
  const mrb_int kw_num = 2;
  const mrb_int kw_required = 0;
  const mrb_sym kw_names[] = { mrb_intern_lit(mrb, "fragment"),
                               mrb_intern_lit(mrb, "vertex") };
  mrb_value kw_values[kw_num];
  mrb_kwargs kwargs = { kw_num, kw_required, kw_names, kw_values, nullptr };
  mrb_get_args(mrb, ":", &kwargs);

  const char* fragment_shader_code = nullptr;
  if (!mrb_undef_p(kw_values[0])) {
    mrb_sym sym = mrb_obj_to_sym(mrb, kw_values[0]);
    fragment_shader_code = mrb_sym_name(mrb, sym);
  }

  const char* vertex_shader_code = nullptr;
  if (!mrb_undef_p(kw_values[1])) {
    mrb_sym sym = mrb_obj_to_sym(mrb, kw_values[1]);
    vertex_shader_code = mrb_sym_name(mrb, sym);
  }

  auto* shader = static_cast<Shader*>(malloc(sizeof(Shader)));
  *shader = LoadShaderFromMemory(vertex_shader_code, fragment_shader_code);

  mrb_value obj =
    mrb_obj_value(Data_Wrap_Struct(mrb, Shader_class, &Shader_type, shader));

  setup_Shader(mrb, obj, shader, shader->id);

  return obj;
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

auto
mrb_Shader_location_of(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Shader, shader);

  char* uniform_name;
  mrb_get_args(mrb, "z", &uniform_name);

  int location = GetShaderLocation(*shader, uniform_name);

  if (location < 0) {
    return mrb_nil_value();
  } else {
    return mrb_int_value(mrb, location);
  }
}

auto
mrb_Shader_set(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Shader, shader);

  // def set(location: nil, variable: nil, value: nil, values: [])
  const mrb_int kw_num = 4;
  const mrb_int kw_required = 0;
  const mrb_sym kw_names[] = { mrb_intern_lit(mrb, "location"),
                               mrb_intern_lit(mrb, "variable"),
                               mrb_intern_lit(mrb, "value"),
                               mrb_intern_lit(mrb, "values") };
  mrb_value kw_values[kw_num];
  mrb_kwargs kwargs = { kw_num, kw_required, kw_names, kw_values, nullptr };
  mrb_get_args(mrb, ":", &kwargs);

  if (!mrb_undef_p(kw_values[0]) && !mrb_undef_p(kw_values[1])) {
    mrb_raise(
      mrb, E_ARGUMENT_ERROR, "Can't pass both 'location' and 'variable'");
  } else if (mrb_undef_p(kw_values[0]) && mrb_undef_p(kw_values[1])) {
    mrb_raise(
      mrb, E_ARGUMENT_ERROR, "Must pass either 'location' or 'variable'");
  }

  if (!mrb_undef_p(kw_values[2]) && !mrb_undef_p(kw_values[3])) {
    mrb_raise(mrb, E_ARGUMENT_ERROR, "Can't pass both 'value' and 'values'");
  } else if (mrb_undef_p(kw_values[2]) && mrb_undef_p(kw_values[3])) {
    mrb_raise(mrb, E_ARGUMENT_ERROR, "Must pass either 'value' or 'values'");
  }

  int variable_location = -1;
  if (!mrb_undef_p(kw_values[0])) {
    variable_location = mrb_as_int(mrb, kw_values[0]);
  }

  const char* variable_name = nullptr;
  if (!mrb_undef_p(kw_values[1])) {
    mrb_sym sym = mrb_obj_to_sym(mrb, kw_values[1]);
    variable_name = mrb_sym_name(mrb, sym);

    variable_location = GetShaderLocation(*shader, variable_name);

    if (variable_location == -1) {
      std::stringstream message;
      message << "Couldn't locate variable ";
      message << "'" << variable_name << "'";

      mrb_raise(mrb, E_ARGUMENT_ERROR, message.str().c_str());
    }
  }

  mrb_value values = mrb_ary_new(mrb);
  mrb_value value;
  if (!mrb_undef_p(kw_values[2])) {
    value = kw_values[2];

    if (mrb_obj_class(mrb, value) != mrb_class_get(mrb, "Array") &&
        mrb_obj_class(mrb, value) != mrb_class_get(mrb, "Integer") &&
        mrb_obj_class(mrb, value) != mrb_class_get(mrb, "Float")) {
      mrb_raise(mrb,
                E_ARGUMENT_ERROR,
                "Value must be either an Integer, Float, or Array");
    }

    mrb_ary_push(mrb, values, value);
  }

  if (!mrb_undef_p(kw_values[3])) {
    values = kw_values[3];

    if (mrb_obj_class(mrb, values) != mrb_class_get(mrb, "Array")) {
      mrb_raise(mrb, E_ARGUMENT_ERROR, "Values must be an Array");
    }
  }

  const int array_length = RARRAY_LEN(values);
  const RClass* first_class = mrb_obj_class(mrb, mrb_ary_entry(values, 0));

  if (first_class == mrb_class_get(mrb, "Integer")) {
    int c_values[array_length];
    for (int i = 0; i < array_length; i++) {
      c_values[i] = mrb_as_int(mrb, mrb_ary_entry(values, i));
    }

    SetShaderValueV(
      *shader, variable_location, c_values, SHADER_UNIFORM_INT, array_length);

    return mrb_nil_value();

  } else if (first_class == mrb_class_get(mrb, "Float")) {
    float c_values[array_length];
    for (int i = 0; i < array_length; i++) {
      c_values[i] = mrb_as_float(mrb, mrb_ary_entry(values, i));
    }

    SetShaderValueV(
      *shader, variable_location, c_values, SHADER_UNIFORM_FLOAT, array_length);

    return mrb_nil_value();
  }

  int sub_array_length = RARRAY_LEN(mrb_ary_entry(values, 0));
  RClass* sub_array_first_class =
    mrb_obj_class(mrb, mrb_ary_entry(mrb_ary_entry(values, 0), 0));
  int variable_type = -1;

  if (sub_array_length < 2) {
    std::stringstream message;
    message << "Passed " << sub_array_length << " ";
    if (sub_array_first_class == mrb_class_get(mrb, "Integer")) {
      message << "integers";
    } else if (sub_array_first_class == mrb_class_get(mrb, "Float")) {
      message << "floats";
    }
    message << ", you must pass at least 2";

    mrb_raise(mrb, E_ARGUMENT_ERROR, message.str().c_str());
  }

  if (sub_array_length > 4) {
    std::stringstream message;
    message << "Passed " << sub_array_length << " ";
    if (sub_array_first_class == mrb_class_get(mrb, "Integer")) {
      message << "integers";
    } else if (sub_array_first_class == mrb_class_get(mrb, "Float")) {
      message << "floats";
    }
    message << ", you must pass no more than 4";

    mrb_raise(mrb, E_ARGUMENT_ERROR, message.str().c_str());
  }

  if (sub_array_first_class == mrb_class_get(mrb, "Float")) {
    if (sub_array_length == 2) {
      variable_type = SHADER_UNIFORM_VEC2;
    } else if (sub_array_length == 3) {
      variable_type = SHADER_UNIFORM_VEC3;
    } else if (sub_array_length == 4) {
      variable_type = SHADER_UNIFORM_VEC4;
    }
  } else if (sub_array_first_class == mrb_class_get(mrb, "Integer")) {
    if (sub_array_length == 2) {
      variable_type = SHADER_UNIFORM_IVEC2;
    } else if (sub_array_length == 3) {
      variable_type = SHADER_UNIFORM_IVEC3;
    } else if (sub_array_length == 4) {
      variable_type = SHADER_UNIFORM_IVEC4;
    }
  }

  if (sub_array_first_class == mrb_class_get(mrb, "Float")) {
    float c_values[array_length][sub_array_length];
    for (int i = 0; i < array_length; i++) {
      mrb_value sub_array = mrb_ary_entry(values, i);
      if (mrb_obj_class(mrb, sub_array) != mrb_class_get(mrb, "Array")) {
        mrb_raise(mrb, E_ARGUMENT_ERROR, "Must be all integers or all floats");
      }

      if (RARRAY_LEN(sub_array) != sub_array_length) {
        mrb_raise(mrb, E_ARGUMENT_ERROR, "All arrays must be the same length");
      }

      for (int j = 0; j < sub_array_length; j++) {
        mrb_value sub_value = mrb_ary_entry(sub_array, j);
        if (mrb_obj_class(mrb, sub_value) != mrb_class_get(mrb, "Float")) {
          mrb_raise(
            mrb, E_ARGUMENT_ERROR, "Must be all integers or all floats");
        }

        c_values[i][j] = mrb_as_float(mrb, sub_value);
      }
    }

    SetShaderValueV(
      *shader, variable_location, c_values, variable_type, array_length);

  } else if (sub_array_first_class == mrb_class_get(mrb, "Integer")) {
    int c_values[array_length][sub_array_length];
    for (int i = 0; i < array_length; i++) {
      mrb_value sub_array = mrb_ary_entry(values, i);
      if (mrb_obj_class(mrb, sub_array) != mrb_class_get(mrb, "Array")) {
        mrb_raise(mrb, E_ARGUMENT_ERROR, "Must be all integers or all floats");
      }

      if (RARRAY_LEN(sub_array) != sub_array_length) {
        mrb_raise(mrb, E_ARGUMENT_ERROR, "All arrays must be the same length");
      }

      for (int j = 0; j < sub_array_length; j++) {
        mrb_value sub_value = mrb_ary_entry(sub_array, j);
        if (mrb_obj_class(mrb, sub_value) != mrb_class_get(mrb, "Integer")) {
          mrb_raise(
            mrb, E_ARGUMENT_ERROR, "Must be all integers or all floats");
        }

        c_values[i][j] = mrb_as_int(mrb, sub_value);
      }
    }

    SetShaderValueV(
      *shader, variable_location, c_values, variable_type, array_length);
  }

  return mrb_nil_value();
}

auto
mrb_Shader_begin_drawing(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Shader, shader);

  BeginShaderMode(*shader);
  return mrb_nil_value();
}

auto
mrb_Shader_end_drawing(mrb_state*, mrb_value) -> mrb_value
{
  EndShaderMode();
  return mrb_nil_value();
}

void
append_models_Shader(mrb_state* mrb)
{
  Shader_class = mrb_define_class(mrb, "Shader", mrb->object_class);
  MRB_SET_INSTANCE_TT(Shader_class, MRB_TT_DATA);
  mrb_define_method(
    mrb, Shader_class, "initialize", mrb_Shader_initialize, MRB_ARGS_REQ(1));
  mrb_define_class_method(
    mrb, Shader_class, "load_code", mrb_Shader_load_code, MRB_ARGS_REQ(1));
  mrb_attr_reader_define(mrb, Shader, id);
  mrb_define_method(
    mrb, Shader_class, "unload", mrb_Shader_unload, MRB_ARGS_NONE());
  mrb_define_method(
    mrb, Shader_class, "ready?", mrb_Shader_ready, MRB_ARGS_NONE());
  mrb_define_method(
    mrb, Shader_class, "location_of", mrb_Shader_location_of, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, Shader_class, "set", mrb_Shader_set, MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    Shader_class,
                    "begin_drawing",
                    mrb_Shader_begin_drawing,
                    MRB_ARGS_NONE());
  mrb_define_method(
    mrb, Shader_class, "end_drawing", mrb_Shader_end_drawing, MRB_ARGS_NONE());

  load_ruby_models_shader(mrb);
}
