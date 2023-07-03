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

      def test_shader_ready
        skip_unless_display_present

        set_window_title(__method__.to_s)

        shader = Shader.load('', "assets/fragment_shader_#{GLSL_VERSION}.fs")

        assert_true shader.ready?

        shader.unload
      end

      def test_get_shader_location
        skip_unless_display_present
        set_window_title(__method__.to_s)

        shader = Shader.load('', "assets/uniform_shader_#{GLSL_VERSION}.fs")

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
    end
  end
end
