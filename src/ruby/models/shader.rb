class Shader
  attr_reader :id

  def self.load(vertex_shader_path, fragment_shader_path)
    load_shader(vertex_shader_path, fragment_shader_path)
  end

  def unload
    unload_shader(self)
  end

  def draw(&block)
    begin_shader_mode(self)
    block.call
    end_shader_mode
  end

  def ready?
    shader_ready?(self)
  end

  def get_uniform_location(variable)
    value = get_shader_location(self, variable)
    value == -1 ? nil : value
  end

  module Uniform
    FLOAT = 0
    VEC2 = 1
    VEC3 = 2
    VEC4 = 3
    INT = 4
    IVEC2 = 5
    IVEC3 = 6
    IVEC4 = 7
    #SAMPLER2D = 8
  end
end
