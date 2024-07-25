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
    end
  end
end
