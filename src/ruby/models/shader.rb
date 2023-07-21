# The Shader class is for doing operations on the GPU
class Shader
  # @return [Integer]
  attr_reader :id

  # Loads a Shader
  # @param vertex_shader_path [String]
  # @param fragment_shader_path [String]
  # @return [Shader]
  def self.load(vertex_shader_path, fragment_shader_path)
    load_shader(vertex_shader_path, fragment_shader_path)
  end

  # Unloads the Shader from memory
  # @return [nil]
  def unload
    unload_shader(self)
  end

  # Instead of rendering straight to the screen, render through this Shader first
  # @yield The block that calls your rendering logic
  # @return [nil]
  def draw(&block)
    begin_shader_mode(self)
    block.call
    end_shader_mode
  end

  # Is the Shader ready to be used?
  # @return [Boolean]
  def ready?
    shader_ready?(self)
  end

  # Returns the location of uniform variable, will return nil if not found.
  # @param variable [String]
  # @return [Integer]
  def get_uniform_location(variable)
    value = get_shader_location(self, variable)
    value == -1 ? nil : value
  end

  # An encapsulating module for enums
  module Uniform
    # A single float value
    FLOAT = 0
    # An array of 2 floats
    VEC2 = 1
    # An array of 3 floats
    VEC3 = 2
    # An array of 4 floats
    VEC4 = 3
    # An single integer value
    INT = 4
    # An array of 2 integers
    IVEC2 = 5
    # An array of 3 integers
    IVEC3 = 6
    # An array of 4 integers
    IVEC4 = 7
    #SAMPLER2D = 8
  end
end
