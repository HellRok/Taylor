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

      def test_enable
        assert_false Cursor.disabled?
        Cursor.disable
        assert_true Cursor.disabled?
        Cursor.enable
        assert_false Cursor.disabled?
      ensure
        Cursor.enable
      end

      def test_disable
        assert_false Cursor.disabled?
        Cursor.disable
        assert_true Cursor.disabled?
      ensure
        Cursor.enable
      end

      def test_disabled?
        assert_false Cursor.disabled?
        Cursor.disable
        assert_true Cursor.disabled?
        Cursor.enable
        assert_false Cursor.disabled?
      ensure
        Cursor.enable
      end
    end
  end
end
