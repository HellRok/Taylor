class Test
  class Models
    class Texture2D_Test < Test::Base
      def test_initialize
        Taylor::Raylib.mock_call(
          "LoadTexture",
          Texture2D.mock_return(id: 1, width: 2, height: 3, mipmaps: 4, format: 5)
        )

        texture = Texture2D.new("./assets/test.png")

        assert_kind_of Texture2D, texture
        assert_equal 1, texture.id
        assert_equal 2, texture.width
        assert_equal 3, texture.height
        assert_equal 4, texture.mipmaps
        assert_equal 5, texture.format

        assert_called [
          "(FileExists) { fileName: './assets/test.png' }",
          "(LoadTexture) { fileName: './assets/test.png' }"
        ]
      end

      def test_initialize_fail
        Taylor::Raylib.mock_call("FileExists", "false")

        assert_raise_with_message(Texture2D::NotFoundError, "Unable to find './assets/fail.png'") {
          Texture2D.new("./assets/fail.png")
        }

        assert_called [
          "(FileExists) { fileName: './assets/fail.png' }"
        ]
      end

      def test_unload
        Taylor::Raylib.mock_call(
          "LoadTexture",
          Texture2D.mock_return(id: 2, width: 3, height: 4, mipmaps: 5, format: 6)
        )
        texture = Texture2D.new("./assets/test.png")
        Taylor::Raylib.reset_calls

        texture.unload

        assert_called [
          "(UnloadTexture) { texture: { id: 2 width: 3 height: 4 mipmaps: 5 format: 6 } }"
        ]
      end

      def test_to_h
        Taylor::Raylib.mock_call(
          "LoadTexture",
          Texture2D.mock_return(id: 3, width: 4, height: 5, mipmaps: 6, format: 7)
        )
        texture = Texture2D.new("./assets/test.png")

        assert_equal(
          {
            id: 3,
            width: 4,
            height: 5,
            mipmaps: 6,
            format: 7
          },
          texture.to_h
        )
      end

      def test_filter=
        Taylor::Raylib.mock_call(
          "LoadTexture",
          Texture2D.mock_return(id: 3, width: 4, height: 5, mipmaps: 6, format: 7)
        )
        texture = Texture2D.new("./assets/test.png")
        Taylor::Raylib.reset_calls

        texture.filter = Texture2D::BILINEAR

        assert_called [
          "(SetTextureFilter) { texture: { id: 3 width: 4 height: 5 mipmaps: 6 format: 7 } filter: 1 }"
        ]
      end

      def test_filter_equal_too_low
        texture = Texture2D.new("./assets/test.png")
        Taylor::Raylib.reset_calls

        assert_raise_with_message(
          ArgumentError,
          "Filter must be one of: Texture2D::NO_FILTER, " \
            "Texture2D::BILINEAR, Texture2D::TRILINEAR, " \
            "Texture2D::ANISOTROPIC_4X, Texture2D::ANISOTROPIC_8X, " \
            "or Texture2D::ANISOTROPIC_16X"
        ) {
          texture.filter = -1
        }

        assert_no_calls
      end

      def test_filter_equal_too_high
        texture = Texture2D.new("./assets/test.png")
        Taylor::Raylib.reset_calls

        assert_raise_with_message(
          ArgumentError,
          "Filter must be one of: Texture2D::NO_FILTER, " \
            "Texture2D::BILINEAR, Texture2D::TRILINEAR, " \
            "Texture2D::ANISOTROPIC_4X, Texture2D::ANISOTROPIC_8X, " \
            "or Texture2D::ANISOTROPIC_16X"
        ) {
          texture.filter = 6
        }

        assert_no_calls
      end

      def test_generate_mipmaps
        Taylor::Raylib.mock_call(
          "LoadTexture",
          Texture2D.mock_return(id: 4, width: 5, height: 6, mipmaps: 7, format: 8)
        )
        texture = Texture2D.new("./assets/test.png")
        Taylor::Raylib.reset_calls

        texture.generate_mipmaps

        assert_called [
          "(GenTextureMipmaps) { texture: { id: 4 width: 5 height: 6 mipmaps: 7 format: 8 } }"
        ]
      end

      def test_draw
        Taylor::Raylib.mock_call(
          "LoadTexture",
          Texture2D.mock_return(id: 5, width: 6, height: 7, mipmaps: 8, format: 9)
        )
        texture = Texture2D.new("./assets/test.png")
        Taylor::Raylib.reset_calls

        texture.draw

        assert_called [
          "(DrawTexturePro) { " \
            "texture: { id: 5 width: 6 height: 7 mipmaps: 8 format: 9 } " \
            "source: { x: 0.000000 y: 0.000000 width: 6.000000 height: 7.000000 } " \
            "dest: { x: 0.000000 y: 0.000000 width: 6.000000 height: 7.000000 } " \
            "origin: { x: 3.000000 y: 3.500000 } " \
            "rotation: 0.000000 " \
            "tint: { r: 255 g: 255 b: 255 a: 255 } " \
          "}"
        ]
      end

      def test_draw_with_args
        Taylor::Raylib.mock_call(
          "LoadTexture",
          Texture2D.mock_return(id: 6, width: 7, height: 8, mipmaps: 9, format: 10)
        )
        texture = Texture2D.new("./assets/test.png")
        Taylor::Raylib.reset_calls

        texture.draw(
          source: Rectangle[11, 12, 13, 14],
          destination: Rectangle[15, 16, 17, 18],
          origin: Vector2[19, 20],
          rotation: 21,
          colour: Colour[22, 23, 24, 25]
        )

        assert_called [
          "(DrawTexturePro) { " \
            "texture: { id: 6 width: 7 height: 8 mipmaps: 9 format: 10 } " \
            "source: { x: 11.000000 y: 12.000000 width: 13.000000 height: 14.000000 } " \
            "dest: { x: 15.000000 y: 16.000000 width: 17.000000 height: 18.000000 } " \
            "origin: { x: 19.000000 y: 20.000000 } " \
            "rotation: 21.000000 " \
            "tint: { r: 22 g: 23 b: 24 a: 25 } " \
          "}"
        ]
      end

      def test_draw_with_position
        Taylor::Raylib.mock_call(
          "LoadTexture",
          Texture2D.mock_return(id: 7, width: 8, height: 9, mipmaps: 10, format: 11)
        )
        texture = Texture2D.new("./assets/test.png")
        Taylor::Raylib.reset_calls

        texture.draw(position: Vector2[1, 2])

        assert_called [
          "(DrawTexturePro) { " \
            "texture: { id: 7 width: 8 height: 9 mipmaps: 10 format: 11 } " \
            "source: { x: 0.000000 y: 0.000000 width: 8.000000 height: 9.000000 } " \
            "dest: { x: 1.000000 y: 2.000000 width: 8.000000 height: 9.000000 } " \
            "origin: { x: 4.000000 y: 4.500000 } " \
            "rotation: 0.000000 " \
            "tint: { r: 255 g: 255 b: 255 a: 255 } " \
          "}"
        ]
      end

      def test_draw_with_position_and_destination
        Taylor::Raylib.mock_call(
          "LoadTexture",
          Texture2D.mock_return(id: 8, width: 9, height: 10, mipmaps: 11, format: 12)
        )
        texture = Texture2D.new("./assets/test.png")
        Taylor::Raylib.reset_calls

        assert_raise_with_message(ArgumentError, "Can't specify both position and destination") {
          texture.draw(
            position: Vector2[2, 3],
            destination: Rectangle[4, 5, 6, 7]
          )
        }

        assert_no_calls
      end

      def test_draw_with_source_but_no_destination
        Taylor::Raylib.mock_call(
          "LoadTexture",
          Texture2D.mock_return(id: 8, width: 9, height: 10, mipmaps: 11, format: 12)
        )
        texture = Texture2D.new("./assets/test.png")
        Taylor::Raylib.reset_calls

        texture.draw(
          source: Rectangle[1, 2, 3, 4]
        )

        # it uses source to populate destination
        assert_called [
          "(DrawTexturePro) { " \
            "texture: { id: 8 width: 9 height: 10 mipmaps: 11 format: 12 } " \
            "source: { x: 1.000000 y: 2.000000 width: 3.000000 height: 4.000000 } " \
            "dest: { x: 1.000000 y: 2.000000 width: 3.000000 height: 4.000000 } " \
            "origin: { x: 1.500000 y: 2.000000 } " \
            "rotation: 0.000000 " \
            "tint: { r: 255 g: 255 b: 255 a: 255 } " \
          "}"
        ]
      end
    end
  end
end
