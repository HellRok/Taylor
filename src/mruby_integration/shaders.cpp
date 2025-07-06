#include "mruby.h"
#include "mruby/array.h"
#include "mruby/class.h"
#include "mruby/data.h"
#include "mruby/string.h"
#include "raylib.h"

#include "mruby_integration/helpers.hpp"
#include "mruby_integration/models/shader.hpp"
#include "mruby_integration/struct_types.hpp"

auto
mrb_load_shader_from_string(mrb_state* mrb, mrb_value) -> mrb_value
{
  char* vertex_shader_code = nullptr;
  char* fragment_shader_code = nullptr;

  mrb_get_args(mrb, "z!z!", &vertex_shader_code, &fragment_shader_code);

  auto* shader = static_cast<Shader*>(malloc(sizeof(Shader)));
  *shader = LoadShaderFromMemory(vertex_shader_code, fragment_shader_code);

  mrb_value obj =
    mrb_obj_value(Data_Wrap_Struct(mrb, Shader_class, &Shader_type, shader));

  setup_Shader(mrb, obj, shader, shader->id);

  return obj;
}

auto
mrb_get_shader_location(mrb_state* mrb, mrb_value) -> mrb_value
{
  Shader* shader;
  char* uniform_name;
  mrb_get_args(mrb, "dz", &shader, &Shader_type, &uniform_name);

  return mrb_int_value(mrb, GetShaderLocation(*shader, uniform_name));
}

auto
mrb_set_shader_values(mrb_state* mrb, mrb_value) -> mrb_value
{
  Shader* shader;
  mrb_int variable_location, enum_value;
  int array_length;
  mrb_value array;
  mrb_get_args(mrb,
               "diAi",
               &shader,
               &Shader_type,
               &variable_location,
               &array,
               &enum_value);

  mrb_ensure_array_type(mrb, array);

  array_length = RARRAY_LEN(array);

  switch (enum_value) {
    case SHADER_UNIFORM_FLOAT: {
      float values[array_length];
      for (mrb_int i = 0; i < array_length; i++) {
        values[i] = mrb_float(mrb_ary_entry(array, i));
      }
      SetShaderValueV(
        *shader, variable_location, values, enum_value, array_length);
      break;
    }

    case SHADER_UNIFORM_VEC2: {
      float values[array_length][2];
      for (mrb_int i = 0; i < array_length; i++) {
        for (mrb_int j = 0; j < 2; j++) {
          values[i][j] = mrb_float(mrb_ary_entry(mrb_ary_entry(array, i), j));
        }
      }
      SetShaderValueV(
        *shader, variable_location, values, enum_value, array_length);
      break;
    }

    case SHADER_UNIFORM_VEC3: {
      float values[array_length][3];
      for (mrb_int i = 0; i < array_length; i++) {
        for (mrb_int j = 0; j < 3; j++) {
          values[i][j] = mrb_float(mrb_ary_entry(mrb_ary_entry(array, i), j));
        }
      }
      SetShaderValueV(
        *shader, variable_location, values, enum_value, array_length);
      break;
    }

    case SHADER_UNIFORM_VEC4: {
      float values[array_length][4];
      for (mrb_int i = 0; i < array_length; i++) {
        for (mrb_int j = 0; j < 4; j++) {
          values[i][j] = mrb_float(mrb_ary_entry(mrb_ary_entry(array, i), j));
        }
      }
      SetShaderValueV(
        *shader, variable_location, values, enum_value, array_length);
      break;
    }

    case SHADER_UNIFORM_INT: {
      int values[array_length];
      for (mrb_int i = 0; i < array_length; i++) {
        values[i] = mrb_integer(mrb_ary_entry(array, i));
      }
      SetShaderValueV(
        *shader, variable_location, values, enum_value, array_length);
      break;
    }

    case SHADER_UNIFORM_IVEC2: {
      int values[array_length][2];
      for (mrb_int i = 0; i < array_length; i++) {
        for (mrb_int j = 0; j < 2; j++) {
          values[i][j] = mrb_integer(mrb_ary_entry(mrb_ary_entry(array, i), j));
        }
      }
      SetShaderValueV(
        *shader, variable_location, values, enum_value, array_length);
      break;
    }

    case SHADER_UNIFORM_IVEC3: {
      int values[array_length][3];
      for (mrb_int i = 0; i < array_length; i++) {
        for (mrb_int j = 0; j < 3; j++) {
          values[i][j] = mrb_integer(mrb_ary_entry(mrb_ary_entry(array, i), j));
        }
      }
      SetShaderValueV(
        *shader, variable_location, values, enum_value, array_length);
      break;
    }

    case SHADER_UNIFORM_IVEC4: {
      int values[array_length][4];
      for (mrb_int i = 0; i < array_length; i++) {
        for (mrb_int j = 0; j < 4; j++) {
          values[i][j] = mrb_integer(mrb_ary_entry(mrb_ary_entry(array, i), j));
        }
      }
      SetShaderValueV(
        *shader, variable_location, values, enum_value, array_length);
      break;
    }

      // Not implemented as I couldn't find what this actually did in the raylib
      // source or examples.
      // case SHADER_UNIFORM_SAMPLER2D:
      //  {
      //    break;
      //  }

    default: {
      // In theory we should never get here due to the ruby code
      // catching it first.
      break;
    }
  }

  return mrb_nil_value();
}

void
append_shaders(mrb_state* mrb)
{
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "load_shader_from_string",
                    mrb_load_shader_from_string,
                    MRB_ARGS_REQ(2));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "get_shader_location",
                    mrb_get_shader_location,
                    MRB_ARGS_REQ(2));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "set_shader_values",
                    mrb_set_shader_values,
                    MRB_ARGS_REQ(4));
}
