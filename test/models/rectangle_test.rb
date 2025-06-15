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

      def test_draw_rectangle
        Rectangle.new(x: 4, y: 5, width: 6, height: 7, colour: Colour[8, 9, 10, 11]).draw

        assert_called [
          "(DrawRectangleRec) { rec: { x: 4.000000 y: 5.000000 width: 6.000000 height: 7.000000 } color: { r: 8 g: 9 b: 10 a: 11 } }"
        ]
      end

      def test_draw_rectangle_with_outline_not_rounded
        Rectangle.new(x: 5, y: 6, width: 7, height: 8, colour: Colour[9, 10, 11, 12], outline: Colour[13, 14, 15, 16], thickness: 17).draw

        assert_called [
          "(DrawRectangleRec) { rec: { x: 5.000000 y: 6.000000 width: 7.000000 height: 8.000000 } color: { r: 9 g: 10 b: 11 a: 12 } }",
          "(DrawRectangleLinesEx) { rec: { x: 5.000000 y: 6.000000 width: 7.000000 height: 8.000000 } lineThick: 17.000000 color: { r: 13 g: 14 b: 15 a: 16 } }"
        ]
      end

      def test_draw_rectangle_no_outline_but_rounded
        Rectangle.new(x: 6, y: 7, width: 8, height: 9, colour: Colour[10, 11, 12, 13], roundness: 0.14, segments: 15).draw

        assert_called [
          "(DrawRectangleRounded) { rec: { x: 6.000000 y: 7.000000 width: 8.000000 height: 9.000000 } roundness: 0.140000 segments: 15 color: { r: 10 g: 11 b: 12 a: 13 } }"
        ]
      end

      def test_draw_rectangle_with_outline_and_rounded
        Rectangle.new(x: 7, y: 8, width: 9, height: 10, colour: Colour[11, 12, 13, 14], outline: Colour[15, 16, 17, 18], thickness: 19, roundness: 0.20, segments: 21).draw

        assert_called [
          "(DrawRectangleRounded) { rec: { x: 7.000000 y: 8.000000 width: 9.000000 height: 10.000000 } roundness: 0.200000 segments: 21 color: { r: 11 g: 12 b: 13 a: 14 } }",
          "(DrawRectangleRoundedLines) { rec: { x: 7.000000 y: 8.000000 width: 9.000000 height: 10.000000 } roundness: 0.200000 segments: 21 lineThick: 19.000000 color: { r: 15 g: 16 b: 17 a: 18 } }"
        ]
      end
    end
  end
end
