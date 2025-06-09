class Test
  class Models
    class Colour_Test < Test::Base
      def test_initialize
        colour = Colour.new

        assert_kind_of Colour, colour
        assert_equal 0, colour.red
        assert_equal 0, colour.green
        assert_equal 0, colour.blue
        assert_equal 255, colour.alpha
      end

      def test_initialize_with_values
        colour = Colour.new(red: 1, green: 2, blue: 3, alpha: 4)

        assert_kind_of Colour, colour
        assert_equal 1, colour.red
        assert_equal 2, colour.green
        assert_equal 3, colour.blue
        assert_equal 4, colour.alpha
      end

      def test_brackets
        colour = Colour[]

        assert_kind_of Colour, colour
        assert_equal 0, colour.red
        assert_equal 0, colour.green
        assert_equal 0, colour.blue
        assert_equal 255, colour.alpha

        colour = Colour[1, 2, 3, 4]

        assert_kind_of Colour, colour
        assert_equal 1, colour.red
        assert_equal 2, colour.green
        assert_equal 3, colour.blue
        assert_equal 4, colour.alpha
      end

      def test_equal
        colour = Colour.new(red: 245, green: 245, blue: 245, alpha: 255)

        assert_true colour == Colour::RAYWHITE
      end

      def test_equal_another_type
        colour = Colour.new(red: 245, green: 245, blue: 245, alpha: 255)

        assert_false colour == Vector2[1, 2]
      end

      def test_assignment
        colour = Colour.new(red: 0, green: 0, blue: 0, alpha: 0)
        colour.red = 4
        colour.green = 3
        colour.blue = 2
        colour.alpha = 1

        assert_equal 4, colour.red
        assert_equal 3, colour.green
        assert_equal 2, colour.blue
        assert_equal 1, colour.alpha
      end

      def test_to_h
        colour = Colour.new(red: 1, green: 2, blue: 3, alpha: 4)

        assert_equal(
          {
            red: 1,
            green: 2,
            blue: 3,
            alpha: 4
          },
          colour.to_h
        )
      end

      def test_fade
        colour = Colour.new(red: 2, green: 3, blue: 4, alpha: 5)

        result = colour.fade(0.1)

        assert_not_equal result, colour

        assert_called [
          "(Fade) { color: { r: 2 g: 3 b: 4 a: 5 } alpha: 0.100000 }"
        ]
      end

      def test_fade_too_low
        colour = Colour.new(red: 3, green: 4, blue: 5, alpha: 6)

        assert_raise_with_message(ArgumentError, "Alpha must be within (0.0..1.0)") {
          colour.fade(-0.1)
        }

        assert_no_calls
      end

      def test_fade_too_high
        colour = Colour.new(red: 4, green: 5, blue: 6, alpha: 7)

        assert_raise_with_message(ArgumentError, "Alpha must be within (0.0..1.0)") {
          colour.fade(1.1)
        }

        assert_no_calls
      end

      def test_fade!
        colour = Colour.new(red: 2, green: 3, blue: 4, alpha: 5)

        result = colour.fade!(0.1)

        assert_equal result, colour

        assert_called [
          "(Fade) { color: { r: 2 g: 3 b: 4 a: 5 } alpha: 0.100000 }"
        ]
      end

      def test_fade_bang_too_low
        colour = Colour.new(red: 3, green: 4, blue: 5, alpha: 6)

        assert_raise_with_message(ArgumentError, "Alpha must be within (0.0..1.0)") {
          colour.fade!(-0.1)
        }

        assert_no_calls
      end

      def test_fade_bang_too_high
        colour = Colour.new(red: 4, green: 5, blue: 6, alpha: 7)

        assert_raise_with_message(ArgumentError, "Alpha must be within (0.0..1.0)") {
          colour.fade!(1.1)
        }

        assert_no_calls
      end
    end
  end
end
