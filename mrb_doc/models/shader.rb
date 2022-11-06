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

  def id=(id)
    # mrb_Shader_set_id
    # src/mruby_integration/models/shader.cpp
    0
  end

  # Instead of rending straight to the screen, render through this Shader first
  # @yield The block that calls your rendering logic
  # @return [nil]
  def draw(&block)
    # src/mruby_integration/models/shader.cpp
    nil
  end
end
