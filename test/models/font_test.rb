class Test
  class Models
    class Font_Test < Test::Base
      def test_initialize
        Taylor::Raylib.mock_call("LoadFontEx", Font.mock_return(size: 32, glyph_count: 95, glyph_padding: 4))

        font = Font.new("./assets/tiny.ttf")

        assert_called [
          "(FileExists) { fileName: './assets/tiny.ttf' }",
          "(LoadFontEx) { fileName: './assets/tiny.ttf' fontSize: 32 codepoints: 0x0 codepointCount: 95 }"
        ]

        assert_kind_of Font, font
        assert_equal 32, font.size
        assert_equal 95, font.glyph_count
        assert_equal 4, font.glyph_padding
      end

      def test_initialize_with_args
        Taylor::Raylib.mock_call("LoadFontEx", Font.mock_return(size: 6, glyph_count: 100, glyph_padding: 4))

        font = Font.new("./assets/tiny.ttf", size: 6, glyph_count: 100)

        assert_called [
          "(FileExists) { fileName: './assets/tiny.ttf' }",
          "(LoadFontEx) { fileName: './assets/tiny.ttf' fontSize: 6 codepoints: 0x0 codepointCount: 100 }"
        ]

        assert_kind_of Font, font
        assert_equal 6, font.size
        assert_equal 100, font.glyph_count
        assert_equal 4, font.glyph_padding
      end

      def test_initialize_fail
        Taylor::Raylib.mock_call("FileExists", "false")

        assert_raise_with_message(Font::NotFoundError, "Unable to find './assets/fail.ttf'") {
          Font.new("./assets/fail.ttf")
        }

        assert_called [
          "(FileExists) { fileName: './assets/fail.ttf' }"
        ]
      end

      def test_unload
        Taylor::Raylib.mock_call("LoadFontEx", Font.mock_return(size: 1, glyph_count: 2, glyph_padding: 3))
        font = Font.new("./assets/tiny.ttf")
        Taylor::Raylib.reset_calls

        font.unload
        assert_called [
          "(UnloadFont) { font: { baseSize: 1 glyphCount: 2 glyphPadding: 3 } }"
        ]
      end

      def test_default
        Taylor::Raylib.mock_call("GetFontDefault", Font.mock_return(size: 10, glyph_count: 224, glyph_padding: 0))

        font = Font.default

        assert_kind_of Font, font
        assert_equal 10, font.size
        assert_equal 224, font.glyph_count
        assert_equal 0, font.glyph_padding

        assert_called [
          "(GetFontDefault) { }"
        ]
      end

      def test_to_h
        Taylor::Raylib.mock_call("LoadFontEx", Font.mock_return(size: 32, glyph_count: 95, glyph_padding: 4))

        font = Font.new("./assets/tiny.ttf")

        assert_equal(32, font.to_h[:size])
        assert_equal(95, font.to_h[:glyph_count])
        assert_equal(4, font.to_h[:glyph_padding])
      end

      def test_valid?
        Taylor::Raylib.mock_call("LoadFontEx", Font.mock_return(size: 4, glyph_count: 5, glyph_padding: 6))
        font = Font.new("./assets/tiny.ttf")
        Taylor::Raylib.reset_calls

        Taylor::Raylib.mock_call("IsFontValid", "true")
        Taylor::Raylib.mock_call("IsFontValid", "false")

        assert_true font.valid?
        assert_false font.valid?

        assert_called [
          "(IsFontValid) { font: { baseSize: 4 glyphCount: 5 glyphPadding: 6 } }",
          "(IsFontValid) { font: { baseSize: 4 glyphCount: 5 glyphPadding: 6 } }"
        ]
      end

      def test_draw
        Taylor::Raylib.mock_call("LoadFontEx", Font.mock_return(size: 7, glyph_count: 8, glyph_padding: 9))

        font = Font.new("./assets/tiny.ttf")
        Taylor::Raylib.reset_calls

        font.draw("text")
        assert_called [
          "(DrawTextEx) { font: { baseSize: 7 glyphCount: 8 glyphPadding: 9 } text: 'text' position: { x: 0.000000 y: 0.000000 } fontSize: 7.000000 spacing: 0.000000 tint: { r: 0 g: 0 b: 0 a: 255 } }"
        ]
      end

      def test_draw_with_args
        Taylor::Raylib.mock_call("LoadFontEx", Font.mock_return(size: 6))
        font = Font.new("./assets/tiny.ttf", size: 6)
        Taylor::Raylib.reset_calls

        font.draw(
          "x",
          size: 12,
          spacing: 13,
          colour: Colour[1, 2, 3, 4]
        )

        assert_called [
          "(DrawTextEx) { font: { baseSize: 6 glyphCount: 0 glyphPadding: 0 } text: 'x' position: { x: 0.000000 y: 0.000000 } fontSize: 12.000000 spacing: 13.000000 tint: { r: 1 g: 2 b: 3 a: 4 } }"
        ]
      end

      def test_draw_with_vector
        Taylor::Raylib.mock_call("LoadFontEx", Font.mock_return(size: 8))
        font = Font.new("./assets/tiny.ttf", size: 8)
        Taylor::Raylib.reset_calls

        font.draw(
          "q",
          position: Vector2.new(2, 3)
        )

        assert_called [
          "(DrawTextEx) { font: { baseSize: 8 glyphCount: 0 glyphPadding: 0 } text: 'q' position: { x: 2.000000 y: 3.000000 } fontSize: 8.000000 spacing: 0.000000 tint: { r: 0 g: 0 b: 0 a: 255 } }"
        ]
      end

      def test_draw_with_x_and_y
        Taylor::Raylib.mock_call("LoadFontEx", Font.mock_return(size: 9))
        font = Font.new("./assets/tiny.ttf", size: 9)
        Taylor::Raylib.reset_calls

        font.draw(
          "y",
          x: 2, y: 1
        )

        assert_called [
          "(DrawTextEx) { font: { baseSize: 9 glyphCount: 0 glyphPadding: 0 } text: 'y' position: { x: 2.000000 y: 1.000000 } fontSize: 9.000000 spacing: 0.000000 tint: { r: 0 g: 0 b: 0 a: 255 } }"
        ]
      end

      def test_measure
        Taylor::Raylib.mock_call("LoadFontEx", Font.mock_return(size: 9))
        font = Font.new("./assets/tiny.ttf", size: 9)
        Taylor::Raylib.reset_calls
        Taylor::Raylib.mock_call("MeasureTextEx", "1 2")

        assert_equal Vector2[1, 2], font.measure("xx")

        assert_called [
          "(MeasureTextEx) { font: { baseSize: 9 glyphCount: 0 glyphPadding: 0 } text: 'xx' fontSize: 9.000000 spacing: 0.000000 }"
        ]
      end

      def test_measure_with_args
        Taylor::Raylib.mock_call("LoadFontEx", Font.mock_return(size: 10))
        font = Font.new("./assets/tiny.ttf", size: 10)
        Taylor::Raylib.reset_calls
        Taylor::Raylib.mock_call("MeasureTextEx", "2 3")

        assert_equal Vector2[2, 3], font.measure("qq", size: 11, spacing: 12)

        assert_called [
          "(MeasureTextEx) { font: { baseSize: 10 glyphCount: 0 glyphPadding: 0 } text: 'qq' fontSize: 11.000000 spacing: 12.000000 }"
        ]
      end

      def test_to_image
        Taylor::Raylib.mock_call("LoadFontEx", Font.mock_return(size: 11))
        font = Font.new("./assets/tiny.ttf", size: 11)
        Taylor::Raylib.reset_calls
        Taylor::Raylib.mock_call("ImageTextEx", Image.mock_return(width: 1, height: 2, mipmaps: 3, format: 4))

        image = font.to_image("xx")

        assert_kind_of Image, image
        assert_equal 1, image.width
        assert_equal 2, image.height
        assert_equal 3, image.mipmaps
        assert_equal 4, image.format

        assert_called [
          "(ImageTextEx) { font: { baseSize: 11 glyphCount: 0 glyphPadding: 0 } text: 'xx' fontSize: 11.000000 spacing: 0.000000 tint: { r: 0 g: 0 b: 0 a: 255 } }"
        ]
      end

      def test_to_image_with_args
        Taylor::Raylib.mock_call("LoadFontEx", Font.mock_return(size: 12))
        font = Font.new("./assets/tiny.ttf", size: 12)
        Taylor::Raylib.reset_calls
        Taylor::Raylib.mock_call("ImageTextEx", Image.mock_return(width: 2, height: 3, mipmaps: 4, format: 5))

        image = font.to_image("x", size: 13, spacing: 14, colour: Colour[2, 3, 4, 5])

        assert_kind_of Image, image
        assert_equal 2, image.width
        assert_equal 3, image.height
        assert_equal 4, image.mipmaps
        assert_equal 5, image.format

        assert_called [
          "(ImageTextEx) { font: { baseSize: 12 glyphCount: 0 glyphPadding: 0 } text: 'x' fontSize: 13.000000 spacing: 14.000000 tint: { r: 2 g: 3 b: 4 a: 5 } }"
        ]
      end
    end
  end
end
