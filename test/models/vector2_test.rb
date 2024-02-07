class Test
  class Models
    class Vector2_Test < MTest::Unit::TestCaseWithAnalytics
      def test_initialize
        vector = Vector2.new(1, 2)

        assert_kind_of Vector2, vector
        assert_equal 1, vector.x
        assert_equal 2, vector.y
      end

      def test_brackets
        vector = Vector2[3, 4]

        assert_kind_of Vector2, vector
        assert_equal 3, vector.x
        assert_equal 4, vector.y
      end

      def test_assignment
        vector = Vector2.new(0, 0)
        vector.x = 3
        vector.y = 8

        assert_equal 3, vector.x
        assert_equal 8, vector.y
      end

      def test_aliases
        vector = Vector2.new(12, 13)

        assert_equal vector.x, vector.width
        assert_equal 12, vector.width

        assert_equal vector.y, vector.height
        assert_equal 13, vector.height
      end

      def test_add
        vector = Vector2.new(1, 3) + Vector2.new(2, 5)

        assert_kind_of Vector2, vector
        assert_equal 3, vector.x
        assert_equal 8, vector.y
      end

      def test_minus
        vector = Vector2.new(1, 3) - Vector2.new(2, 5)

        assert_kind_of Vector2, vector
        assert_equal(-1, vector.x)
        assert_equal(-2, vector.y)
      end

      def test_multiplier
        vector = Vector2.new(1, 3)
        vector *= 4

        assert_kind_of Vector2, vector
        assert_equal 4, vector.x
        assert_equal 12, vector.y
      end

      def test_divisor
        vector = Vector2.new(2, 3)
        vector /= 2

        assert_kind_of Vector2, vector
        assert_equal 1, vector.x
        assert_equal 1.5, vector.y
      end

      def test_length
        assert_equal 5, Vector2.new(3, -4).length
      end

      def test_to_h
        assert_equal({x: 3, y: -4}, Vector2.new(3, -4).to_h)
      end
    end
  end
end
