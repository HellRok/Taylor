class Test
  class Models
    class Shader_Test < Test::Base
      def test_initialize
        Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 1))
        shader = Shader.new(fragment: "fragment.shader", vertex: "vertex.shader")

        assert_kind_of Shader, shader
        assert_equal 1, shader.id

        assert_called [
          "(FileExists) { fileName: 'fragment.shader' }",
          "(FileExists) { fileName: 'vertex.shader' }",
          "(LoadShader) { vsFileName: 'vertex.shader' fsFileName: 'fragment.shader' }"
        ]
      end

      def test_initialize_only_one
        Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 2))
        Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 3))
        fragment_shader = Shader.new(fragment: "fragment.shader")
        vertex_shader = Shader.new(vertex: "vertex.shader")

        assert_kind_of Shader, fragment_shader
        assert_equal 2, fragment_shader.id
        assert_kind_of Shader, vertex_shader
        assert_equal 3, vertex_shader.id

        assert_called [
          "(FileExists) { fileName: 'fragment.shader' }",
          "(LoadShader) { fsFileName: 'fragment.shader' }",
          "(FileExists) { fileName: 'vertex.shader' }",
          "(LoadShader) { vsFileName: 'vertex.shader' }"
        ]
      end

      def test_initialize_missing_file
        Taylor::Raylib.mock_call("FileExists", "false")
        Taylor::Raylib.mock_call("FileExists", "false")
        Taylor::Raylib.mock_call("FileExists", "false")
        Taylor::Raylib.mock_call("FileExists", "false")

        assert_raise_with_message(Shader::NotFoundError, "Unable to find './assets/fragment.fs'") {
          Shader.new(fragment: "./assets/fragment.fs")
        }

        assert_raise_with_message(Shader::NotFoundError, "Unable to find './assets/vertex.vs'") {
          Shader.new(vertex: "./assets/vertex.vs")
        }

        assert_raise_with_message(Shader::NotFoundError, "Unable to find './assets/fragment.fs' and './assets/vertex.vs'") {
          Shader.new(fragment: "./assets/fragment.fs", vertex: "./assets/vertex.vs")
        }

        assert_called [
          "(FileExists) { fileName: './assets/fragment.fs' }",
          "(FileExists) { fileName: './assets/vertex.vs' }",
          "(FileExists) { fileName: './assets/fragment.fs' }",
          "(FileExists) { fileName: './assets/vertex.vs' }"
        ]
      end

      def test_unload
        shader = Shader.new
        Taylor::Raylib.reset_calls

        shader.unload

        assert_called [
          "(UnloadShader) { shader: { id: 0 } }"
        ]
      end

      # def test_load_fragment_shader_from_string
      #   Shader.load(fragment_shader_code: "shader fragment code")

      #   assert_called [
      #     "(LoadShaderFromMemory) { fsCode: 'shader fragment code' }"
      #   ]
      # end

      # def test_load_vertex_shader_from_string
      #   Shader.load(vertex_shader_code: "vertex fragment code")

      #   assert_called [
      #     "(LoadShaderFromMemory) { vsCode: 'vertex fragment code' }"
      #   ]
      # end

      # def test_load_shader
      #   Shader.load(fragment_shader_path: "fragment shader path")

      #   assert_called [
      #     "(LoadShader) { fsFileName: 'fragment shader path' }"
      #   ]
      # end

      def test_shader_ready
        Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 1))
        Taylor::Raylib.mock_call("IsShaderReady", "true")
        Taylor::Raylib.mock_call("IsShaderReady", "false")
        shader = Shader.new
        Taylor::Raylib.reset_calls

        assert_true shader.ready?
        assert_false shader.ready?

        assert_called [
          "(IsShaderReady) { shader: { id: 1 } }",
          "(IsShaderReady) { shader: { id: 1 } }"
        ]
      end

      # def test_get_uniform_location
      #   Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 2))
      #   Taylor::Raylib.mock_call("GetShaderLocation", "-1")
      #   Taylor::Raylib.mock_call("GetShaderLocation", "3")

      #   shader = Shader.load(fragment_shader_path: "fragment shader path")
      #   Taylor::Raylib.reset_calls

      #   assert_nil shader.get_uniform_location("non_existant")
      #   assert_equal 3, shader.get_uniform_location("red")

      #   assert_called [
      #     "(GetShaderLocation) { shader: { id: 2 } uniformName: 'non_existant' }",
      #     "(GetShaderLocation) { shader: { id: 2 } uniformName: 'red' }"
      #   ]
      # end

      # def test_set_shader_value_no_variable_or_variable_location
      #   shader = Shader.load(fragment_shader_path: "fragment shader path")
      #   Taylor::Raylib.reset_calls

      #   assert_raise(ArgumentError) {
      #     shader.set_value(
      #       value: 0.0
      #     )
      #   }

      #   assert_no_calls
      # end

      # def test_set_shader_value_wrong_type
      #   Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 3))
      #   shader = Shader.load(fragment_shader_path: "fragment shader path")
      #   Taylor::Raylib.reset_calls

      #   assert_raise(ArgumentError) {
      #     shader.set_value(
      #       value: "green",
      #       variable: "red"
      #     )
      #   }

      #   assert_called [
      #     "(GetShaderLocation) { shader: { id: 3 } uniformName: 'red' }"
      #   ]
      # end

      # def test_set_shader_value_wrong_type_in_array
      #   Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 4))
      #   shader = Shader.load(fragment_shader_path: "fragment shader path")
      #   Taylor::Raylib.reset_calls

      #   assert_raise(ArgumentError) {
      #     shader.set_value(
      #       value: ["green"],
      #       variable: "red"
      #     )
      #   }

      #   assert_called [
      #     "(GetShaderLocation) { shader: { id: 4 } uniformName: 'red' }"
      #   ]
      # end

      # def test_set_shader_value_too_many_floats
      #   Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 5))
      #   shader = Shader.load(fragment_shader_path: "fragment shader path")
      #   Taylor::Raylib.reset_calls

      #   assert_raise(ArgumentError) {
      #     shader.set_value(
      #       value: [1.0, 1.0, 1.0, 1.0, 1.0],
      #       variable: "red"
      #     )
      #   }

      #   assert_called [
      #     "(GetShaderLocation) { shader: { id: 5 } uniformName: 'red' }"
      #   ]
      # end

      # def test_set_shader_value_too_few_floats
      #   Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 6))
      #   shader = Shader.load(fragment_shader_path: "fragment shader path")
      #   Taylor::Raylib.reset_calls

      #   assert_raise(ArgumentError) {
      #     shader.set_value(
      #       value: [1.0],
      #       variable: "red"
      #     )
      #   }

      #   assert_called [
      #     "(GetShaderLocation) { shader: { id: 6 } uniformName: 'red' }"
      #   ]
      # end

      # def test_set_shader_value_too_many_ints
      #   Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 7))
      #   shader = Shader.load(fragment_shader_path: "fragment shader path")
      #   Taylor::Raylib.reset_calls

      #   assert_raise(ArgumentError) {
      #     shader.set_value(
      #       value: [1, 1, 1, 1, 1],
      #       variable: "red"
      #     )
      #   }

      #   assert_called [
      #     "(GetShaderLocation) { shader: { id: 7 } uniformName: 'red' }"
      #   ]
      # end

      # def test_set_shader_value_too_few_ints
      #   Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 8))
      #   shader = Shader.load(fragment_shader_path: "fragment shader path")
      #   Taylor::Raylib.reset_calls

      #   assert_raise(ArgumentError) {
      #     shader.set_value(
      #       value: [1],
      #       variable: "red"
      #     )
      #   }

      #   assert_called [
      #     "(GetShaderLocation) { shader: { id: 8 } uniformName: 'red' }"
      #   ]
      # end

      # def test_set_shader_value_float
      #   Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 9))
      #   shader = Shader.load(fragment_shader_path: "fragment shader path")
      #   Taylor::Raylib.reset_calls

      #   shader.set_value(
      #     variable: "green",
      #     value: 0.4745
      #   )

      #   assert_called [
      #     "(GetShaderLocation) { shader: { id: 9 } uniformName: 'green' }",
      #     "(SetShaderValueV) { shader: { id: 9 } locIndex: 1 value: ???  uniformType: 0 count: 1 }"
      #   ]
      # end

      # def test_set_shader_value_vec2
      #   Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 10))
      #   shader = Shader.load(fragment_shader_path: "fragment shader path")
      #   Taylor::Raylib.reset_calls

      #   shader.set_value(
      #     variable: "vector",
      #     value: [0.1, 0.5]
      #   )

      #   assert_called [
      #     "(GetShaderLocation) { shader: { id: 10 } uniformName: 'vector' }",
      #     "(SetShaderValueV) { shader: { id: 10 } locIndex: 1 value: ???  uniformType: 1 count: 1 }"
      #   ]
      # end

      # def test_set_shader_value_vec3
      #   Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 11))
      #   shader = Shader.load(fragment_shader_path: "fragment shader path")
      #   Taylor::Raylib.reset_calls

      #   shader.set_value(
      #     variable: "vector",
      #     value: [0.1, 0.5, 0.75]
      #   )

      #   assert_called [
      #     "(GetShaderLocation) { shader: { id: 11 } uniformName: 'vector' }",
      #     "(SetShaderValueV) { shader: { id: 11 } locIndex: 1 value: ???  uniformType: 2 count: 1 }"
      #   ]
      # end

      # def test_set_shader_value_vec4
      #   Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 12))
      #   shader = Shader.load(fragment_shader_path: "fragment shader path")
      #   Taylor::Raylib.reset_calls

      #   shader.set_value(
      #     variable: "vector",
      #     value: [0.1, 0.5, 0.75, 1.0]
      #   )

      #   assert_called [
      #     "(GetShaderLocation) { shader: { id: 12 } uniformName: 'vector' }",
      #     "(SetShaderValueV) { shader: { id: 12 } locIndex: 1 value: ???  uniformType: 3 count: 1 }"
      #   ]
      # end

      # def test_set_shader_value_int
      #   Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 13))
      #   shader = Shader.load(fragment_shader_path: "fragment shader path")
      #   Taylor::Raylib.reset_calls

      #   shader.set_value(
      #     variable: "red",
      #     value: 1
      #   )

      #   assert_called [
      #     "(GetShaderLocation) { shader: { id: 13 } uniformName: 'red' }",
      #     "(SetShaderValueV) { shader: { id: 13 } locIndex: 1 value: ???  uniformType: 4 count: 1 }"
      #   ]
      # end

      # def test_set_shader_value_ivec2
      #   Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 14))
      #   shader = Shader.load(fragment_shader_path: "fragment shader path")
      #   Taylor::Raylib.reset_calls

      #   shader.set_value(
      #     variable: "vector",
      #     value: [0, 1]
      #   )

      #   assert_called [
      #     "(GetShaderLocation) { shader: { id: 14 } uniformName: 'vector' }",
      #     "(SetShaderValueV) { shader: { id: 14 } locIndex: 1 value: ???  uniformType: 5 count: 1 }"
      #   ]
      # end

      # def test_set_shader_value_ivec3
      #   Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 15))
      #   shader = Shader.load(fragment_shader_path: "fragment shader path")
      #   Taylor::Raylib.reset_calls

      #   shader.set_value(
      #     value: [0, 1, 1],
      #     variable: "vector"
      #   )

      #   assert_called [
      #     "(GetShaderLocation) { shader: { id: 15 } uniformName: 'vector' }",
      #     "(SetShaderValueV) { shader: { id: 15 } locIndex: 1 value: ???  uniformType: 6 count: 1 }"
      #   ]
      # end

      # def test_set_shader_value_ivec4
      #   Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 16))
      #   shader = Shader.load(fragment_shader_path: "fragment shader path")
      #   Taylor::Raylib.reset_calls

      #   shader.set_value(
      #     variable: "vector",
      #     value: [1, 0, 0, 1]
      #   )

      #   assert_called [
      #     "(GetShaderLocation) { shader: { id: 16 } uniformName: 'vector' }",
      #     "(SetShaderValueV) { shader: { id: 16 } locIndex: 1 value: ???  uniformType: 7 count: 1 }"
      #   ]
      # end

      # def test_set_shader_values_no_variable_or_variable_location
      #   shader = Shader.load(fragment_shader_path: "fragment shader path")
      #   Taylor::Raylib.reset_calls

      #   assert_raise(ArgumentError) {
      #     shader.set_values(
      #       values: 0.0
      #     )
      #   }

      #   assert_no_calls
      # end

      # def test_set_shader_values_wrong_type
      #   shader = Shader.load(fragment_shader_path: "fragment shader path")
      #   Taylor::Raylib.reset_calls

      #   assert_raise(ArgumentError) {
      #     shader.set_values(
      #       values: "green",
      #       variable: "red"
      #     )
      #   }

      #   assert_no_calls
      # end

      # def test_set_shader_values_wrong_type_in_array
      #   Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 17))
      #   shader = Shader.load(fragment_shader_path: "fragment shader path")
      #   Taylor::Raylib.reset_calls

      #   assert_raise(ArgumentError) {
      #     shader.set_values(
      #       values: ["green"],
      #       variable: "red"
      #     )
      #   }

      #   assert_called [
      #     "(GetShaderLocation) { shader: { id: 17 } uniformName: 'red' }"
      #   ]
      # end

      # def test_set_shader_values_too_many_floats
      #   Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 18))
      #   shader = Shader.load(fragment_shader_path: "fragment shader path")
      #   Taylor::Raylib.reset_calls

      #   assert_raise(ArgumentError) {
      #     shader.set_values(
      #       values: [[1.0, 1.0, 1.0, 1.0, 1.0]],
      #       variable: "red"
      #     )
      #   }

      #   assert_called [
      #     "(GetShaderLocation) { shader: { id: 18 } uniformName: 'red' }"
      #   ]
      # end

      # def test_set_shader_values_too_few_floats
      #   Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 19))
      #   shader = Shader.load(fragment_shader_path: "fragment shader path")
      #   Taylor::Raylib.reset_calls

      #   assert_raise(ArgumentError) {
      #     shader.set_values(
      #       values: [[1.0]],
      #       variable: "red"
      #     )
      #   }

      #   assert_called [
      #     "(GetShaderLocation) { shader: { id: 19 } uniformName: 'red' }"
      #   ]
      # end

      # def test_set_shader_values_too_many_ints
      #   Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 20))
      #   shader = Shader.load(fragment_shader_path: "fragment shader path")
      #   Taylor::Raylib.reset_calls

      #   assert_raise(ArgumentError) {
      #     shader.set_values(
      #       values: [[1, 1, 1, 1, 1]],
      #       variable: "red"
      #     )
      #   }

      #   assert_called [
      #     "(GetShaderLocation) { shader: { id: 20 } uniformName: 'red' }"
      #   ]
      # end

      # def test_set_shader_values_too_few_ints
      #   Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 21))
      #   shader = Shader.load(fragment_shader_path: "fragment shader path")
      #   Taylor::Raylib.reset_calls

      #   assert_raise(ArgumentError) {
      #     shader.set_values(
      #       values: [[1]],
      #       variable: "red"
      #     )
      #   }

      #   assert_called [
      #     "(GetShaderLocation) { shader: { id: 21 } uniformName: 'red' }"
      #   ]
      # end

      # def test_set_shader_values_float
      #   Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 22))
      #   shader = Shader.load(fragment_shader_path: "fragment shader path")
      #   Taylor::Raylib.reset_calls

      #   shader.set_values(
      #     variable: "green",
      #     values: [0.4745]
      #   )

      #   assert_called [
      #     "(GetShaderLocation) { shader: { id: 22 } uniformName: 'green' }",
      #     "(SetShaderValueV) { shader: { id: 22 } locIndex: 1 value: ???  uniformType: 0 count: 1 }"
      #   ]
      # end

      # def test_set_shader_values_vec2
      #   Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 23))
      #   shader = Shader.load(fragment_shader_path: "fragment shader path")
      #   Taylor::Raylib.reset_calls

      #   shader.set_values(
      #     variable: "vector",
      #     values: [[0.1, 0.5]]
      #   )

      #   assert_called [
      #     "(GetShaderLocation) { shader: { id: 23 } uniformName: 'vector' }",
      #     "(SetShaderValueV) { shader: { id: 23 } locIndex: 1 value: ???  uniformType: 1 count: 1 }"
      #   ]
      # end

      # def test_set_shader_values_vec3
      #   Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 24))
      #   shader = Shader.load(fragment_shader_path: "fragment shader path")
      #   Taylor::Raylib.reset_calls

      #   shader.set_values(
      #     variable: "vector",
      #     values: [[0.1, 0.5, 0.75]]
      #   )

      #   assert_called [
      #     "(GetShaderLocation) { shader: { id: 24 } uniformName: 'vector' }",
      #     "(SetShaderValueV) { shader: { id: 24 } locIndex: 1 value: ???  uniformType: 2 count: 1 }"
      #   ]
      # end

      # def test_set_shader_values_vec4
      #   Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 25))
      #   shader = Shader.load(fragment_shader_path: "fragment shader path")
      #   Taylor::Raylib.reset_calls

      #   shader.set_values(
      #     variable: "vector",
      #     values: [[0.1, 0.5, 0.75, 1.0]]
      #   )

      #   assert_called [
      #     "(GetShaderLocation) { shader: { id: 25 } uniformName: 'vector' }",
      #     "(SetShaderValueV) { shader: { id: 25 } locIndex: 1 value: ???  uniformType: 3 count: 1 }"
      #   ]
      # end

      # def test_set_shader_values_int
      #   Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 26))
      #   shader = Shader.load(fragment_shader_path: "fragment shader path")
      #   Taylor::Raylib.reset_calls

      #   shader.set_values(
      #     variable: "red",
      #     values: [1]
      #   )

      #   assert_called [
      #     "(GetShaderLocation) { shader: { id: 26 } uniformName: 'red' }",
      #     "(SetShaderValueV) { shader: { id: 26 } locIndex: 1 value: ???  uniformType: 4 count: 1 }"
      #   ]
      # end

      # def test_set_shader_values_ivec2
      #   Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 27))
      #   shader = Shader.load(fragment_shader_path: "fragment shader path")
      #   Taylor::Raylib.reset_calls

      #   shader.set_values(
      #     variable: "vector",
      #     values: [[0, 1]]
      #   )

      #   assert_called [
      #     "(GetShaderLocation) { shader: { id: 27 } uniformName: 'vector' }",
      #     "(SetShaderValueV) { shader: { id: 27 } locIndex: 1 value: ???  uniformType: 5 count: 1 }"
      #   ]
      # end

      # def test_set_shader_values_ivec3
      #   Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 28))
      #   shader = Shader.load(fragment_shader_path: "fragment shader path")
      #   Taylor::Raylib.reset_calls

      #   shader.set_values(
      #     values: [[0, 1, 1]],
      #     variable: "vector"
      #   )

      #   assert_called [
      #     "(GetShaderLocation) { shader: { id: 28 } uniformName: 'vector' }",
      #     "(SetShaderValueV) { shader: { id: 28 } locIndex: 1 value: ???  uniformType: 6 count: 1 }"
      #   ]
      # end

      # def test_set_shader_values_ivec4
      #   Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 29))
      #   shader = Shader.load(fragment_shader_path: "fragment shader path")
      #   Taylor::Raylib.reset_calls

      #   shader.set_values(
      #     variable: "vector",
      #     values: [[1, 0, 0, 1]]
      #   )

      #   assert_called [
      #     "(GetShaderLocation) { shader: { id: 29 } uniformName: 'vector' }",
      #     "(SetShaderValueV) { shader: { id: 29 } locIndex: 1 value: ???  uniformType: 7 count: 1 }"
      #   ]
      # end
    end
  end
end
