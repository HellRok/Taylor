class Shader
  # @return [Integer]
  attr_reader :id

  # Loads a {Shader} from a String that contains the code.
  #
  # @example Basic usage
  #   shader = Shader.load_code(fragment: <<~CODE)
  #     #version 100
  #
  #     precision mediump float;
  #
  #     uniform float red;
  #     uniform float green;
  #     uniform float blue;
  #
  #     void main() {
  #       gl_FragColor = vec4(red, green, blue, 1.0);
  #     }
  #   CODE
  #
  # @param fragment [String]
  # @param vertex [String]
  # @return [Shader]
  def self.load_code(fragment: nil, vertex: nil)
    # mrb_Shader_load_code
    # src/mruby_integration/models/shaders.cpp
    Shader.new
  end

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

  # Is the Shader valid?
  #
  # @example Basic usage
  #   shader = Shader.new(fragment: "assets/fragment_shader_#{GLSL_VERSION}.fs")
  #   puts shader.valid? #=> true
  #   shader.unload
  #
  # @return [Boolean]
  def valid?
    # mrb_Shader_valid
    # src/mruby_integration/models/shader.cpp
    true
  end

  # Returns the location of uniform variable, will return nil if not found.
  #
  # @example Basic usage
  #   shader = Shader.new(fragment: "assets/fragment_shader_#{GLSL_VERSION}.fs")
  #   puts shader.location_of("red") #=> 1
  #   puts shader.location_of("not_a_variable") #=> nil
  #   shader.unload
  #
  # @param variable [String]
  # @return [nil, Integer]
  def location_of(variable)
    # mrb_Shader_location_of
    # src/mruby_integration/models/shader.cpp
    1
  end

  # Updates the variable inside the shader with the passed in value/values.
  #
  # @example Basic usage
  #   raise "Only for the browser!" unless Taylor::Platform.browser?
  #
  #   shader = Shader.load_code(fragment: <<~CODE)
  #     #version 100
  #
  #     precision mediump float;
  #
  #     uniform float red;
  #     uniform float green;
  #     uniform float blue;
  #
  #     void main() {
  #       gl_FragColor = vec4(red, green, blue, 1.0);
  #     }
  #   CODE
  #
  #   # Make it purple!
  #   shader.set(variable: "red", value: 1.0)
  #   shader.set(variable: "green", value: 0.0)
  #   shader.set(variable: "blue", value: 0.75)
  #
  #   shader.unload
  #
  # @example Basic usage with an `ivec4`
  #   raise "Only for the browser!" unless Taylor::Platform.browser?
  #
  #   shader = Shader.load_code(fragment: <<~CODE)
  #     #version 100
  #
  #     precision mediump float;
  #
  #     uniform ivec4 colour;
  #
  #     void main() {
  #       gl_FragColor = vec4(colour);
  #     }
  #   CODE
  #
  #   # Make it purple!
  #   shader.set(variable: "colour", value: [1.0, 0.0, 0.75, 1.0])
  #
  #   shader.unload
  #
  # @example Basic usage with multiple values
  #   raise "Only for the browser!" unless Taylor::Platform.browser?
  #
  #   shader = Shader.load_code(fragment: <<~CODE)
  #     #version 100
  #
  #     precision mediump float;
  #
  #     uniform ivec4 palettes[4];
  #     uniform int current_palette;
  #
  #     void main() {
  #       gl_FragColor = vec4(palettes[current_palette]);
  #     }
  #   CODE
  #
  #   shader.set(variable: "palettes", values: [
  #     [1.0, 0.0, 0.7, 1.0],
  #     [1.0, 1.0, 0.0, 1.0],
  #     [0.0, 0.0, 1.0, 1.0],
  #     [0.8, 1.0, 0.7, 1.0],
  #   )
  #   shader.set(variable: "current_palette", value: 0)
  #
  #   shader.unload
  #
  # @param variable [String] The variable to update
  # @param location [Integer] The location of the variable to update according to {Shader#location_of}
  # @param value [Int,Float,Array[2..4]<Int,Float>]
  # @param values [Array<Int,Float,Array[2..4]<Int,Float>>]
  # @return [nil]
  # @raise [ArgumentError] If you pass in both `variable` and `location`
  # @raise [ArgumentError] If you pass in neither `variable` and `location`
  # @raise [ArgumentError] If you pass in both `value` and `values`
  # @raise [ArgumentError] If you pass in neither `value` and `values`
  # @raise [ArgumentError] If `variable` is not found within the {Shader}
  def set(variable: nil, location: nil, value: nil, values: [])
    # mrb_Shader_set
    # src/mruby_integration/shaders.cpp
    nil
  end

  # Apply the {Shader} to everything drawn until {Shader#end_drawing} is called.
  #
  # @example Basic usage
  #   shader = Shader.new(fragment: "./my/cool/shader.fs")
  #
  #   shader.begin_drawing
  #   begin
  #     # Drawing code here
  #   ensure
  #     shader.end_drawing
  #   end
  #
  # @return [nil]
  def begin_drawing
    # mrb_Shader_begin_drawing
    # src/mruby_integration/models/shader.cpp
    nil
  end

  # Apply the {Shader} to everything drawn from calling {Shader#begin_drawing}.
  #
  # @example Basic usage
  #   shader = Shader.new(fragment: "./my/cool/shader.fs")
  #
  #   shader.begin_drawing
  #   begin
  #     # Drawing code here
  #   ensure
  #     shader.end_drawing
  #   end
  #
  # @return [nil]
  def end_drawing
    # mrb_Shader_end_drawing
    # src/mruby_integration/models/shader.cpp
    nil
  end
end
