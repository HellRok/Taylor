class Test
  class Models
    class Circle_Test < Test::Base
      def test_initialize
        circle = Circle.new(x: 1, y: 2, radius: 3, colour: Colour[4, 5, 6, 7])

        assert_kind_of Circle, circle
        assert_equal 1, circle.x
        assert_equal 2, circle.y
        assert_equal 3, circle.radius
        assert_equal Colour[4, 5, 6, 7], circle.colour
        assert_nil circle.outline
        assert_equal 1, circle.thickness
        assert_nil circle.gradient
      end

      def test_initialize_with_optional_args
        circle = Circle.new(x: 2, y: 3, radius: 4, colour: Colour[5, 6, 7, 8], outline: Colour[9, 10, 11, 12], thickness: 13, gradient: Colour[13, 14, 15, 16])

        assert_kind_of Circle, circle
        assert_equal 2, circle.x
        assert_equal 3, circle.y
        assert_equal 4, circle.radius
        assert_equal Colour[5, 6, 7, 8], circle.colour
        assert_equal Colour[9, 10, 11, 12], circle.outline
        assert_equal 13, circle.thickness
        assert_equal Colour[13, 14, 15, 16], circle.gradient
      end

      def test_initialize_with_invalid_radius
        assert_raise_with_message(ArgumentError, "Radius must be greater than 0") {
          Circle.new(x: 0, y: 0, radius: 0, colour: Colour[0, 0, 0, 0])
        }
      end

      # def test_brackets
      #   circle = Circle[1, 2, 3, 4]

      #   assert_kind_of Circle, circle
      #   assert_equal 1, circle.x
      #   assert_equal 2, circle.y
      #   assert_equal 3, circle.width
      #   assert_equal 4, circle.height
      # end

      def test_assignment
        circle = Circle.new(x: 3, y: 4, radius: 5, colour: Colour[6, 7, 8, 9], outline: Colour[10, 11, 12, 13], thickness: 14, gradient: Colour[14, 15, 16, 17])
        circle.x = 4
        circle.y = 5
        circle.radius = 6
        circle.colour = Colour[7, 8, 9, 10]
        circle.outline = Colour[11, 12, 13, 14]
        circle.thickness = 15
        circle.gradient = Colour[15, 16, 17, 18]

        assert_equal 4, circle.x
        assert_equal 5, circle.y
        assert_equal 6, circle.radius
        assert_equal Colour[7, 8, 9, 10], circle.colour
        assert_equal Colour[11, 12, 13, 14], circle.outline
        assert_equal 15, circle.thickness
        assert_equal Colour[15, 16, 17, 18], circle.gradient

        circle.outline = nil
        circle.gradient = nil

        assert_nil circle.outline
        assert_nil circle.gradient
      end

      def test_assignment_with_invalid_radius
        circle = Circle.new(x: 0, y: 0, radius: 1, colour: Colour[0, 0, 0, 0])
        assert_raise_with_message(ArgumentError, "Radius must be greater than 0") {
          circle.radius = 0
        }
      end

      def test_to_h
        circle = Circle.new(
          x: 4, y: 5, radius: 6,
          colour: Colour[7, 8, 9, 10],
          outline: Colour[11, 12, 13, 14], thickness: 15,
          gradient: Colour[16, 17, 18, 19]
        )

        assert_equal(
          {
            x: 4,
            y: 5,
            radius: 6,
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
            gradient: {
              red: 16,
              green: 17,
              blue: 18,
              alpha: 19
            }
          },
          circle.to_h
        )
      end

      def test_draw_circle
        Circle.new(x: 1, y: 2, radius: 3, colour: Colour[4, 5, 6, 7]).draw

        assert_called [
          "(DrawCircle) { centerX: 1 centerY: 2 radius: 3.000000 color: { r: 4 g: 5 b: 6 a: 7 } }"
        ]
      end

      def test_draw_circle_with_outline
        Circle.new(x: 2, y: 3, radius: 4, colour: Colour[5, 6, 7, 8], outline: Colour[9, 10, 11, 12], thickness: 13).draw

        assert_called [
          "(DrawCircle) { centerX: 2 centerY: 3 radius: 4.000000 color: { r: 5 g: 6 b: 7 a: 8 } }",
          "(DrawPolyLinesEx) { center: { x: 2.000000 y: 3.000000 } sides: 60 radius: 4.000000 rotation: 0.000000 lineThick: 13.000000 color: { r: 9 g: 10 b: 11 a: 12 } }"
        ]
      end

      def test_draw_circle_with_gradient
        Circle.new(x: 3, y: 4, radius: 5, colour: Colour[6, 7, 8, 9], gradient: Colour[10, 11, 12, 13]).draw

        assert_called [
          "(DrawCircleGradient) { centerX: 3 centerY: 4 radius: 5.000000 color1: { r: 6 g: 7 b: 8 a: 9 } color2: { r: 10 g: 11 b: 12 a: 13 } }"
        ]
      end

      def test_draw_circle_with_outline_and_gradient
        Circle.new(x: 4, y: 5, radius: 6, colour: Colour[7, 8, 9, 10], outline: Colour[11, 12, 13, 14], thickness: 15, gradient: Colour[16, 17, 18, 19]).draw

        assert_called [
          "(DrawCircleGradient) { centerX: 4 centerY: 5 radius: 6.000000 color1: { r: 7 g: 8 b: 9 a: 10 } color2: { r: 16 g: 17 b: 18 a: 19 } }",
          "(DrawPolyLinesEx) { center: { x: 4.000000 y: 5.000000 } sides: 60 radius: 6.000000 rotation: 0.000000 lineThick: 15.000000 color: { r: 11 g: 12 b: 13 a: 14 } }"
        ]
      end

      def test_draw_with_toggling
        circle = Circle.new(x: 1, y: 2, radius: 3, colour: Colour[4, 5, 6, 7])

        circle.draw

        assert_called [
          "(DrawCircle) { centerX: 1 centerY: 2 radius: 3.000000 color: { r: 4 g: 5 b: 6 a: 7 } }"
        ]

        circle.outline = Colour[5, 6, 7, 8]
        circle.draw

        assert_called [
          "(DrawCircle) { centerX: 1 centerY: 2 radius: 3.000000 color: { r: 4 g: 5 b: 6 a: 7 } }",
          "(DrawPolyLinesEx) { center: { x: 1.000000 y: 2.000000 } sides: 60 radius: 3.000000 rotation: 0.000000 lineThick: 1.000000 color: { r: 5 g: 6 b: 7 a: 8 } }"
        ]

        circle.outline = nil
        circle.gradient = Colour[6, 7, 8, 9]
        circle.draw
        assert_called [
          "(DrawCircleGradient) { centerX: 1 centerY: 2 radius: 3.000000 color1: { r: 4 g: 5 b: 6 a: 7 } color2: { r: 6 g: 7 b: 8 a: 9 } }"
        ]

        circle.gradient = nil
        circle.draw
        assert_called [
          "(DrawCircle) { centerX: 1 centerY: 2 radius: 3.000000 color: { r: 4 g: 5 b: 6 a: 7 } }"
        ]
      end
    end
  end
end
