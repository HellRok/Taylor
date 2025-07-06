class Shader
  # @return [Integer]
  attr_reader :id

  # Loads a vertex and/or fragment {Shader} file from the disk. If either file
  # does not exist, it will raise a {Shader::NotFoundError} error.
  #
  # @example Basic usage
  #   shader = Shader.new(
  #     fragment: "assets/fragment_shader_#{GLSL_VERSION}.fs",
  #     vertex: "assets/vertex_shader_#{GLSL_VERSION}.vs",
  #   )
  #
  #   fragment_shader = Shader.new(fragment: "assets/fragment_shader_#{GLSL_VERSION}.fs")
  #   vertex_shader = Shader.new(vertex: "assets/vertex_shader_#{GLSL_VERSION}.vs")
  #
  # @param fragment [String]
  # @param vertex [String]
  # @return [Shader]
  # @raise [Shader::NotFoundError]
  def initialize(fragment:, vertex:)
    # mrb_Shader_initialize
    # src/mruby_integration/models/shader.cpp
    Shader.new
  end

  # Unloads the Shader from memory.
  #
  # @example Basic usage
  #   shader = Shader.new(fragment: "assets/fragment_shader_#{GLSL_VERSION}.fs")
  #   shader.unload
  #
  # @return [nil]
  def unload
    # mrb_Shader_unload
    # src/mruby_integration/models/shader.cpp
    nil
  end

  # Is the Shader ready to be used?
  #
  # @example Basic usage
  #   shader = Shader.new(fragment: "assets/fragment_shader_#{GLSL_VERSION}.fs")
  #   puts shader.ready? #=> true
  #   shader.unload
  #
  # @return [Boolean]
  def ready?
    # mrb_Shader_ready
    # src/mruby_integration/models/shader.cpp
    true
  end
end
