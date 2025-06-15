class Test
  class Models
    class Rectangle_Test < Test::Base
      def test_initialize
        rectangle = Rectangle.new(x: 1, y: 2, width: 3, height: 4, colour: Colour[5, 6, 7, 8])

        assert_kind_of Rectangle, rectangle
        assert_equal 1, rectangle.x
        assert_equal 2, rectangle.y
        assert_equal 3, rectangle.width
        assert_equal 4, rectangle.height
        assert_equal Colour[5, 6, 7, 8], rectangle.colour
      end

      def test_initialize_with_arguments
        rectangle = Rectangle.new(x: 2, y: 3, width: 4, height: 5, colour: Colour[6, 7, 8, 9], outline: Colour[10, 11, 12, 13], thickness: 14, roundness: 0.5, segments: 15)

        assert_kind_of Rectangle, rectangle
        assert_equal 2, rectangle.x
        assert_equal 3, rectangle.y
        assert_equal 4, rectangle.width
        assert_equal 5, rectangle.height
        assert_equal Colour[6, 7, 8, 9], rectangle.colour
        assert_equal Colour[10, 11, 12, 13], rectangle.outline
        assert_equal 14, rectangle.thickness
        assert_equal 0.5, rectangle.roundness
        assert_equal 15, rectangle.segments
      end

      def test_initialize_thickness_too_low
        assert_raise_with_message(ArgumentError, "Thickness must be greater than 0") {
          Rectangle.new(x: 0, y: 0, width: 0, height: 0, colour: Colour[0, 0, 0, 0], thickness: 0)
        }
      end

      def test_initialize_roundness_too_low
        assert_raise_with_message(ArgumentError, "Roundness must be within (0.0..1.0)") {
          Rectangle.new(x: 0, y: 0, width: 0, height: 0, colour: Colour[0, 0, 0, 0], roundness: -0.1)
        }
      end

      def test_initialize_roundness_too_high
        assert_raise_with_message(ArgumentError, "Roundness must be within (0.0..1.0)") {
          Rectangle.new(x: 0, y: 0, width: 0, height: 0, colour: Colour[0, 0, 0, 0], roundness: 1.1)
        }
      end

      def test_initialize_segments_too_low
        assert_raise_with_message(ArgumentError, "Segments must be greater than 0") {
          Rectangle.new(x: 0, y: 0, width: 0, height: 0, colour: Colour[0, 0, 0, 0], segments: 0)
        }
      end

      def test_brackets
        rectangle = Rectangle[1, 2, 3, 4]

        assert_kind_of Rectangle, rectangle
        assert_equal 1, rectangle.x
        assert_equal 2, rectangle.y
        assert_equal 3, rectangle.width
        assert_equal 4, rectangle.height
        assert_equal Colour::BLACK, rectangle.colour
        assert_nil rectangle.outline
        assert_equal 1, rectangle.thickness
        assert_equal 0, rectangle.roundness
        assert_equal 6, rectangle.segments
      end

      def test_assignment
        rectangle = Rectangle.new(x: 0, y: 0, width: 0, height: 0, colour: Colour[0, 0, 0, 0], outline: Colour[0, 0, 0, 0], thickness: 1, roundness: 0, segments: 1)
        rectangle.x = 3
        rectangle.y = 4
        rectangle.width = 5
        rectangle.height = 6
        rectangle.colour = Colour[7, 8, 9, 10]
        rectangle.outline = Colour[11, 12, 13, 14]
        rectangle.thickness = 15
        rectangle.roundness = 1
        rectangle.segments = 16

        assert_equal 3, rectangle.x
        assert_equal 4, rectangle.y
        assert_equal 5, rectangle.width
        assert_equal 6, rectangle.height
        assert_equal Colour[7, 8, 9, 10], rectangle.colour
        assert_equal Colour[11, 12, 13, 14], rectangle.outline
        assert_equal 15, rectangle.thickness
        assert_equal 1, rectangle.roundness
        assert_equal 16, rectangle.segments
      end

      def test_assignment_thickness_too_low
        rectangle = Rectangle.new(x: 0, y: 0, width: 0, height: 0, colour: Colour[0, 0, 0, 0])

        assert_raise_with_message(ArgumentError, "Thickness must be greater than 0") {
          rectangle.thickness = -1
        }
      end

      def test_assignment_roundness_too_low
        rectangle = Rectangle.new(x: 0, y: 0, width: 0, height: 0, colour: Colour[0, 0, 0, 0])

        assert_raise_with_message(ArgumentError, "Roundness must be within (0.0..1.0)") {
          rectangle.roundness = -0.1
        }
      end

      def test_assignment_roundness_too_high
        rectangle = Rectangle.new(x: 0, y: 0, width: 0, height: 0, colour: Colour[0, 0, 0, 0])

        assert_raise_with_message(ArgumentError, "Roundness must be within (0.0..1.0)") {
          rectangle.roundness = 1.1
        }
      end

      def test_assignment_segments_too_low
        rectangle = Rectangle.new(x: 0, y: 0, width: 0, height: 0, colour: Colour[0, 0, 0, 0])

        assert_raise_with_message(ArgumentError, "Segments must be greater than 0") {
          rectangle.segments = 0
        }
      end

      def test_to_h
        rectangle = Rectangle.new(x: 3, y: 4, width: 5, height: 6, colour: Colour[7, 8, 9, 10], outline: Colour[11, 12, 13, 14], thickness: 15, roundness: 0.75, segments: 16)

        assert_equal(
          {
            x: 3,
            y: 4,
            width: 5,
            height: 6,
            colour: {
              red: 7,
              green: 8,
              blue: 9,
              alpha: 10
            },
            outline: {
              red: 11,
              green: 12,
              blue: 13,
              alpha: 14
            },
            thickness: 15,
            roundness: 0.75,
            segments: 16
          },
          rectangle.to_h
        )
      end

      # def test_draw_rectangle
      #  Rectangle[1, 2, 3, 4].draw(origin: Vector2[5, 6], rotation: 7, colour: Colour[8, 9, 10, 11])

      #  assert_called [
      #    "(DrawRectanglePro) { rec: { x: 1.000000 y: 2.000000 width: 3.000000 height: 4.000000 } origin: { x: 5.000000 y: 6.000000 } rotation: 7.000000 color: { r: 8 g: 9 b: 10 a: 11 } }"
      #  ]
      # end

      # def test_draw_rectangle_with_outline_not_rounded
      #  Rectangle[2, 3, 4, 5].draw(thickness: 6, outline: true, colour: Colour[7, 8, 9, 10])

      #  assert_called [
      #    "(DrawRectangleLinesEx) { rec: { x: 2.000000 y: 3.000000 width: 4.000000 height: 5.000000 } lineThick: 6.000000 color: { r: 7 g: 8 b: 9 a: 10 } }"
      #  ]
      # end

      # def test_draw_rectangle_no_outline_but_rounded
      #  Rectangle[3, 4, 5, 6].draw(rounded: true, radius: 0.5, segments: 7, colour: Colour[8, 9, 10, 11])

      #  assert_called [
      #    "(DrawRectangleRounded) { rec: { x: 3.000000 y: 4.000000 width: 5.000000 height: 6.000000 } roundness: 0.500000 segments: 7 color: { r: 8 g: 9 b: 10 a: 11 } }"
      #  ]
      # end

      # def test_draw_rectangle_with_outline_and_rounded
      #  Rectangle[4, 5, 6, 7].draw(
      #    rounded: true, radius: 0.85, segments: 8, outline: true, thickness: 9, colour: Colour[10, 11, 12, 13]
      #  )

      #  assert_called [
      #    "(DrawRectangleRoundedLines) { rec: { x: 4.000000 y: 5.000000 width: 6.000000 height: 7.000000 } roundness: 0.850000 segments: 8 lineThick: 9.000000 color: { r: 10 g: 11 b: 12 a: 13 } }"
      #  ]
      # end

      # def test_draw_rectangle_raises_when_radius_below_zero
      #  assert_raise_with_message(ArgumentError, "Radius must be within (0.0..1.0)") {
      #    Rectangle.new(2, 2, 6, 6).draw(rounded: true, radius: -0.1)
      #  }

      #  assert_no_calls
      # end

      # def test_draw_rectangle_raises_when_radius_above_one
      #  assert_raise_with_message(ArgumentError, "Radius must be within (0.0..1.0)") {
      #    Rectangle.new(2, 2, 6, 6).draw(rounded: true, radius: 1.1)
      #  }

      #  assert_no_calls
      # end
    end
  end
end
