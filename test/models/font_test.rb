class Test
  class Models
    class Font_Test < Test::Base
      def test_initialize
        Taylor::Raylib.mock_call("LoadFontEx", Font.mock_return(size: 32, glyph_count: 95, glyph_padding: 4))

        font = Font.new("./assets/tiny.ttf")

        assert_called [
          "(FileExists) { fileName: './assets/tiny.ttf' }",
          "(LoadFontEx) { fileName: './assets/tiny.ttf' fontSize: 32 fontChars: 0x0 glyphCount: 95 }"
        ]

        assert_kind_of Font, font
        assert_equal 32, font.size
        assert_equal 95, font.glyph_count
        assert_equal 4, font.glyph_padding
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

      def test_initialize_with_args
        Taylor::Raylib.mock_call("LoadFontEx", Font.mock_return(size: 6, glyph_count: 100, glyph_padding: 4))

        font = Font.new("./assets/tiny.ttf", size: 6, glyph_count: 100)

        assert_called [
          "(FileExists) { fileName: './assets/tiny.ttf' }",
          "(LoadFontEx) { fileName: './assets/tiny.ttf' fontSize: 6 fontChars: 0x0 glyphCount: 100 }"
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

      def test_ready?
        Taylor::Raylib.mock_call("LoadFontEx", Font.mock_return(size: 4, glyph_count: 5, glyph_padding: 6))

        font = Font.new("./assets/tiny.ttf")
        Taylor::Raylib.reset_calls

        font.ready?
        assert_called [
          "(IsFontReady) { font: { baseSize: 4 glyphCount: 5 glyphPadding: 6 } }"
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

      def test_draw_with_size
        Taylor::Raylib.mock_call("LoadFontEx", Font.mock_return(size: 6))

        font = Font.new("./assets/tiny.ttf", size: 6)
        Taylor::Raylib.reset_calls

        font.draw("x", size: 12)

        assert_called [
          "(DrawTextEx) { font: { baseSize: 6 glyphCount: 0 glyphPadding: 0 } text: 'x' position: { x: 0.000000 y: 0.000000 } fontSize: 12.000000 spacing: 0.000000 tint: { r: 0 g: 0 b: 0 a: 255 } }"
        ]
      end

      def test_draw_with_position
        Taylor::Raylib.mock_call("LoadFontEx", Font.mock_return(size: 6))

        font = Font.new("./assets/tiny.ttf", size: 6)
        Taylor::Raylib.reset_calls

        font.draw(
          "q",
          position: Vector2.new(2, 2)
        )

        assert_called [
          "(DrawTextEx) { font: { baseSize: 6 glyphCount: 0 glyphPadding: 0 } text: 'q' position: { x: 2.000000 y: 2.000000 } fontSize: 6.000000 spacing: 0.000000 tint: { r: 0 g: 0 b: 0 a: 255 } }"
        ]
      end

      def test_draw_with_x_and_y
        Taylor::Raylib.mock_call("LoadFontEx", Font.mock_return(size: 6))

        font = Font.new("./assets/tiny.ttf", size: 6)
        Taylor::Raylib.reset_calls

        font.draw(
          "y",
          x: 2, y: 0
        )

        assert_called [
          "(DrawTextEx) { font: { baseSize: 6 glyphCount: 0 glyphPadding: 0 } text: 'y' position: { x: 2.000000 y: 0.000000 } fontSize: 6.000000 spacing: 0.000000 tint: { r: 0 g: 0 b: 0 a: 255 } }"
        ]
      end

      # def test_draw_with_colour
      #  skip_unless_display_present

      #  set_window_title(__method__.to_s)
      #  font = Font.new("./assets/tiny.ttf", size: 6)
      #  clear_and_draw do
      #    font.draw(
      #      "O",
      #      colour: Colour::GREEN
      #    )
      #  end

      #  assert_equal fixture_font_draw_with_colour, get_screen_data.data
      # ensure
      #  font.unload
      # end

      # def test_unload
      #  font = Font.new("./assets/tiny.ttf")
      #  assert_true font.ready?
      # ensure
      #  font.unload
      # end

      # def test_draw_with_spacing
      #  skip_unless_display_present

      #  set_window_title(__method__.to_s)
      #  font = Font.new("./assets/tiny.ttf", size: 6)
      #  clear_and_draw do
      #    font.draw(
      #      "xx",
      #      spacing: 1
      #    )
      #  end

      #  assert_equal fixture_font_draw_with_spacing, get_screen_data.data
      # ensure
      #  font.unload
      # end

      # def test_measure
      #  skip_unless_display_present

      #  set_window_title(__method__.to_s)
      #  font = Font.new("./assets/tiny.ttf", size: 6)
      #  assert_equal 8, font.measure("xx").width
      #  assert_equal 6, font.measure("xx").height
      # ensure
      #  font.unload
      # end

      # def test_measure_with_size
      #  skip_unless_display_present

      #  set_window_title(__method__.to_s)
      #  font = Font.new("./assets/tiny.ttf", size: 6)
      #  assert_equal 16, font.measure("xx", size: 12).width
      #  assert_equal 12, font.measure("xx", size: 12).height
      # ensure
      #  font.unload
      # end

      # def test_measure_with_spacing
      #  skip_unless_display_present

      #  set_window_title(__method__.to_s)
      #  font = Font.new("./assets/tiny.ttf", size: 6)
      #  assert_equal 9, font.measure("xx", spacing: 1).width
      #  assert_equal 6, font.measure("xx", spacing: 1).height
      # ensure
      #  font.unload
      # end

      # def test_to_image
      #  skip_unless_display_present

      #  set_window_title(__method__.to_s)
      #  font = Font.new("./assets/tiny.ttf", size: 6)
      #  image = font.to_image("xx")
      #  assert_equal fixture_font_to_image, image.data
      # ensure
      #  font.unload
      #  image.unload
      # end

      # def test_to_image_with_size
      #  skip_unless_display_present

      #  set_window_title(__method__.to_s)
      #  font = Font.new("./assets/tiny.ttf", size: 6)
      #  image = font.to_image("x", size: 12, colour: Colour::GREEN)
      #  # I suspect there's a bug here in Raylib where there is a filter being
      #  # applied somewhere in the process. Because just drawing it to the
      #  # screen at an exact integer scale works fine, but here it's slightly
      #  # blurry.
      #  assert_equal fixture_font_to_image_with_size, image.data
      # ensure
      #  font.unload
      #  image.unload
      # end

      # def test_to_image_with_spacing
      #  skip_unless_display_present

      #  set_window_title(__method__.to_s)
      #  font = Font.new("./assets/tiny.ttf", size: 6)
      #  image = font.to_image("xx", spacing: 1)
      #  assert_equal fixture_font_to_image_with_spacing, image.data
      # ensure
      #  font.unload
      #  image.unload
      # end

      # def test_to_image_with_colour
      #  skip_unless_display_present

      #  set_window_title(__method__.to_s)
      #  font = Font.new("./assets/tiny.ttf", size: 6)
      #  image = font.to_image("xx", colour: Colour::GREEN)
      #  assert_equal fixture_font_to_image_with_colour, image.data
      # ensure
      #  font.unload
      #  image.unload
      # end
    end
  end
end
