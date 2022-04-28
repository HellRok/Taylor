class Test
  class Shapes
    class Pixel < MTest::Unit::TestCaseWithAnalytics
      def test_draw_pixel
        skip_unless_display_present

        set_window_title(__method__.to_s)

        clear_and_draw do
          draw_pixel(2, 2, VIOLET)
        end

        assert_within 99, fixture_draw_pixel, get_screen_data.data
      end

      def test_draw_pixel_v
        skip_unless_display_present

        set_window_title(__method__.to_s)

        clear_and_draw do
          draw_pixel_v(Vector2.new(2, 2), VIOLET)
        end

        assert_within 99, fixture_draw_pixel, get_screen_data.data
      end
    end
  end
end
