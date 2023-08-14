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
          clear colour: GREEN
        end
        assert_equal fixture_core_drawing_clear_specified, get_screen_data.data
      end

      def test_drawing
        skip_unless_display_present

        set_window_title(__method__.to_s)
        clear_and_draw do
          clear_background(RAYWHITE)
        end
        assert_equal fixture_core_drawing_drawing, get_screen_data.data

        clear_and_draw do
          clear_background(RED)
        end
        assert_not_equal fixture_core_drawing_drawing, get_screen_data.data

        drawing do
          clear_background(RAYWHITE)
        end
        assert_equal fixture_core_drawing_drawing, get_screen_data.data
      end

      def test_scissor_mode
        skip_unless_display_present

        set_window_title(__method__.to_s)
        drawing do
          clear_background(RAYWHITE)
          scissor_mode(Rectangle.new(2, 2, 6, 6)) do
            clear_background(RED)
          end
        end
        assert_equal fixture_core_drawing_scissor_mode, get_screen_data.data
      end

      def test_core_drawing_mode2D
        skip_unless_display_present

        set_window_title(__method__.to_s)
        set_target_fps 5
        rectangle = Rectangle.new(2, 2, 6, 6)
        camera = Camera2D.new(Vector2.new(0, 0), Vector2.new(0, 0), 0, 1)

        clear_and_draw do
          begin_mode2D(camera)
          draw_rectangle_rec(rectangle, RED)
          end_mode2D
        end

        assert_equal fixture_core_drawing_mode2D[0], get_screen_data.data
        clear_background(RAYWHITE)

        camera.offset.x = -2
        camera.offset.y = -2

        clear_and_draw do
          begin_mode2D(camera)
          draw_rectangle_rec(rectangle, RED)
          end_mode2D
        end

        assert_equal fixture_core_drawing_mode2D[1], get_screen_data.data
      end
    end
  end
end
