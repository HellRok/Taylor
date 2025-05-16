class Test
  class Models
    class Rectangle_Test < Test::Base
      def test_initialize
        rectangle = Rectangle.new(1, 2, 3, 4)

        assert_kind_of Rectangle, rectangle
        assert_equal 1, rectangle.x
        assert_equal 2, rectangle.y
        assert_equal 3, rectangle.width
        assert_equal 4, rectangle.height
      end

      def test_brackets
        rectangle = Rectangle[1, 2, 3, 4]

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
        Rectangle[1, 2, 3, 4].draw(origin: Vector2[5, 6], rotation: 7, colour: Colour[8, 9, 10, 11])

        assert_called [
          "(DrawRectanglePro) { rec: { x: 1.000000 y: 2.000000 width: 3.000000 height: 4.000000 } origin: { x: 5.000000 y: 6.000000 } rotation: 7.000000 color: { r: 8 g: 9 b: 10 a: 11 } }"
        ]
      end

      def test_draw_rectangle_with_outline_not_rounded
        Rectangle[2, 3, 4, 5].draw(thickness: 6, outline: true, colour: Colour[7, 8, 9, 10])

        assert_called [
          "(DrawRectangleLinesEx) { rec: { x: 2.000000 y: 3.000000 width: 4.000000 height: 5.000000 } lineThick: 6.000000 color: { r: 7 g: 8 b: 9 a: 10 } }"
        ]
      end

      def test_draw_rectangle_no_outline_but_rounded
        Rectangle[3, 4, 5, 6].draw(rounded: true, radius: 0.5, segments: 7, colour: Colour[8, 9, 10, 11])

        assert_called [
          "(DrawRectangleRounded) { rec: { x: 3.000000 y: 4.000000 width: 5.000000 height: 6.000000 } roundness: 0.500000 segments: 7 color: { r: 8 g: 9 b: 10 a: 11 } }"
        ]
      end

      def test_draw_rectangle_with_outline_and_rounded
        Rectangle[4, 5, 6, 7].draw(
          rounded: true, radius: 0.85, segments: 8, outline: true, thickness: 9, colour: Colour[10, 11, 12, 13]
        )

        assert_called [
          "(DrawRectangleRoundedLines) { rec: { x: 4.000000 y: 5.000000 width: 6.000000 height: 7.000000 } roundness: 0.850000 segments: 8 lineThick: 9.000000 color: { r: 10 g: 11 b: 12 a: 13 } }"
        ]
      end

      def test_draw_rectangle_raises_when_radius_below_zero
        assert_raise_with_message(ArgumentError, "Radius must be within (0.0..1.0)") {
          Rectangle.new(2, 2, 6, 6).draw(rounded: true, radius: -0.1)
        }

        assert_no_calls
      end

      def test_draw_rectangle_raises_when_radius_above_one
        assert_raise_with_message(ArgumentError, "Radius must be within (0.0..1.0)") {
          Rectangle.new(2, 2, 6, 6).draw(rounded: true, radius: 1.1)
        }

        assert_no_calls
      end
    end
  end
end
