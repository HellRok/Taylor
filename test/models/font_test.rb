class Test
  class Models
    class Font_Test < MTest::Unit::TestCaseWithAnalytics
      def test_initialize
        font = Font.new("./assets/tiny.ttf")

        assert_kind_of Font, font
        assert_equal 32, font.size
        assert_equal 95, font.glyph_count
        assert_equal 4, font.glyph_padding
      end

      def test_initialize_with_args
        font = Font.new("./assets/tiny.ttf", size: 6, glyph_count: 100)

        assert_kind_of Font, font
        assert_equal 6, font.size
        assert_equal 100, font.glyph_count
        assert_equal 4, font.glyph_padding
      end

      def test_to_h
        font = Font.new("./assets/tiny.ttf")

        assert_equal(32, font.to_h[:size])
        assert_equal(95, font.to_h[:glyph_count])
        assert_equal(4, font.to_h[:glyph_padding])
      end
    end
  end
end
