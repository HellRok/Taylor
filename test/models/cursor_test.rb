class Test
  class Models
    class Cursor_Test < MTest::Unit::TestCaseWithAnalytics
      def test_show
        assert_false Cursor.hidden?
        Cursor.hide
        assert_true Cursor.hidden?
        Cursor.show
        assert_false Cursor.hidden?
      ensure
        Cursor.show
      end

      def test_hide
        assert_false Cursor.hidden?
        Cursor.hide
        assert_true Cursor.hidden?
      ensure
        Cursor.show
      end

      def test_hidden?
        assert_false Cursor.hidden?
        Cursor.hide
        assert_true Cursor.hidden?
        Cursor.show
        assert_false Cursor.hidden?
      ensure
        Cursor.show
      end
    end
  end
end
