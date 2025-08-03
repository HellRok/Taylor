class Test
  class Models
    class RenderTexture_Test < Test::Base
      def test_initialize
        Taylor::Raylib.mock_call(
          "LoadRenderTexture",
          RenderTexture.mock_return(width: 1, height: 2)
        )
        render_texture = RenderTexture.new(width: 1, height: 2)

        assert_kind_of RenderTexture, render_texture
        assert_equal 1, render_texture.width
        assert_equal 2, render_texture.height
        assert_equal 1, render_texture.texture.width
        assert_equal 2, render_texture.texture.height

        assert_called [
          "(LoadRenderTexture) { width: 1 height: 2 }"
        ]
      end

      def test_to_h
        Taylor::Raylib.mock_call(
          "LoadRenderTexture",
          RenderTexture.mock_return(width: 2, height: 3)
        )
        render_texture = RenderTexture.new(width: 2, height: 3)

        assert_equal(
          {
            width: 2,
            height: 3
          },
          render_texture.to_h
        )
      end

      def test_texture
        Taylor::Raylib.mock_call(
          "LoadRenderTexture",
          RenderTexture.mock_return(width: 3, height: 4)
        )
        render_texture = RenderTexture.new(width: 3, height: 4)

        assert_kind_of Texture2D, render_texture.texture
      end
    end
  end
end
