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

      def test_on_screen?
        skip "xdotool not available" unless XDo.available?

        XDo::Mouse.move_to(0, 0)
        set_window_position(50, 50)
        flush_frame
        assert_false Cursor.on_screen?

        XDo::Mouse.move_to(55, 55)
        flush_frame
        assert_true Cursor.on_screen?
      end

      def test_icon=
        assert_equal Cursor::DEFAULT, Cursor.icon

        Cursor.icon = Cursor::CROSSHAIR
        assert_equal Cursor::CROSSHAIR, Cursor.icon
      ensure
        Cursor.icon = Cursor::DEFAULT
      end

      def test_icon_equals_too_low
        assert_equal Cursor::DEFAULT, Cursor.icon

        begin
          Cursor.icon = -1
        rescue ArgumentError => e
          assert_equal "Must be within (0..10)", e.message
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
        end

        assert_equal Cursor::DEFAULT, Cursor.icon
      ensure
        Cursor.icon = Cursor::DEFAULT
      end
    end
  end
end
