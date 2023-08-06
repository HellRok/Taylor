class Test
  class Shader_Test < MTest::Unit::TestCaseWithAnalytics
    def test_load_shader_from_string
      skip_unless_display_present
      set_window_title(__method__.to_s)

      shader = load_shader_from_string(nil, <<-FRAGMENT)
        #version #{GLSL_VERSION}

        void main() {
          gl_FragColor = vec4(0.0, 0.58, 0.86, 1.0);
        }
      FRAGMENT

      clear_and_draw do
        begin_shader_mode(shader)
          Rectangle.new(0, 0, 10, 10).draw(colour: RED)
        end_shader_mode
      end

      assert_equal fixture_load_shader, get_screen_data.data
      unload_shader(shader)
    end

    def test_load_shader
      skip_unless_display_present
      set_window_title(__method__.to_s)

      shader = load_shader('', "assets/fragment_shader_#{GLSL_VERSION}.fs")

      clear_and_draw do
        begin_shader_mode(shader)
          Rectangle.new(0, 0, 10, 10).draw(colour: RED)
        end_shader_mode
      end

      assert_equal fixture_load_shader, get_screen_data.data
      unload_shader(shader)
    end

    def test_shader_ready
      skip_unless_display_present
      set_window_title(__method__.to_s)

      shader = load_shader('', "assets/fragment_shader_#{GLSL_VERSION}.fs")

      assert_true shader_ready?(shader)
      unload_shader(shader)
    end

    def test_get_shader_location
      skip_unless_display_present
      set_window_title(__method__.to_s)

      shader = load_shader('', "assets/uniform_shader_float_#{GLSL_VERSION}.fs")

      assert_equal(-1, get_shader_location(shader, 'non_existant'))

      if GLSL_VERSION == 330
        assert_equal 1, get_shader_location(shader, 'red')
        assert_equal 2, get_shader_location(shader, 'green')
        assert_equal 3, get_shader_location(shader, 'blue')
      elsif GLSL_VERSION == 100
        assert_equal 2, get_shader_location(shader, 'red')
        assert_equal 3, get_shader_location(shader, 'green')
        assert_equal 4, get_shader_location(shader, 'blue')
      else
        raise "Unexpected GLSL_VERSION"
      end

      unload_shader(shader)
    end

    def test_set_shaders_value_float
      skip_unless_display_present
      set_window_title(__method__.to_s)

      shader = load_shader('', "assets/uniform_shader_float_#{GLSL_VERSION}.fs")

      set_shader_values(
        shader,
        get_shader_location(shader, 'red'),
        [0.0],
        Shader::Uniform::FLOAT
      )

      set_shader_values(
        shader,
        get_shader_location(shader, 'green'),
        [0.4745],
        Shader::Uniform::FLOAT
      )

      set_shader_values(
        shader,
        get_shader_location(shader, 'blue'),
        [0.94509],
        Shader::Uniform::FLOAT
      )

      clear_and_draw do
        begin_shader_mode(shader)
        Rectangle.new(0, 0, 10, 10).draw(colour: RED)
        end_shader_mode
      end
      flush_frames(2)

      assert_equal fixture_set_shader_values_float, get_screen_data.data

      unload_shader(shader)
    end

    def test_set_shaders_value_vec2
      skip_unless_display_present
      set_window_title(__method__.to_s)

      shader = load_shader('', "assets/uniform_shader_vec2_#{GLSL_VERSION}.fs")

      set_shader_values(
        shader,
        get_shader_location(shader, 'vector'),
        [[0.1, 0.5]],
        Shader::Uniform::VEC2
      )

      clear_and_draw do
        begin_shader_mode(shader)
        Rectangle.new(0, 0, 10, 10).draw(colour: RED)
        end_shader_mode
      end
      flush_frames(2)

      assert_equal fixture_set_shader_values_vec2, get_screen_data.data

      unload_shader(shader)
    end

    def test_set_shaders_value_vec3
      skip_unless_display_present
      set_window_title(__method__.to_s)

      shader = load_shader('', "assets/uniform_shader_vec3_#{GLSL_VERSION}.fs")

      set_shader_values(
        shader,
        get_shader_location(shader, 'vector'),
        [[0.1, 0.5, 0.75]],
        Shader::Uniform::VEC3
      )

      clear_and_draw do
        begin_shader_mode(shader)
        Rectangle.new(0, 0, 10, 10).draw(colour: RED)
        end_shader_mode
      end
      flush_frames(2)

      assert_equal fixture_set_shader_values_vec3, get_screen_data.data

      unload_shader(shader)
    end

    def test_set_shaders_value_vec4
      skip_unless_display_present
      set_window_title(__method__.to_s)

      shader = load_shader('', "assets/uniform_shader_vec4_#{GLSL_VERSION}.fs")

      set_shader_values(
        shader,
        get_shader_location(shader, 'vector'),
        [[0.1, 0.5, 0.75, 1.0]],
        Shader::Uniform::VEC4
      )

      clear_and_draw do
        begin_shader_mode(shader)
        Rectangle.new(0, 0, 10, 10).draw(colour: RED)
        end_shader_mode
      end
      flush_frames(2)

      assert_equal fixture_set_shader_values_vec4, get_screen_data.data

      unload_shader(shader)
    end

    def test_set_shaders_value_int
      skip_unless_display_present
      set_window_title(__method__.to_s)

      shader = load_shader('', "assets/uniform_shader_int_#{GLSL_VERSION}.fs")

      set_shader_values(
        shader,
        get_shader_location(shader, 'red'),
        [1],
        Shader::Uniform::INT
      )

      set_shader_values(
        shader,
        get_shader_location(shader, 'green'),
        [0],
        Shader::Uniform::INT
      )

      set_shader_values(
        shader,
        get_shader_location(shader, 'blue'),
        [1],
        Shader::Uniform::INT
      )

      clear_and_draw do
        begin_shader_mode(shader)
        Rectangle.new(0, 0, 10, 10).draw(colour: RED)
        end_shader_mode
      end
      flush_frames(2)

      assert_equal fixture_set_shader_values_int, get_screen_data.data

      unload_shader(shader)
    end

    def test_set_shaders_value_ivec2
      skip_unless_display_present
      set_window_title(__method__.to_s)

      shader = load_shader('', "assets/uniform_shader_ivec2_#{GLSL_VERSION}.fs")

      set_shader_values(
        shader,
        get_shader_location(shader, 'vector'),
        [[0, 1]],
        Shader::Uniform::IVEC2
      )

      clear_and_draw do
        begin_shader_mode(shader)
        Rectangle.new(0, 0, 10, 10).draw(colour: RED)
        end_shader_mode
      end
      flush_frames(2)

      assert_equal fixture_set_shader_values_ivec2, get_screen_data.data

      unload_shader(shader)
    end

    def test_set_shaders_value_ivec3
      skip_unless_display_present
      set_window_title(__method__.to_s)

      shader = load_shader('', "assets/uniform_shader_ivec3_#{GLSL_VERSION}.fs")

      set_shader_values(
        shader,
        get_shader_location(shader, 'vector'),
        [[0, 1, 1]],
        Shader::Uniform::IVEC3
      )

      clear_and_draw do
        begin_shader_mode(shader)
        Rectangle.new(0, 0, 10, 10).draw(colour: RED)
        end_shader_mode
      end
      flush_frames(2)

      assert_equal fixture_set_shader_values_ivec3, get_screen_data.data

      unload_shader(shader)
    end

    def test_set_shaders_value_ivec4
      skip_unless_display_present
      set_window_title(__method__.to_s)

      shader = load_shader('', "assets/uniform_shader_ivec4_#{GLSL_VERSION}.fs")

      set_shader_values(
        shader,
        get_shader_location(shader, 'vector'),
        [[1, 0, 0, 1]],
        Shader::Uniform::IVEC4
      )

      clear_and_draw do
        begin_shader_mode(shader)
        Rectangle.new(0, 0, 10, 10).draw(colour: RED)
        end_shader_mode
      end
      flush_frames(2)

      assert_equal fixture_set_shader_values_ivec4, get_screen_data.data

      unload_shader(shader)
    end
  end
end
