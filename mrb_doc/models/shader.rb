class Shader
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
end
