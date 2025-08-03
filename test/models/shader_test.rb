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

      def test_load_code
        Taylor::Raylib.mock_call("LoadShaderFromMemory", Shader.mock_return(id: 5))
        shader = Shader.load_code(fragment: "fragment shader code", vertex: "vertex shader code")

        assert_kind_of Shader, shader
        assert_equal 5, shader.id

        assert_called [
          "(LoadShaderFromMemory) { vsCode: 'vertex shader code' fsCode: 'fragment shader code' }"
        ]
      end

      def test_load_code_only_one
        Taylor::Raylib.mock_call("LoadShaderFromMemory", Shader.mock_return(id: 6))
        Taylor::Raylib.mock_call("LoadShaderFromMemory", Shader.mock_return(id: 7))
        fragment_shader = Shader.load_code(fragment: "fragment shader code")
        vertex_shader = Shader.load_code(vertex: "vertex shader code")

        assert_kind_of Shader, fragment_shader
        assert_equal 6, fragment_shader.id
        assert_kind_of Shader, vertex_shader
        assert_equal 7, vertex_shader.id

        assert_called [
          "(LoadShaderFromMemory) { fsCode: 'fragment shader code' }",
          "(LoadShaderFromMemory) { vsCode: 'vertex shader code' }"
        ]
      end

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

      def test_location_of
        Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 8))
        Taylor::Raylib.mock_call("GetShaderLocation", "-1")
        Taylor::Raylib.mock_call("GetShaderLocation", "3")

        shader = Shader.new
        Taylor::Raylib.reset_calls

        assert_nil shader.location_of("non_existant")
        assert_equal 3, shader.location_of("red")

        assert_called [
          "(GetShaderLocation) { shader: { id: 8 } uniformName: 'non_existant' }",
          "(GetShaderLocation) { shader: { id: 8 } uniformName: 'red' }"
        ]
      end

      def test_set_value_wrong_type
        shader = Shader.new(fragment: "fragment shader path")
        Taylor::Raylib.reset_calls

        assert_raise_with_message(ArgumentError, "Value must be either an Integer, Float, or Array") {
          shader.set(
            location: 1,
            value: "green"
          )
        }

        assert_no_calls
      end

      def test_set_values_wrong_type
        shader = Shader.new(fragment: "fragment shader path")
        Taylor::Raylib.reset_calls

        assert_raise_with_message(ArgumentError, "Values must be an Array") {
          shader.set(
            location: 1,
            values: "green"
          )
        }

        assert_no_calls
      end

      def test_set_by_location
        Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 9))
        shader = Shader.new(fragment: "fragment shader path")
        Taylor::Raylib.reset_calls

        shader.set(
          location: 1,
          value: 0.4745
        )

        assert_called [
          "(SetShaderValueV) { shader: { id: 9 } locIndex: 1 value: ???  uniformType: 0 count: 1 }"
        ]
      end

      def test_set_by_variable
        Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 10))
        Taylor::Raylib.mock_call("GetShaderLocation", "2")
        shader = Shader.new(fragment: "fragment shader path")
        Taylor::Raylib.reset_calls

        shader.set(
          variable: "green",
          value: 1
        )

        assert_called [
          "(GetShaderLocation) { shader: { id: 10 } uniformName: 'green' }",
          "(SetShaderValueV) { shader: { id: 10 } locIndex: 2 value: ???  uniformType: 4 count: 1 }"
        ]
      end

      def test_set_by_location_and_variable
        shader = Shader.new(fragment: "fragment shader path")
        Taylor::Raylib.reset_calls

        assert_raise_with_message(ArgumentError, "Can't pass both 'location' and 'variable'") {
          shader.set(
            location: 1,
            variable: "green",
            value: 0.4745
          )
        }

        assert_no_calls
      end

      def test_set_no_variable_or_location
        shader = Shader.new(fragment: "fragment shader path")
        Taylor::Raylib.reset_calls

        assert_raise_with_message(ArgumentError, "Must pass either 'location' or 'variable'") {
          shader.set(value: 0.0)
        }

        assert_no_calls
      end

      def test_set_both_value_and_values
        shader = Shader.new(fragment: "fragment shader path")
        Taylor::Raylib.reset_calls

        assert_raise_with_message(ArgumentError, "Can't pass both 'value' and 'values'") {
          shader.set(
            location: 1,
            value: 0.4745,
            values: [1, 2]
          )
        }

        assert_no_calls
      end

      def test_set_no_value_or_values
        shader = Shader.new(fragment: "fragment shader path")
        Taylor::Raylib.reset_calls

        assert_raise_with_message(ArgumentError, "Must pass either 'value' or 'values'") {
          shader.set(location: 1)
        }

        assert_no_calls
      end

      def test_set_non_existant_variable
        Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 11))
        Taylor::Raylib.mock_call("GetShaderLocation", "-1")
        shader = Shader.new(fragment: "fragment shader path")
        Taylor::Raylib.reset_calls

        assert_raise_with_message(ArgumentError, "Couldn't locate variable 'non-existant'") {
          shader.set(
            variable: "non-existant",
            value: 0.4745
          )
        }

        assert_called [
          "(GetShaderLocation) { shader: { id: 11 } uniformName: 'non-existant' }"
        ]
      end

      def test_set_all_value_types
        Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 10))
        shader = Shader.new(fragment: "fragment shader path")
        Taylor::Raylib.reset_calls

        shader.set(location: 1, value: 0.0)
        assert_called ["(SetShaderValueV) { shader: { id: 10 } locIndex: 1 value: ???  uniformType: 0 count: 1 }"]

        shader.set(location: 2, value: [0.1, 0.2])
        assert_called ["(SetShaderValueV) { shader: { id: 10 } locIndex: 2 value: ???  uniformType: 1 count: 1 }"]

        shader.set(location: 3, value: [0.3, 0.4, 0.5])
        assert_called ["(SetShaderValueV) { shader: { id: 10 } locIndex: 3 value: ???  uniformType: 2 count: 1 }"]

        shader.set(location: 4, value: [0.6, 0.7, 0.8, 0.9])
        assert_called ["(SetShaderValueV) { shader: { id: 10 } locIndex: 4 value: ???  uniformType: 3 count: 1 }"]

        shader.set(location: 5, value: 1)
        assert_called ["(SetShaderValueV) { shader: { id: 10 } locIndex: 5 value: ???  uniformType: 4 count: 1 }"]

        shader.set(location: 6, value: [2, 3])
        assert_called ["(SetShaderValueV) { shader: { id: 10 } locIndex: 6 value: ???  uniformType: 5 count: 1 }"]

        shader.set(location: 7, value: [4, 5, 6])
        assert_called ["(SetShaderValueV) { shader: { id: 10 } locIndex: 7 value: ???  uniformType: 6 count: 1 }"]

        shader.set(location: 8, value: [7, 8, 9, 10])
        assert_called ["(SetShaderValueV) { shader: { id: 10 } locIndex: 8 value: ???  uniformType: 7 count: 1 }"]
      end

      def test_set_all_values_types
        Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 10))
        shader = Shader.new(fragment: "fragment shader path")
        Taylor::Raylib.reset_calls

        shader.set(location: 9, values: [0.0, 0.1])
        assert_called ["(SetShaderValueV) { shader: { id: 10 } locIndex: 9 value: ???  uniformType: 0 count: 2 }"]

        shader.set(location: 10, values: [[0.1, 0.2], [0.3, 0.4]])
        assert_called ["(SetShaderValueV) { shader: { id: 10 } locIndex: 10 value: ???  uniformType: 1 count: 2 }"]

        shader.set(location: 11, values: [[0.3, 0.4, 0.5], [0.6, 0.7, 0.8]])
        assert_called ["(SetShaderValueV) { shader: { id: 10 } locIndex: 11 value: ???  uniformType: 2 count: 2 }"]

        shader.set(location: 12, values: [[0.6, 0.7, 0.8, 0.9], [0.10, 0.11, 0.12, 0.13]])
        assert_called ["(SetShaderValueV) { shader: { id: 10 } locIndex: 12 value: ???  uniformType: 3 count: 2 }"]

        shader.set(location: 13, values: [1, 2])
        assert_called ["(SetShaderValueV) { shader: { id: 10 } locIndex: 13 value: ???  uniformType: 4 count: 2 }"]

        shader.set(location: 14, values: [[2, 3], [4, 5]])
        assert_called ["(SetShaderValueV) { shader: { id: 10 } locIndex: 14 value: ???  uniformType: 5 count: 2 }"]

        shader.set(location: 15, values: [[4, 5, 6], [7, 8, 9]])
        assert_called ["(SetShaderValueV) { shader: { id: 10 } locIndex: 15 value: ???  uniformType: 6 count: 2 }"]

        shader.set(location: 16, values: [[7, 8, 9, 10], [11, 12, 13, 14]])
        assert_called ["(SetShaderValueV) { shader: { id: 10 } locIndex: 16 value: ???  uniformType: 7 count: 2 }"]
      end

      def test_set_many_values
        Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 11))
        shader = Shader.new(fragment: "fragment shader path")
        Taylor::Raylib.reset_calls

        values = []
        100.times { values << [1, 2] }

        shader.set(location: 15, values: values)
        assert_called ["(SetShaderValueV) { shader: { id: 11 } locIndex: 15 value: ???  uniformType: 5 count: 100 }"]
      end

      def test_set_shader_values_too_many_floats
        Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 12))
        shader = Shader.new(fragment: "fragment shader path")
        Taylor::Raylib.reset_calls

        assert_raise_with_message(ArgumentError, "Passed 5 floats, you must pass no more than 4") {
          shader.set(
            location: 1,
            values: [[1.0, 1.0, 1.0, 1.0, 1.0]]
          )
        }

        assert_no_calls
      end

      def test_set_shader_values_too_few_floats
        Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 13))
        shader = Shader.new(fragment: "fragment shader path")
        Taylor::Raylib.reset_calls

        assert_raise_with_message(ArgumentError, "Passed 1 floats, you must pass at least 2") {
          shader.set(
            location: 1,
            values: [[1.0]]
          )
        }

        assert_no_calls
      end

      def test_set_shader_values_variable_length_floats
        Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 13))
        shader = Shader.new(fragment: "fragment shader path")
        Taylor::Raylib.reset_calls

        assert_raise_with_message(ArgumentError, "All arrays must be the same length") {
          shader.set(
            location: 1,
            values: [
              [1.0, 1.0],
              [1.0, 1.0, 1.0]
            ]
          )
        }

        assert_raise_with_message(ArgumentError, "All arrays must be the same length") {
          shader.set(
            location: 1,
            values: [
              [1.0, 1.0, 1.0],
              [1.0, 1.0]
            ]
          )
        }

        assert_no_calls
      end

      def test_set_shader_values_too_many_integers
        Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 12))
        shader = Shader.new(fragment: "fragment shader path")
        Taylor::Raylib.reset_calls

        assert_raise_with_message(ArgumentError, "Passed 5 integers, you must pass no more than 4") {
          shader.set(
            location: 1,
            values: [[1, 1, 1, 1, 1]]
          )
        }

        assert_no_calls
      end

      def test_set_shader_values_too_few_integers
        Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 13))
        shader = Shader.new(fragment: "fragment shader path")
        Taylor::Raylib.reset_calls

        assert_raise_with_message(ArgumentError, "Passed 1 integers, you must pass at least 2") {
          shader.set(
            location: 1,
            values: [[1]]
          )
        }

        assert_no_calls
      end

      def test_set_shader_values_variable_length_integers
        Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 13))
        shader = Shader.new(fragment: "fragment shader path")
        Taylor::Raylib.reset_calls

        assert_raise_with_message(ArgumentError, "All arrays must be the same length") {
          shader.set(
            location: 1,
            values: [
              [1, 1],
              [1, 1, 1]
            ]
          )
        }

        assert_raise_with_message(ArgumentError, "All arrays must be the same length") {
          shader.set(
            location: 1,
            values: [
              [1, 1, 1],
              [1, 1]
            ]
          )
        }

        assert_no_calls
      end

      def test_set_shader_values_mixed_types
        Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 13))
        shader = Shader.new(fragment: "fragment shader path")
        Taylor::Raylib.reset_calls

        assert_raise_with_message(ArgumentError, "Must be all integers or all floats") {
          shader.set(
            location: 1,
            values: [
              [1.0, 1.0],
              [1.0, 1]
            ]
          )
        }

        assert_raise_with_message(ArgumentError, "Must be all integers or all floats") {
          shader.set(
            location: 1,
            values: [
              [1, 1.0],
              [1.0, 1.0]
            ]
          )
        }

        assert_raise_with_message(ArgumentError, "Must be all integers or all floats") {
          shader.set(
            location: 1,
            values: [
              [1, 1],
              [1.0, 1.0]
            ]
          )
        }

        assert_raise_with_message(ArgumentError, "Must be all integers or all floats") {
          shader.set(
            location: 1,
            values: [
              [1, 1],
              1.0
            ]
          )
        }

        assert_raise_with_message(ArgumentError, "Must be all integers or all floats") {
          shader.set(
            location: 1,
            values: [
              [1, "green"]
            ]
          )
        }

        assert_raise_with_message(ArgumentError, "Must be all integers or all floats") {
          shader.set(
            location: 1,
            values: [
              [1.0, "green"]
            ]
          )
        }

        assert_no_calls
      end

      def test_draw
        Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 14))
        shader = Shader.new(fragment: "fragment shader path")
        Taylor::Raylib.reset_calls

        shader.draw do
          Window.clear(colour: Colour[1, 0, 0, 0])
        end

        assert_called [
          "(BeginShaderMode) { shader: { id: 14 } }",
          "(IsWindowReady) { }",
          "(ClearBackground) { color: { r: 1 g: 0 b: 0 a: 0 } }",
          "(EndShaderMode) { }"
        ]
      end

      def test_draw_with_error
        Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 15))
        shader = Shader.new(fragment: "fragment shader path")
        Taylor::Raylib.reset_calls

        begin
          shader.draw do
            Window.clear(colour: Colour[2, 0, 0, 0])
            raise StandardError, "Oops!"
            Window.clear(colour: Colour[3, 0, 0, 0]) # standard:disable Lint/UnreachableCode
          end
        rescue => error
          assert_equal "Oops!", error.message
        end

        assert_called [
          "(BeginShaderMode) { shader: { id: 15 } }",
          "(IsWindowReady) { }",
          "(ClearBackground) { color: { r: 2 g: 0 b: 0 a: 0 } }",
          "(EndShaderMode) { }"
        ]
      end

      def test_begin_drawing
        Taylor::Raylib.mock_call("LoadShader", Shader.mock_return(id: 16))
        shader = Shader.new(fragment: "fragment shader path")
        Taylor::Raylib.reset_calls

        shader.begin_drawing

        assert_called [
          "(BeginShaderMode) { shader: { id: 16 } }"
        ]
      end

      def test_end_drawing
        shader = Shader.new(fragment: "fragment shader path")
        Taylor::Raylib.reset_calls

        shader.end_drawing

        assert_called [
          "(EndShaderMode) { }"
        ]
      end
    end
  end
end
