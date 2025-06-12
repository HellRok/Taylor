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

      # def test_draw_circle
      #  Circle[1, 2, 3, 4].draw(origin: Vector2[5, 6], rotation: 7, colour: Colour[8, 9, 10, 11])

      #  assert_called [
      #    "(DrawCirclePro) { rec: { x: 1.000000 y: 2.000000 width: 3.000000 height: 4.000000 } origin: { x: 5.000000 y: 6.000000 } rotation: 7.000000 color: { r: 8 g: 9 b: 10 a: 11 } }"
      #  ]
      # end

      # def test_draw_circle_with_outline_not_rounded
      #  Circle[2, 3, 4, 5].draw(thickness: 6, outline: true, colour: Colour[7, 8, 9, 10])

      #  assert_called [
      #    "(DrawCircleLinesEx) { rec: { x: 2.000000 y: 3.000000 width: 4.000000 height: 5.000000 } lineThick: 6.000000 color: { r: 7 g: 8 b: 9 a: 10 } }"
      #  ]
      # end

      # def test_draw_circle_no_outline_but_rounded
      #  Circle[3, 4, 5, 6].draw(rounded: true, radius: 0.5, segments: 7, colour: Colour[8, 9, 10, 11])

      #  assert_called [
      #    "(DrawCircleRounded) { rec: { x: 3.000000 y: 4.000000 width: 5.000000 height: 6.000000 } roundness: 0.500000 segments: 7 color: { r: 8 g: 9 b: 10 a: 11 } }"
      #  ]
      # end

      # def test_draw_circle_with_outline_and_rounded
      #  Circle[4, 5, 6, 7].draw(
      #    rounded: true, radius: 0.85, segments: 8, outline: true, thickness: 9, colour: Colour[10, 11, 12, 13]
      #  )

      #  assert_called [
      #    "(DrawCircleRoundedLines) { rec: { x: 4.000000 y: 5.000000 width: 6.000000 height: 7.000000 } roundness: 0.850000 segments: 8 lineThick: 9.000000 color: { r: 10 g: 11 b: 12 a: 13 } }"
      #  ]
      # end

      # def test_draw_circle_raises_when_radius_below_zero
      #  assert_raise_with_message(ArgumentError, "Radius must be within (0.0..1.0)") {
      #    Circle.new(2, 2, 6, 6).draw(rounded: true, radius: -0.1)
      #  }

      #  assert_no_calls
      # end

      # def test_draw_circle_raises_when_radius_above_one
      #  assert_raise_with_message(ArgumentError, "Radius must be within (0.0..1.0)") {
      #    Circle.new(2, 2, 6, 6).draw(rounded: true, radius: 1.1)
      #  }

      #  assert_no_calls
      # end
    end
  end
end
