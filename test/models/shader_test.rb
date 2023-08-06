class Test
  class Models
    class Shader_Test < MTest::Unit::TestCaseWithAnalytics
      def test_initialize
        shader = Shader.new(1)

        assert_kind_of Shader, shader
        assert_equal 1, shader.id
      end

      def test_assignment
        shader = Shader.new(0)
        shader.id = 5

        assert_equal 5, shader.id

      end

      def test_load_argument_errors
        skip_unless_display_present

        set_window_title(__method__.to_s)

        assert_raise(ArgumentError) { Shader.load() }

        assert_raise(ArgumentError) { Shader.load(fragment_shader_path: "path", vector_shader_code: "code") }
        assert_raise(ArgumentError) { Shader.load(fragment_shader_path: "path", fragment_shader_code: "code") }
        assert_raise(ArgumentError) { Shader.load(vector_shader_path: "path", fragment_shader_code: "code") }
        assert_raise(ArgumentError) { Shader.load(vector_shader_path: "path", vector_shader_code: "code") }
      end

      def test_shader_ready
        skip_unless_display_present

        set_window_title(__method__.to_s)

        shader = Shader.load(fragment_shader_path: "assets/fragment_shader_#{GLSL_VERSION}.fs")

        assert_true shader.ready?

        shader.unload
      end

      def test_get_uniform_location
        skip_unless_display_present
        set_window_title(__method__.to_s)

        shader = Shader.load(fragment_shader_path: "assets/uniform_shader_float_#{GLSL_VERSION}.fs")

        assert_nil shader.get_uniform_location('non_existant')

        if GLSL_VERSION == 330
          assert_equal 1, shader.get_uniform_location('red')
          assert_equal 2, shader.get_uniform_location('green')
          assert_equal 3, shader.get_uniform_location('blue')
        elsif GLSL_VERSION == 100
          assert_equal 2, shader.get_uniform_location('red')
          assert_equal 3, shader.get_uniform_location('green')
          assert_equal 4, shader.get_uniform_location('blue')
        else
          raise "Unexpected GLSL_VERSION"
        end

        shader.unload
      end

      def test_set_shader_value_no_variable_or_variable_location
        skip_unless_display_present
        set_window_title(__method__.to_s)

        shader = Shader.load(fragment_shader_path: "assets/uniform_shader_float_#{GLSL_VERSION}.fs")

        assert_raise(ArgumentError) {
          shader.set_value(
            value: 0.0,
          )
        }
      end

      def test_set_shader_value_wrong_type
        skip_unless_display_present
        set_window_title(__method__.to_s)

        shader = Shader.load(fragment_shader_path: "assets/uniform_shader_float_#{GLSL_VERSION}.fs")

        assert_raise(ArgumentError) {
          shader.set_value(
            value: "green",
            variable: 'red',
          )
        }
      end

      def test_set_shader_value_wrong_type_in_array
        skip_unless_display_present
        set_window_title(__method__.to_s)

        shader = Shader.load(fragment_shader_path: "assets/uniform_shader_float_#{GLSL_VERSION}.fs")

        assert_raise(ArgumentError) {
          shader.set_value(
            value: ["green"],
            variable: 'red',
          )
        }
      end

      def test_set_shader_value_too_many_floats
        skip_unless_display_present
        set_window_title(__method__.to_s)

        shader = Shader.load(fragment_shader_path: "assets/uniform_shader_float_#{GLSL_VERSION}.fs")

        assert_raise(ArgumentError) {
          shader.set_value(
            value: [1.0, 1.0, 1.0, 1.0, 1.0],
            variable: 'red',
          )
        }
      end

      def test_set_shader_value_too_few_floats
        skip_unless_display_present
        set_window_title(__method__.to_s)

        shader = Shader.load(fragment_shader_path: "assets/uniform_shader_float_#{GLSL_VERSION}.fs")

        assert_raise(ArgumentError) {
          shader.set_value(
            value: [1.0],
            variable: 'red',
          )
        }
      end

      def test_set_shader_value_too_many_ints
        skip_unless_display_present
        set_window_title(__method__.to_s)

        shader = Shader.load(fragment_shader_path: "assets/uniform_shader_float_#{GLSL_VERSION}.fs")

        assert_raise(ArgumentError) {
          shader.set_value(
            value: [1, 1, 1, 1, 1],
            variable: 'red',
          )
        }
      end

      def test_set_shader_value_too_few_ints
        skip_unless_display_present
        set_window_title(__method__.to_s)

        shader = Shader.load(fragment_shader_path: "assets/uniform_shader_float_#{GLSL_VERSION}.fs")

        assert_raise(ArgumentError) {
          shader.set_value(
            value: [1],
            variable: 'red',
          )
        }
      end

      def test_set_shader_value_float
        skip_unless_display_present
        set_window_title(__method__.to_s)

        shader = Shader.load(fragment_shader_path: "assets/uniform_shader_float_#{GLSL_VERSION}.fs")

        shader.set_value(
          value: 0.0,
          variable: 'red',
        )

        shader.set_value(
          variable: 'green',
          value: 0.4745,
        )

        shader.set_value(
          variable: 'blue',
          value: 0.94509,
        )

        clear_and_draw do
          shader.draw do
            Rectangle.new(0, 0, 10, 10).draw(colour: RED)
          end
        end
        flush_frames(2)

        assert_equal fixture_set_shader_values_float, get_screen_data.data

        shader.unload
      end

      def test_set_shader_value_vec2
        skip_unless_display_present
        set_window_title(__method__.to_s)

        shader = Shader.load(fragment_shader_path: "assets/uniform_shader_vec2_#{GLSL_VERSION}.fs")

        shader.set_value(
          variable: 'vector',
          value: [0.1, 0.5],
        )

        clear_and_draw do
          shader.draw do
            Rectangle.new(0, 0, 10, 10).draw(colour: RED)
          end
        end
        flush_frames(2)

        assert_equal fixture_set_shader_values_vec2, get_screen_data.data

        shader.unload
      end

      def test_set_shader_value_vec3
        skip_unless_display_present
        set_window_title(__method__.to_s)

        shader = Shader.load(fragment_shader_path: "assets/uniform_shader_vec3_#{GLSL_VERSION}.fs")

        shader.set_value(
          variable: 'vector',
          value: [0.1, 0.5, 0.75],
        )

        clear_and_draw do
          shader.draw do
            Rectangle.new(0, 0, 10, 10).draw(colour: RED)
          end
        end
        flush_frames(2)

        assert_equal fixture_set_shader_values_vec3, get_screen_data.data

        shader.unload
      end

      def test_set_shader_value_vec4
        skip_unless_display_present
        set_window_title(__method__.to_s)

        shader = Shader.load(fragment_shader_path: "assets/uniform_shader_vec4_#{GLSL_VERSION}.fs")

        shader.set_value(
          variable: 'vector',
          value: [0.1, 0.5, 0.75, 1.0],
        )

        clear_and_draw do
          shader.draw do
            Rectangle.new(0, 0, 10, 10).draw(colour: RED)
          end
        end
        flush_frames(2)

        assert_equal fixture_set_shader_values_vec4, get_screen_data.data

        shader.unload
      end

      def test_set_shader_value_int
        skip_unless_display_present
        set_window_title(__method__.to_s)

        shader = Shader.load(fragment_shader_path: "assets/uniform_shader_int_#{GLSL_VERSION}.fs")

        shader.set_value(
          variable: 'red',
          value: 1,
        )

        shader.set_value(
          variable: 'green',
          value: 0,
        )

        shader.set_value(
          variable: 'blue',
          value: 1,
        )

        clear_and_draw do
          shader.draw do
            Rectangle.new(0, 0, 10, 10).draw(colour: RED)
          end
        end
        flush_frames(2)

        assert_equal fixture_set_shader_values_int, get_screen_data.data

        shader.unload
      end

      def test_set_shader_value_ivec2
        skip_unless_display_present
        set_window_title(__method__.to_s)

        shader = Shader.load(fragment_shader_path: "assets/uniform_shader_ivec2_#{GLSL_VERSION}.fs")

        shader.set_value(
          variable: 'vector',
          value: [0, 1],
        )

        clear_and_draw do
          shader.draw do
            Rectangle.new(0, 0, 10, 10).draw(colour: RED)
          end
        end
        flush_frames(2)

        assert_equal fixture_set_shader_values_ivec2, get_screen_data.data

        shader.unload
      end

      def test_set_shader_value_ivec3
        skip_unless_display_present
        set_window_title(__method__.to_s)

        shader = Shader.load(fragment_shader_path: "assets/uniform_shader_ivec3_#{GLSL_VERSION}.fs")

        shader.set_value(
          value: [0, 1, 1],
          variable: 'vector',
        )

        clear_and_draw do
          shader.draw do
            Rectangle.new(0, 0, 10, 10).draw(colour: RED)
          end
        end
        flush_frames(2)

        assert_equal fixture_set_shader_values_ivec3, get_screen_data.data

        shader.unload
      end

      def test_set_shader_value_ivec4
        skip_unless_display_present
        set_window_title(__method__.to_s)

        shader = Shader.load(fragment_shader_path: "assets/uniform_shader_ivec4_#{GLSL_VERSION}.fs")

        shader.set_value(
          variable: 'vector',
          value: [1, 0, 0, 1],
        )

        clear_and_draw do
          shader.draw do
            Rectangle.new(0, 0, 10, 10).draw(colour: RED)
          end
        end
        flush_frames(2)

        assert_equal fixture_set_shader_values_ivec4, get_screen_data.data

        shader.unload
      end

      def test_set_shader_values_no_variable_or_variable_location
        skip_unless_display_present
        set_window_title(__method__.to_s)

        shader = Shader.load(fragment_shader_path: "assets/uniform_shader_float_#{GLSL_VERSION}.fs")

        assert_raise(ArgumentError) {
          shader.set_values(
            values: 0.0,
          )
        }
      end

      def test_set_shader_values_wrong_type
        skip_unless_display_present
        set_window_title(__method__.to_s)

        shader = Shader.load(fragment_shader_path: "assets/uniform_shader_float_#{GLSL_VERSION}.fs")

        assert_raise(ArgumentError) {
          shader.set_values(
            values: "green",
            variable: 'red',
          )
        }
      end

      def test_set_shader_values_wrong_type_in_array
        skip_unless_display_present
        set_window_title(__method__.to_s)

        shader = Shader.load(fragment_shader_path: "assets/uniform_shader_float_#{GLSL_VERSION}.fs")

        assert_raise(ArgumentError) {
          shader.set_values(
            values: ["green"],
            variable: 'red',
          )
        }
      end

      def test_set_shader_values_too_many_floats
        skip_unless_display_present
        set_window_title(__method__.to_s)

        shader = Shader.load(fragment_shader_path: "assets/uniform_shader_float_#{GLSL_VERSION}.fs")

        assert_raise(ArgumentError) {
          shader.set_values(
            values: [[1.0, 1.0, 1.0, 1.0, 1.0]],
            variable: 'red',
          )
        }
      end

      def test_set_shader_values_too_few_floats
        skip_unless_display_present
        set_window_title(__method__.to_s)

        shader = Shader.load(fragment_shader_path: "assets/uniform_shader_float_#{GLSL_VERSION}.fs")

        assert_raise(ArgumentError) {
          shader.set_values(
            values: [[1.0]],
            variable: 'red',
          )
        }
      end

      def test_set_shader_values_too_many_ints
        skip_unless_display_present
        set_window_title(__method__.to_s)

        shader = Shader.load(fragment_shader_path: "assets/uniform_shader_float_#{GLSL_VERSION}.fs")

        assert_raise(ArgumentError) {
          shader.set_values(
            values: [[1, 1, 1, 1, 1]],
            variable: 'red',
          )
        }
      end

      def test_set_shader_values_too_few_ints
        skip_unless_display_present
        set_window_title(__method__.to_s)

        shader = Shader.load(fragment_shader_path: "assets/uniform_shader_float_#{GLSL_VERSION}.fs")

        assert_raise(ArgumentError) {
          shader.set_values(
            values: [[1]],
            variable: 'red',
          )
        }
      end

      def test_set_shader_values_float
        skip_unless_display_present
        set_window_title(__method__.to_s)

        shader = Shader.load(fragment_shader_path: "assets/uniform_shader_float_#{GLSL_VERSION}.fs")

        shader.set_values(
          values: [0.0],
          variable: 'red',
        )

        shader.set_values(
          variable: 'green',
          values: [0.4745],
        )

        shader.set_values(
          variable: 'blue',
          values: [0.94509],
        )

        clear_and_draw do
          shader.draw do
            Rectangle.new(0, 0, 10, 10).draw(colour: RED)
          end
        end
        flush_frames(2)

        assert_equal fixture_set_shader_values_float, get_screen_data.data

        shader.unload
      end

      def test_set_shader_values_vec2
        skip_unless_display_present
        set_window_title(__method__.to_s)

        shader = Shader.load(fragment_shader_path: "assets/uniform_shader_vec2_#{GLSL_VERSION}.fs")

        shader.set_values(
          variable: 'vector',
          values: [[0.1, 0.5]],
        )

        clear_and_draw do
          shader.draw do
            Rectangle.new(0, 0, 10, 10).draw(colour: RED)
          end
        end
        flush_frames(2)

        assert_equal fixture_set_shader_values_vec2, get_screen_data.data

        shader.unload
      end

      def test_set_shader_values_vec3
        skip_unless_display_present
        set_window_title(__method__.to_s)

        shader = Shader.load(fragment_shader_path: "assets/uniform_shader_vec3_#{GLSL_VERSION}.fs")

        shader.set_values(
          variable: 'vector',
          values: [[0.1, 0.5, 0.75]],
        )

        clear_and_draw do
          shader.draw do
            Rectangle.new(0, 0, 10, 10).draw(colour: RED)
          end
        end
        flush_frames(2)

        assert_equal fixture_set_shader_values_vec3, get_screen_data.data

        shader.unload
      end

      def test_set_shader_values_vec4
        skip_unless_display_present
        set_window_title(__method__.to_s)

        shader = Shader.load(fragment_shader_path: "assets/uniform_shader_vec4_#{GLSL_VERSION}.fs")

        shader.set_values(
          variable: 'vector',
          values: [[0.1, 0.5, 0.75, 1.0]],
        )

        clear_and_draw do
          shader.draw do
            Rectangle.new(0, 0, 10, 10).draw(colour: RED)
          end
        end
        flush_frames(2)

        assert_equal fixture_set_shader_values_vec4, get_screen_data.data

        shader.unload
      end

      def test_set_shader_values_int
        skip_unless_display_present
        set_window_title(__method__.to_s)

        shader = Shader.load(fragment_shader_path: "assets/uniform_shader_int_#{GLSL_VERSION}.fs")

        shader.set_values(
          variable: 'red',
          values: [1],
        )

        shader.set_values(
          variable: 'green',
          values: [0],
        )

        shader.set_values(
          variable: 'blue',
          values: [1],
        )

        clear_and_draw do
          shader.draw do
            Rectangle.new(0, 0, 10, 10).draw(colour: RED)
          end
        end
        flush_frames(2)

        assert_equal fixture_set_shader_values_int, get_screen_data.data

        shader.unload
      end

      def test_set_shader_values_ivec2
        skip_unless_display_present
        set_window_title(__method__.to_s)

        shader = Shader.load(fragment_shader_path: "assets/uniform_shader_ivec2_#{GLSL_VERSION}.fs")

        shader.set_values(
          variable: 'vector',
          values: [[0, 1]],
        )

        clear_and_draw do
          shader.draw do
            Rectangle.new(0, 0, 10, 10).draw(colour: RED)
          end
        end
        flush_frames(2)

        assert_equal fixture_set_shader_values_ivec2, get_screen_data.data

        shader.unload
      end

      def test_set_shader_values_ivec3
        skip_unless_display_present
        set_window_title(__method__.to_s)

        shader = Shader.load(fragment_shader_path: "assets/uniform_shader_ivec3_#{GLSL_VERSION}.fs")

        shader.set_values(
          values: [[0, 1, 1]],
          variable: 'vector',
        )

        clear_and_draw do
          shader.draw do
            Rectangle.new(0, 0, 10, 10).draw(colour: RED)
          end
        end
        flush_frames(2)

        assert_equal fixture_set_shader_values_ivec3, get_screen_data.data

        shader.unload
      end

      def test_set_shader_values_ivec4
        skip_unless_display_present
        set_window_title(__method__.to_s)

        shader = Shader.load(fragment_shader_path: "assets/uniform_shader_ivec4_#{GLSL_VERSION}.fs")

        shader.set_values(
          variable: 'vector',
          values: [[1, 0, 0, 1]],
        )

        clear_and_draw do
          shader.draw do
            Rectangle.new(0, 0, 10, 10).draw(colour: RED)
          end
        end
        flush_frames(2)

        assert_equal fixture_set_shader_values_ivec4, get_screen_data.data

        shader.unload
      end
    end
  end
end
