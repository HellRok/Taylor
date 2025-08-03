# The Shader class is for doing operations on the GPU.
class Shader
  # Loads a Shader from either paths or code, but not both at once.
  # @param vertex_shader_path [String]
  # @param fragment_shader_path [String]
  # @param vertex_shader_code [String]
  # @param fragment_shader_code [String]
  # @return [Shader]
  # @raise [ArgumentError]
  def self.load(vertex_shader_path: nil, fragment_shader_path: nil, vertex_shader_code: nil, fragment_shader_code: nil)
    unless vertex_shader_path || fragment_shader_path || vertex_shader_code || fragment_shader_code
      raise ArgumentError, "You can only specify paths or code, not both"
    end

    if (vertex_shader_path || fragment_shader_path) && (vertex_shader_code || fragment_shader_code)
      raise ArgumentError, "You can only specify paths or code, not both"
    end

    if vertex_shader_path || fragment_shader_path
      load_shader(vertex_shader_path, fragment_shader_path)
    elsif vertex_shader_code || fragment_shader_code
      load_shader_from_string(vertex_shader_code, fragment_shader_code)
    end
  end

  # Apply the {Shader} to everything drawn in the block.
  #
  # @example Basic usage
  #   shader = Shader.new(fragment: "./my/cool/shader.fs")
  #
  #   shader.draw
  #     # Drawing code here
  #   end
  #
  # @return [nil]
  def draw(&block)
    begin_drawing
    block.call
  ensure
    end_drawing
  end

  # A method used to generate the mock data for Raylib.
  #
  # @example Basic usage
  #   Taylor::Raylib.mock_call(
  #     "LoadShader",
  #     Shader.mock_return(id: 1)
  #   )
  #
  # @param id [Integer]
  # @return [String]
  def self.mock_return(id: 1)
    id.to_s
  end

  # Used for alerting the user if the {Shader} was not found at the specified path.
  class NotFoundError < StandardError; end
end
