class Test
  class Shapes
    class Ring_Test < MTest::Unit::TestCaseWithAnalytics
      def test_draw_ring
        skip_unless_display_present

        set_window_title(__method__.to_s)

        clear_and_draw do
          draw_ring(Vector2.new(5, 5), 2, 4, 90, 180, 8, Colour::PURPLE)
        end

        assert_within 99, fixture_draw_ring, get_screen_data.data
      end

      def test_draw_ring_lines
        skip_unless_display_present

        set_window_title(__method__.to_s)

        clear_and_draw do
          draw_ring_lines(Vector2.new(5, 5), 2, 4, 90, 180, 8, Colour::PURPLE)
        end

        assert_within 99, fixture_draw_ring_lines, get_screen_data.data
      end
    end
  end
end
