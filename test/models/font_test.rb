class Test
  class Models
    class Font_Test < MTest::Unit::TestCaseWithAnalytics
      def test_initialize
        font = Font.new("./assets/tiny.ttf")

        assert_kind_of Font, font
        assert_equal 32, font.size
        assert_equal 95, font.glyph_count
        assert_equal 4, font.glyph_padding

        font.unload
      end

      def test_initialize_with_args
        font = Font.new("./assets/tiny.ttf", size: 6, glyph_count: 100)

        assert_kind_of Font, font
        assert_equal 6, font.size
        assert_equal 100, font.glyph_count
        assert_equal 4, font.glyph_padding

        font.unload
      end

      def test_initialize_fail
        assert_raise(Font::NotFound) {
          Font.new("./assets/fail.ttf")
        }
      end

      def test_default
        font = Font.default

        assert_kind_of Font, font
        assert_equal 10, font.size
        assert_equal 224, font.glyph_count
        assert_equal 0, font.glyph_padding

        clear_and_draw do
          Font.default.draw("xx")
        end

        assert_equal fixture_font_default_draw, get_screen_data.data
      end

      def test_to_h
        font = Font.new("./assets/tiny.ttf")

        assert_equal(32, font.to_h[:size])
        assert_equal(95, font.to_h[:glyph_count])
        assert_equal(4, font.to_h[:glyph_padding])
      ensure
        font.unload
      end

      def test_ready?
        font = Font.new("./assets/tiny.ttf")
        assert_true font.ready?
      ensure
        font.unload
      end

      def test_draw
        skip_unless_display_present

        set_window_title(__method__.to_s)
        font = Font.new("./assets/tiny.ttf", size: 6)
        clear_and_draw do
          font.draw("xx")
        end

        assert_equal fixture_font_draw, get_screen_data.data
      ensure
        font.unload
      end

      def test_draw_with_size
        skip_unless_display_present

        set_window_title(__method__.to_s)
        font = Font.new("./assets/tiny.ttf", size: 6)
        clear_and_draw do
          font.draw("x", size: 12)
        end

        assert_equal fixture_font_draw_with_size, get_screen_data.data
      ensure
        font.unload
      end

      def test_draw_with_position
        skip_unless_display_present

        set_window_title(__method__.to_s)
        font = Font.new("./assets/tiny.ttf", size: 6)
        clear_and_draw do
          font.draw(
            "x",
            position: Vector2.new(2, 2)
          )
        end

        assert_equal fixture_font_draw_with_position, get_screen_data.data
      ensure
        font.unload
      end

      def test_draw_with_x_and_y
        skip_unless_display_present

        set_window_title(__method__.to_s)
        font = Font.new("./assets/tiny.ttf", size: 6)
        clear_and_draw do
          font.draw(
            "x",
            x: 2, y: 0
          )
        end

        assert_equal fixture_font_draw_with_x_and_y, get_screen_data.data
      ensure
        font.unload
      end

      def test_draw_with_colour
        skip_unless_display_present

        set_window_title(__method__.to_s)
        font = Font.new("./assets/tiny.ttf", size: 6)
        clear_and_draw do
          font.draw(
            "O",
            colour: Colour::GREEN
          )
        end

        assert_equal fixture_font_draw_with_colour, get_screen_data.data
      ensure
        font.unload
      end

      def test_unload
        font = Font.new("./assets/tiny.ttf")
        assert_true font.ready?
      ensure
        font.unload
      end

      def test_draw_with_spacing
        skip_unless_display_present

        set_window_title(__method__.to_s)
        font = Font.new("./assets/tiny.ttf", size: 6)
        clear_and_draw do
          font.draw(
            "xx",
            spacing: 1
          )
        end

        assert_equal fixture_font_draw_with_spacing, get_screen_data.data
      ensure
        font.unload
      end

      def test_measure
        skip_unless_display_present

        set_window_title(__method__.to_s)
        font = Font.new("./assets/tiny.ttf", size: 6)
        assert_equal 8, font.measure("xx").width
        assert_equal 6, font.measure("xx").height
      ensure
        font.unload
      end

      def test_measure_with_size
        skip_unless_display_present

        set_window_title(__method__.to_s)
        font = Font.new("./assets/tiny.ttf", size: 6)
        assert_equal 16, font.measure("xx", size: 12).width
        assert_equal 12, font.measure("xx", size: 12).height
      ensure
        font.unload
      end

      def test_measure_with_spacing
        skip_unless_display_present

        set_window_title(__method__.to_s)
        font = Font.new("./assets/tiny.ttf", size: 6)
        assert_equal 9, font.measure("xx", spacing: 1).width
        assert_equal 6, font.measure("xx", spacing: 1).height
      ensure
        font.unload
      end

      def test_to_image
        skip_unless_display_present

        set_window_title(__method__.to_s)
        font = Font.new("./assets/tiny.ttf", size: 6)
        image = font.to_image("xx")
        assert_equal fixture_font_to_image, image.data
      ensure
        font.unload
        image.unload
      end

      def test_to_image_with_size
        skip_unless_display_present

        set_window_title(__method__.to_s)
        font = Font.new("./assets/tiny.ttf", size: 6)
        image = font.to_image("x", size: 12, colour: Colour::GREEN)
        # I suspect there's a bug here in Raylib where there is a filter being
        # applied somewhere in the process. Because just drawing it to the
        # screen at an exact integer scale works fine, but here it's slightly
        # blurry.
        assert_equal fixture_font_to_image_with_size, image.data
      ensure
        font.unload
        image.unload
      end

      def test_to_image_with_spacing
        skip_unless_display_present

        set_window_title(__method__.to_s)
        font = Font.new("./assets/tiny.ttf", size: 6)
        image = font.to_image("xx", spacing: 1)
        assert_equal fixture_font_to_image_with_spacing, image.data
      ensure
        font.unload
        image.unload
      end

      def test_to_image_with_colour
        skip_unless_display_present

        set_window_title(__method__.to_s)
        font = Font.new("./assets/tiny.ttf", size: 6)
        image = font.to_image("xx", colour: Colour::GREEN)
        assert_equal fixture_font_to_image_with_colour, image.data
      ensure
        font.unload
        image.unload
      end
    end
  end
end
