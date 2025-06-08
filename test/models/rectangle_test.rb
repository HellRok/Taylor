class Test
  class Models
    class Rectangle_Test < MTest::Unit::TestCaseWithAnalytics
      def test_initialize
        rectangle = Rectangle.new(1, 2, 3, 4)

        assert_kind_of Rectangle, rectangle
        assert_equal 1, rectangle.x
        assert_equal 2, rectangle.y
        assert_equal 3, rectangle.width
        assert_equal 4, rectangle.height
      end

      def test_assignment
        rectangle = Rectangle.new(0, 0, 0, 0)
        rectangle.x = 4
        rectangle.y = 3
        rectangle.width = 2
        rectangle.height = 1

        assert_equal 4, rectangle.x
        assert_equal 3, rectangle.y
        assert_equal 2, rectangle.width
        assert_equal 1, rectangle.height
      end

      def test_to_h
        rectangle = Rectangle.new(1, 2, 3, 4)

        assert_equal(
          {
            x: 1,
            y: 2,
            width: 3,
            height: 4
          },
          rectangle.to_h
        )
      end

      def test_draw_rectangle
        skip_unless_display_present

        set_window_title(__method__.to_s)

        clear_and_draw do
          Rectangle.new(2, 2, 5, 5).draw(origin: Vector2::ZERO, rotation: 45, colour: Colour::RED)
        end

        assert_within 99, fixture_draw_rectangle_pro, get_screen_data.data
      end

      def test_draw_rectangle_with_outline_not_rounded
        skip_unless_display_present

        set_window_title(__method__.to_s)

        clear_and_draw do
          Rectangle.new(2, 2, 8, 8).draw(outline: true, colour: Colour::RED)
        end

        assert_within 99, fixture_draw_rectangle_lines_ex, get_screen_data.data
      end

      def test_draw_rectangle_no_outline_but_rounded
        skip_unless_display_present

        set_window_title(__method__.to_s)

        clear_and_draw do
          Rectangle.new(1, 1, 8, 8).draw(rounded: true, radius: 0.5, segments: 8, colour: Colour::RED)
        end

        assert_within 99, fixture_draw_rectangle_rounded, get_screen_data.data
      end

      def test_draw_rectangle_with_outline_and_rounded
        skip_unless_display_present

        set_window_title(__method__.to_s)

        clear_and_draw do
          Rectangle.new(2, 2, 6, 6).draw(
            rounded: true, radius: 0.5, segments: 8, outline: true, thickness: 2, colour: Colour::RED
          )
        end

        assert_within 99, fixture_draw_rectangle_rounded_lines, get_screen_data.data
      end

      def test_draw_rectangle_raises_when_radius_below_zero
        assert_raise(ArgumentError) {
          Rectangle.new(2, 2, 6, 6).draw(rounded: true, radius: -0.1)
        }
      end

      def test_draw_rectangle_raises_when_radius_above_one
        assert_raise(ArgumentError) {
          Rectangle.new(2, 2, 6, 6).draw(rounded: true, radius: 1.1)
        }
      end
    end
  end
end
