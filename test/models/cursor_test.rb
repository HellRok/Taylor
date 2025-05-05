class Test
  class Models
    class Cursor_Test < Test::Base
      def test_show
        Cursor.show
        assert_called ["(ShowCursor) { }"]
      end

      def test_hide
        Cursor.hide
        assert_called ["(HideCursor) { }"]
      end

      def test_hidden?
        Cursor.hidden?
        assert_called ["(IsCursorHidden) { }"]
      end

      def test_enable
        Cursor.enable
        assert_called ["(EnableCursor) { }"]
      end

      def test_disable
        Cursor.disable
        assert_called ["(DisableCursor) { }"]
      end

      def test_disabled?
        Cursor.disable
        assert_true Cursor.disabled?
        Cursor.enable
        assert_false Cursor.disabled?
      end

      def test_on_screen?
        Cursor.on_screen?
        assert_called ["(IsCursorOnScreen) { }"]
      end

      def test_icon=
        assert_equal Cursor::DEFAULT, Cursor.icon

        Cursor.icon = Cursor::CROSSHAIR
        assert_equal Cursor::CROSSHAIR, Cursor.icon
        assert_called ["(SetMouseCursor) { cursor: 3 }"]
      ensure
        Cursor.icon = Cursor::DEFAULT
      end

      def test_icon_equals_too_low
        assert_equal Cursor::DEFAULT, Cursor.icon

        begin
          Cursor.icon = -1
        rescue ArgumentError => e
          assert_equal "Must be within (0..10)", e.message
          assert_called []
        end

        assert_equal Cursor::DEFAULT, Cursor.icon
      ensure
        Cursor.icon = Cursor::DEFAULT
      end

      def test_icon_equals_too_high
        assert_equal Cursor::DEFAULT, Cursor.icon

        begin
          Cursor.icon = 11
        rescue ArgumentError => e
          assert_equal "Must be within (0..10)", e.message
          assert_called []
        end

        assert_equal Cursor::DEFAULT, Cursor.icon
      ensure
        Cursor.icon = Cursor::DEFAULT
      end
    end
  end
end
