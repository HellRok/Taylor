class Test
  class Models
    class Line_Test < Test::Base
      def test_initialize
        line = Line.new(start: Vector2[0, 1], end: Vector2[2, 3], colour: Colour[4, 5, 6, 7])

        assert_kind_of Line, line
        assert_equal Vector2[0, 1], line.start
        assert_equal Vector2[2, 3], line.end
        assert_equal Colour[4, 5, 6, 7], line.colour
        assert_equal 1, line.thickness
      end

      def test_initialize_with_optional_args
        line = Line.new(start: Vector2[1, 2], end: Vector2[3, 4], colour: Colour[5, 6, 7, 8], thickness: 9)

        assert_kind_of Line, line
        assert_equal Vector2[1, 2], line.start
        assert_equal Vector2[3, 4], line.end
        assert_equal Colour[5, 6, 7, 8], line.colour
        assert_equal 9, line.thickness
      end

      def test_initialize_with_invalid_thickness
        assert_raise_with_message(ArgumentError, "Thickness must be greater than 0") {
          Line.new(start: Vector2[0, 0], end: Vector2[0, 0], colour: Colour[0, 0, 0, 0], thickness: 0)
        }
      end

      # def test_brackets
      #   line = Line[1, 2, 3, Colour::GREEN]

      #   assert_kind_of Line, line
      #   assert_equal 1, line.x
      #   assert_equal 2, line.y
      #   assert_equal 3, line.radius
      #   assert_equal Colour::GREEN, line.colour
      # end

      def test_assignment
        line = Line.new(start: Vector2[0, 0], end: Vector2[0, 0], colour: Colour[0, 0, 0, 0], thickness: 1)
        line.start.x = 2
        line.start.y = 3
        line.end.x = 4
        line.end.y = 5
        line.colour = Colour[6, 7, 8, 9]
        line.thickness = 10

        assert_equal 2, line.start.x
        assert_equal 3, line.start.y
        assert_equal 4, line.end.x
        assert_equal 5, line.end.y
        assert_equal Colour[6, 7, 8, 9], line.colour
        assert_equal 10, line.thickness
      end

      def test_assignment_with_invalid_thickness
        line = Line.new(start: Vector2[0, 0], end: Vector2[0, 0], colour: Colour[0, 0, 0, 0], thickness: 1)
        assert_raise_with_message(ArgumentError, "Thickness must be greater than 0") {
          line.thickness = 0
        }
      end

      # def test_to_h
      #   line = Line.new(
      #     x: 4, y: 5, radius: 6,
      #     colour: Colour[7, 8, 9, 10],
      #     outline: Colour[11, 12, 13, 14], thickness: 15,
      #     gradient: Colour[16, 17, 18, 19]
      #   )

      #   assert_equal(
      #     {
      #       x: 4,
      #       y: 5,
      #       radius: 6,
      #       colour: {
      #         red: 7,
      #         green: 8,
      #         blue: 9,
      #         alpha: 10
      #       },
      #       outline: {
      #         red: 11,
      #         green: 12,
      #         blue: 13,
      #         alpha: 14
      #       },
      #       thickness: 15,
      #       gradient: {
      #         red: 16,
      #         green: 17,
      #         blue: 18,
      #         alpha: 19
      #       }
      #     },
      #     line.to_h
      #   )
      # end

      # def test_draw_line
      #   Line.new(x: 1, y: 2, radius: 3, colour: Colour[4, 5, 6, 7]).draw

      #   assert_called [
      #     "(DrawLine) { centerX: 1 centerY: 2 radius: 3.000000 color: { r: 4 g: 5 b: 6 a: 7 } }"
      #   ]
      # end
    end
  end
end
