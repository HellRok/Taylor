class Test
  class Models
    class Font < MTest::Unit::TestCaseWithAnalytics
      def test_initialize
        font = Font.new(1, 2, 3)

        assert_kind_of Font, font
        assert_equal 1, font.base_size
        assert_equal 2, font.glyph_count
        assert_equal 3, font.glyph_padding
      end

      def test_assignment
        font = Font.new(0, 0, 0)
        font.base_size = 3
        font.glyph_count = 2
        font.glyph_padding = 1

        assert_equal 3, font.base_size
        assert_equal 2, font.glyph_count
        assert_equal 1, font.glyph_padding
      end

      def test_to_h
        font = Font.new(1, 2, 3)

        assert_equal(
          {
            base_size: 1,
            glyph_count: 2,
            glyph_padding: 3,
          },
          font.to_h
        )
      end
    end
  end
end
