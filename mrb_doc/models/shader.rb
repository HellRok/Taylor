class Shader
  # @return [Integer]
  attr_writer :id

  # Creates a new instance of {Shader}.
  # @param id [Integer]
  # @return [Shader]
  def initialize(id)
    # mrb_Shader_initialize
    # src/mruby_integration/models/shader.cpp
    Shader.new
  end
end
