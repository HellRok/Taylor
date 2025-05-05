class Test
  class Models
    class Texture2D_Test < Test::Base
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

      def test_load
        Texture2D.load("./assets/test.png")

        assert_called [
          "(LoadTexture) { fileName: './assets/test.png' }"
        ]
      end

      def test_unload
        Taylor::Raylib.mock_call(
          "LoadTexture",
          Texture2D.mock_return(id: 1, width: 2, height: 3, mipmaps: 4, format: 5)
        )
        texture = Texture2D.load("./assets/test.png")
        Taylor::Raylib.reset_calls

        texture.unload

        assert_called [
          "(UnloadTexture) { texture: { id: 1 width: 2 height: 3 mipmaps: 4 format: 5 } }"
        ]
      end

      def test_draw
        Taylor::Raylib.mock_call(
          "LoadTexture",
          Texture2D.mock_return(id: 2, width: 3, height: 4, mipmaps: 5, format: 6)
        )
        texture = Texture2D.load("./assets/test.png")
        Taylor::Raylib.reset_calls

        texture.draw(
          source: Rectangle[7, 8, 9, 10],
          destination: Rectangle[11, 12, 13, 14],
          origin: Vector2[15, 16],
          rotation: 17,
          colour: Colour[18, 19, 20, 21]
        )

        assert_called [
          "(DrawTexturePro) { texture: { id: 2 width: 3 height: 4 mipmaps: 5 format: 6 } source: { x: 7.000000 y: 8.000000 width: 9.000000 height: 10.000000 } dest: { x: 11.000000 y: 12.000000 width: 13.000000 height: 14.000000 } origin: { x: 15.000000 y: 16.000000 } rotation: 17.000000 tint: { r: 18 g: 19 b: 20 a: 21 } }"
        ]
      end

      def test_draw_defaults
        Taylor::Raylib.mock_call(
          "LoadTexture",
          Texture2D.mock_return(id: 5, width: 6, height: 7, mipmaps: 8, format: 9)
        )
        texture = Texture2D.load("./assets/test.png")
        Taylor::Raylib.reset_calls

        texture.draw

        assert_called [
          "(DrawTexturePro) { texture: { id: 5 width: 6 height: 7 mipmaps: 8 format: 9 } source: { x: 0.000000 y: 0.000000 width: 6.000000 height: 7.000000 } dest: { x: 0.000000 y: 0.000000 width: 6.000000 height: 7.000000 } origin: { x: 0.000000 y: 0.000000 } rotation: 0.000000 tint: { r: 255 g: 255 b: 255 a: 255 } }"
        ]
      end

      def test_filter=
        Taylor::Raylib.mock_call(
          "LoadTexture",
          Texture2D.mock_return(id: 3, width: 4, height: 5, mipmaps: 6, format: 7)
        )
        texture = Texture2D.load("./assets/test.png")
        Taylor::Raylib.reset_calls

        texture.filter = 8

        assert_called [
          "(SetTextureFilter) { texture: { id: 3 width: 4 height: 5 mipmaps: 6 format: 7 } filter: 8 }"
        ]
      end

      def test_generate_mipmaps
        Taylor::Raylib.mock_call(
          "LoadTexture",
          Texture2D.mock_return(id: 4, width: 5, height: 6, mipmaps: 7, format: 8)
        )
        texture = Texture2D.load("./assets/test.png")
        Taylor::Raylib.reset_calls

        texture.generate_mipmaps

        assert_called [
          "(GenTextureMipmaps) { texture: { id: 4 width: 5 height: 6 mipmaps: 7 format: 8 } }"
        ]
      end
    end
  end
end
