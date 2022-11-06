# Loads a shader from a file
# @param path [String]
# @return [Shader]
def load_shader(path)
  # mrb_load_shader
  # src/mruby_integration/shaders.cpp
  Shader.new
end

# Unloads a shader
# @param shader [Shader]
# @return [nil]
def unload_shader(shader)
  # mrb_unload_shader
  # src/mruby_integration/shaders.cpp
  nil
end
