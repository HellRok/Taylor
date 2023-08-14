class Test
  class Models
    class Texture2D_Test < MTest::Unit::TestCaseWithAnalytics
      def test_initialize
        texture = Texture2D.new(1, 2, 3, 4, 5)

        assert_kind_of Texture2D, texture
        assert_equal 1, texture.id
        assert_equal 2, texture.width
        assert_equal 3, texture.height
        assert_equal 4, texture.mipmaps
        assert_equal 5, texture.format
      end

      def test_assignment
        texture = Texture2D.new(0, 0, 0, 0, 0)
        texture.id = 5
        texture.width = 4
        texture.height = 3
        texture.mipmaps = 2
        texture.format = 1

        assert_equal 5, texture.id
        assert_equal 4, texture.width
        assert_equal 3, texture.height
        assert_equal 2, texture.mipmaps
        assert_equal 1, texture.format
      end

      def test_to_h
        texture = Texture2D.new(1, 2, 3, 4, 5)

        assert_equal(
          {
            id: 1,
            width: 2,
            height: 3,
            mipmaps: 4,
            format: 5
          },
          texture.to_h
        )
      end
    end
  end
end
