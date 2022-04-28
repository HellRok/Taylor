class Test
  class Shapes
    class Ellipse < MTest::Unit::TestCaseWithAnalytics
      def test_draw_ellipse
        skip_unless_display_present

        set_window_title(__method__.to_s)

        clear_and_draw do
          draw_ellipse(5, 5, 3, 7, PURPLE)
        end

        assert_within 99, fixture_draw_ellipse, get_screen_data.data
      end

      def test_draw_ellipse_lines
        skip_unless_display_present

        set_window_title(__method__.to_s)

        clear_and_draw do
          draw_ellipse_lines(5, 5, 3, 5, PURPLE)
        end

        assert_within 99, fixture_draw_ellipse_lines, get_screen_data.data
      end
    end
  end
end
