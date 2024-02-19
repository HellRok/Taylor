class Test
  class Models
    class Colour_Test < MTest::Unit::TestCaseWithAnalytics
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

        assert_equal Colour::RAYWHITE, colour
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
    end
  end
end
