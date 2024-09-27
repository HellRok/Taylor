class Test
  class Models
    class Mouse_Test < MTest::Unit::TestCaseWithAnalytics
      def test_pressed?
        skip "xdotool not available" unless XDo.available?

        set_window_position(50, 50)
        XDo::Mouse.move_to(55, 55)
        flush_frame

        assert_false Mouse.pressed?(Mouse::LEFT), "When no mouse button is pressed"

        XDo::Mouse.button_down(XDo::Mouse::BUTTON[:left])
        flush_frame

        assert_true Mouse.pressed?(Mouse::LEFT), "When the mouse button has been pressed since last frame"

        flush_frame
        assert_false Mouse.pressed?(Mouse::LEFT), "But we only report it once"
      ensure
        XDo::Mouse.button_up(XDo::Mouse::BUTTON[:left]) if XDo.available?
        flush_frame
      end

      def test_down?
        skip "xdotool not available" unless XDo.available?

        set_window_position(50, 50)
        XDo::Mouse.move_to(55, 55)
        flush_frame

        assert_false Mouse.down?(Mouse::LEFT), "When no mouse button is pressed"

        XDo::Mouse.button_down(XDo::Mouse::BUTTON[:left])
        flush_frame

        assert_true Mouse.down?(Mouse::LEFT), "When the mouse button is held down"
        flush_frame
        assert_true Mouse.down?(Mouse::LEFT), "And it reports true for multiple frames"

        XDo::Mouse.button_up(XDo::Mouse::BUTTON[:left]) if XDo.available?
        flush_frame

        assert_false Mouse.down?(Mouse::LEFT), "Then reports false when released"
      ensure
        XDo::Mouse.button_up(XDo::Mouse::BUTTON[:left]) if XDo.available?
        flush_frame
      end

      def test_released?
        skip "xdotool not available" unless XDo.available?

        set_window_position(50, 50)
        XDo::Mouse.move_to(55, 55)
        flush_frame

        assert_false Mouse.released?(Mouse::LEFT), "When no mouse button is released"

        XDo::Mouse.button_down(XDo::Mouse::BUTTON[:left])
        flush_frame
        XDo::Mouse.button_up(XDo::Mouse::BUTTON[:left])
        flush_frame

        assert_true Mouse.released?(Mouse::LEFT), "When the mouse button has been released since last frame"

        flush_frame
        assert_false Mouse.released?(Mouse::LEFT), "But we only report it once"
      ensure
        XDo::Mouse.button_up(XDo::Mouse::BUTTON[:left]) if XDo.available?
        flush_frame
      end

      def test_up?
        skip "xdotool not available" unless XDo.available?

        set_window_position(50, 50)
        XDo::Mouse.move_to(55, 55)
        flush_frame

        assert_true Mouse.up?(Mouse::LEFT), "When no mouse button is pressed"

        XDo::Mouse.button_down(XDo::Mouse::BUTTON[:left])
        flush_frame

        assert_false Mouse.up?(Mouse::LEFT), "When the mouse button is held down"
        flush_frame
        assert_false Mouse.up?(Mouse::LEFT), "And it reports false for multiple frames"

        XDo::Mouse.button_up(XDo::Mouse::BUTTON[:left]) if XDo.available?
        flush_frame

        assert_true Mouse.up?(Mouse::LEFT), "Then reports true when released"
      ensure
        XDo::Mouse.button_up(XDo::Mouse::BUTTON[:left]) if XDo.available?
        flush_frame
      end

      def test_position
        skip "xdotool not available" unless XDo.available?

        set_window_position(50, 50)
        XDo::Mouse.move_to(55, 55)
        flush_frame

        assert_equal Vector2[5, 5], Mouse.position

        XDo::Mouse.move_to(59, 57)
        flush_frame
        assert_equal Vector2[9, 7], Mouse.position
      end

      def test_position=
        Mouse.position = Vector2[4, 8]
        assert_equal Vector2[4, 8], Mouse.position, "The mouse position has been set"

        Mouse.position = Vector2[6, 3]
        assert_equal Vector2[6, 3], Mouse.position, "The mouse position has been set again"
      end

      def test_offset=
        Mouse.position = Vector2[1, 1]
        Mouse.offset = Vector2[2, 3]
        assert_equal Vector2[3, 4], Mouse.position, "The mouse has been offset by 2, 3"

        skip "xdotool not available" unless XDo.available?

        set_window_position(50, 50)
        XDo::Mouse.move_to(55, 55)
        flush_frame

        assert_equal Vector2[7, 8], Mouse.position, "The mouse continues to be offset by 2, 3"
      ensure
        Mouse.offset = Vector2[0, 0]
      end
    end
  end
end
