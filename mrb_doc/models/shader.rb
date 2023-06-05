# The Shader class is for doing operations on the GPU
class Shader
  # @return [Integer]
  attr_reader :id

  # Creates a new instance of Shader
  # @param id [Integer]
  # @return [Shader]
  def initialize(id)
    # mrb_Shader_initialize
    # src/mruby_integration/models/shader.cpp
    Shader.new
  end

  # Loads a Shader
  # @param vertex_shader_path [String]
  # @param fragment_shader_path [String]
  # @return [Shader]
  def self.load(vertex_shader_path, fragment_shader_path)
    # src/mruby_integration/models/shader.cpp
    Shader.new
  end

  # Unloads the Shader from memory
  # @return [nil]
  def unload
    # src/mruby_integration/models/shader.cpp
    nil
  end

  def id=(id)
    # mrb_Shader_set_id
    # src/mruby_integration/models/shader.cpp
    0
  end

  # Instead of rendering straight to the screen, render through this Shader first
  # @yield The block that calls your rendering logic
  # @return [nil]
  def draw(&block)
    # src/mruby_integration/models/shader.cpp
    nil
  end

  # Is the Shader ready to be used?
  # @return [Boolean]
  def ready?
    # src/mruby_integration/models/shader.cpp
    True
  end
end
