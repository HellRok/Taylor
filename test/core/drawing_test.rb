class Test
  class Core
    class Drawing_Test < MTest::Unit::TestCaseWithAnalytics
      def test_clear
        skip_unless_display_present

        set_window_title(__method__.to_s)
        drawing do
          clear
        end
        assert_equal fixture_core_drawing_clear_default, get_screen_data.data
      end

      def test_clear_with_colour
        skip_unless_display_present

        set_window_title(__method__.to_s)
        drawing do
          clear colour: Colour::GREEN
        end
        assert_equal fixture_core_drawing_clear_specified, get_screen_data.data
      end

      def test_drawing
        skip_unless_display_present

        set_window_title(__method__.to_s)
        clear_and_draw do
          clear_background(Colour::RAYWHITE)
        end
        assert_equal fixture_core_drawing_drawing, get_screen_data.data

        clear_and_draw do
          clear_background(Colour::RED)
        end
        assert_not_equal fixture_core_drawing_drawing, get_screen_data.data

        drawing do
          clear_background(Colour::RAYWHITE)
        end
        assert_equal fixture_core_drawing_drawing, get_screen_data.data
      end

      def test_scissor_mode
        skip_unless_display_present

        set_window_title(__method__.to_s)
        drawing do
          clear_background(Colour::RAYWHITE)
          scissor_mode(Rectangle.new(2, 2, 6, 6)) do
            clear_background(Colour::RED)
          end
        end
        assert_equal fixture_core_drawing_scissor_mode, get_screen_data.data
      end
    end
  end
end
