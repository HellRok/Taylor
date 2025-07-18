# Loads a shader from in-memory strings.
# @param vertex_shader_code [String]
# @param fragment_shader_code [String]
# @return [Shader]
def load_shader_from_string(vertex_shader_code, fragment_shader_code)
  # mrb_load_shader
  # src/mruby_integration/shaders.cpp
  Shader.new
end

# Returns the location of uniform variable, will return -1 if not found.
# @param shader [Shader]
# @param variable [String]
# @return [Integer]
def get_shader_location(shader, variable)
  # mrb_get_shader_location
  # src/mruby_integration/shaders.cpp
  1
end

# Returns the location of uniform variable, will return -1 if not found.
# @param shader [Shader]
# @param variable_location [Integer] The value you got from {get_shader_location}.
# @param variables [Array]
# @param variable_type [Integer] Valid options are {Shader::Uniform::FLOAT}, {Shader::Uniform::VEC2}, {Shader::Uniform::VEC3}, {Shader::Uniform::VEC4}, {Shader::Uniform::INT}, {Shader::Uniform::IVEC2}, {Shader::Uniform::IVEC3} or {Shader::Uniform::IVEC4}.
# @return [Integer]
def set_shader_values(shader, variable_location, variables, variable_type)
  # mrb_set_shader_values
  # src/mruby_integration/shaders.cpp
  1
end
