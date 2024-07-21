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
        XDo::Mouse.button_up(XDo::Mouse::BUTTON[:right]) if XDo.available?
      end
    end
  end
end
