class Test
  class Models
    class Colour < MTest::Unit::TestCaseWithAnalytics
      def test_initialize
        colour = Colour.new(1, 2, 3, 4)

        assert_kind_of Colour, colour
        assert_equal 1, colour.red
        assert_equal 2, colour.green
        assert_equal 3, colour.blue
        assert_equal 4, colour.alpha
      end

      def test_equal
        colour = Colour.new(245, 245, 245, 255)

        assert_equal RAYWHITE, colour
      end

      def test_assignment
        colour = Colour.new(0, 0, 0, 0)
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
        colour = Colour.new(1, 2, 3, 4)

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
