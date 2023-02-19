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
  end
end
