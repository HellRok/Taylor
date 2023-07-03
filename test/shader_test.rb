class Test
  class Shader_Test < MTest::Unit::TestCaseWithAnalytics
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

      shader = load_shader('', "assets/uniform_shader_#{GLSL_VERSION}.fs")

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
  end
end
