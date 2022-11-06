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
    end
  end
end
