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

      def test_draw
        Taylor::Raylib.mock_call(
          "LoadRenderTexture",
          RenderTexture.mock_return(width: 1, height: 2)
        )
        texture = RenderTexture.new(width: 1, height: 2)
        Taylor::Raylib.reset_calls

        texture.draw do
          Window.clear(colour: Colour[1, 0, 0, 0])
        end

        assert_called [
          "(BeginTextureMode) { target: { id: 0 texture.width: 1 texture.height: 2 texture.mipmaps: 0 texture.format: 0 depth.width: 1 depth.height: 2 depth.mipmaps: 0 depth.format: 0 } }",
          "(IsWindowReady) { }",
          "(ClearBackground) { color: { r: 1 g: 0 b: 0 a: 0 } }",
          "(EndTextureMode) { }"
        ]
      end

      def test_draw_with_error
        Taylor::Raylib.mock_call(
          "LoadRenderTexture",
          RenderTexture.mock_return(width: 2, height: 3)
        )
        texture = RenderTexture.new(width: 2, height: 3)
        Taylor::Raylib.reset_calls

        begin
          texture.draw do
            Window.clear(colour: Colour[2, 0, 0, 0])
            raise StandardError, "Oops!"
            Window.clear(colour: Colour[3, 0, 0, 0]) # standard:disable Lint/UnreachableCode
          end
        rescue => error
          assert_equal "Oops!", error.message
        end

        assert_called [
          "(BeginTextureMode) { target: { id: 0 texture.width: 2 texture.height: 3 texture.mipmaps: 0 texture.format: 0 depth.width: 2 depth.height: 3 depth.mipmaps: 0 depth.format: 0 } }",
          "(IsWindowReady) { }",
          "(ClearBackground) { color: { r: 2 g: 0 b: 0 a: 0 } }",
          "(EndTextureMode) { }"
        ]
      end

      def test_begin_drawing
        Taylor::Raylib.mock_call(
          "LoadRenderTexture",
          RenderTexture.mock_return(width: 3, height: 4)
        )
        texture = RenderTexture.new(width: 3, height: 4)
        Taylor::Raylib.reset_calls

        texture.begin_drawing

        assert_called [
          "(BeginTextureMode) { target: { id: 0 texture.width: 3 texture.height: 4 texture.mipmaps: 0 texture.format: 0 depth.width: 3 depth.height: 4 depth.mipmaps: 0 depth.format: 0 } }"
        ]
      end

      def test_end_drawing
        texture = RenderTexture.new(width: 0, height: 0)
        Taylor::Raylib.reset_calls

        texture.end_drawing

        assert_called [
          "(EndTextureMode) { }"
        ]
      end
    end
  end
end
