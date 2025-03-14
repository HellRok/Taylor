class Test
  class Models
    class Window_Test < MTest::Unit::TestCaseWithAnalytics
      def test_open
        assert_equal 10, Window.width
        assert_equal 10, Window.height
        assert_equal "Taylor Test Suite", Window.title

        Window.close

        Window.open(
          width: 12,
          height: 15,
          title: "Some other title"
        )

        assert_equal 12, Window.width
        assert_equal 15, Window.height
        assert_equal "Some other title", Window.title
      ensure
        reset_window
      end

      def test_close?
        skip "xdotool not available" unless XDo.available?

        assert_equal false, Window.close?

        XDo::Key.press "Escape"
        flush_frame

        assert_equal true, Window.close?
      end

      def test_ready?
        assert_true Window.ready?

        Window.close
        assert_false Window.ready?

        Window.open(width: 10, height: 10, title: "Taylor Test Suite")
        assert_true Window.ready?
      end

      def test_fullscreen?
        skip_unless_display_present
        skip "No window access for browsers" if browser?

        # This just makes it less buggy, and also if you run these out of XVFB
        # it's less jarring and won't mess up your display.
        current_monitor = get_current_monitor
        set_window_size get_monitor_width(current_monitor), get_monitor_height(current_monitor)
        flush_frame

        assert_false Window.flag?(Window::Flag::FULLSCREEN)
        assert_false Window.fullscreen?

        Window.flags = Window::Flag::FULLSCREEN
        flush_frame

        assert_true Window.flag?(Window::Flag::FULLSCREEN)
        assert_true Window.fullscreen?

        Window.clear_flag(Window::Flag::FULLSCREEN)
        flush_frame

        assert_false Window.flag?(Window::Flag::FULLSCREEN)
        assert_false Window.fullscreen?
      ensure
        reset_window if Window.ready?
      end

      def test_hidden?
        skip_unless_display_present
        skip "No window access for browsers" if browser?

        assert_false Window.flag?(Window::Flag::HIDDEN)
        assert_false Window.hidden?

        Window.flags = Window::Flag::HIDDEN
        flush_frame

        assert_true Window.flag?(Window::Flag::HIDDEN)
        assert_true Window.hidden?

        Window.clear_flag(Window::Flag::HIDDEN)
        flush_frame

        assert_false Window.flag?(Window::Flag::HIDDEN)
        assert_false Window.hidden?
      ensure
        reset_window if Window.ready?
      end

      def test_minimised?
        skip_unless_display_present
        skip "No window access for browsers" if browser?

        assert_false Window.flag?(Window::Flag::MINIMISED)
        assert_false Window.minimised?

        Window.flags = Window::Flag::MINIMISED
        flush_frame

        assert_true Window.flag?(Window::Flag::MINIMISED)
        assert_true Window.minimised?
      ensure
        reset_window if Window.ready?
      end

      def test_maximised?
        skip_unless_display_present
        skip "No window access for browsers" if browser?

        assert_false Window.flag?(Window::Flag::MAXIMISED)
        assert_false Window.maximised?

        Window.flags = Window::Flag::RESIZABLE | Window::Flag::MAXIMISED
        flush_frame

        assert_true Window.flag?(Window::Flag::MAXIMISED)
        assert_true Window.maximised?

        Window.clear_flag(Window::Flag::MAXIMISED)

        flush_frame
        restore_window
        flush_frame

        assert_false Window.flag?(Window::Flag::MAXIMISED)
        assert_false Window.maximised?
      ensure
        reset_window if Window.ready?
      end

      def test_always_run?
        skip_unless_display_present
        skip "No window access for browsers" if browser?

        assert_false Window.flag?(Window::Flag::ALWAYS_RUN)
        assert_false Window.always_run?

        Window.flags = Window::Flag::ALWAYS_RUN
        flush_frame

        assert_true Window.flag?(Window::Flag::ALWAYS_RUN)
        assert_true Window.always_run?

        Window.clear_flag(Window::Flag::ALWAYS_RUN)
        flush_frame

        assert_false Window.flag?(Window::Flag::ALWAYS_RUN)
        assert_false Window.always_run?
      ensure
        reset_window if Window.ready?
      end

      def test_resizable?
        skip_unless_display_present
        skip "No window access for browsers" if browser?

        assert_false Window.flag?(Window::Flag::RESIZABLE)
        assert_false Window.resizable?

        Window.flags = Window::Flag::RESIZABLE
        flush_frame

        assert_true Window.flag?(Window::Flag::RESIZABLE)
        assert_true Window.resizable?

        Window.clear_flag(Window::Flag::RESIZABLE)
        flush_frame

        assert_false Window.flag?(Window::Flag::RESIZABLE)
        assert_false Window.resizable?
      ensure
        reset_window if Window.ready?
      end

      def test_always_on_top?
        skip_unless_display_present
        skip "No window access for browsers" if browser?

        assert_false Window.flag?(Window::Flag::ALWAYS_ON_TOP)
        assert_false Window.always_on_top?

        Window.flags = Window::Flag::ALWAYS_ON_TOP
        flush_frame

        assert_true Window.flag?(Window::Flag::ALWAYS_ON_TOP)
        assert_true Window.always_on_top?

        Window.clear_flag(Window::Flag::ALWAYS_ON_TOP)
        flush_frame

        assert_false Window.flag?(Window::Flag::ALWAYS_ON_TOP)
        assert_false Window.always_on_top?
      ensure
        reset_window if Window.ready?
      end

      def test_undecorated?
        skip_unless_display_present
        skip "No window access for browsers" if browser?

        assert_false Window.flag?(Window::Flag::UNDECORATED)
        assert_false Window.undecorated?

        Window.flags = Window::Flag::UNDECORATED
        flush_frame

        assert_true Window.flag?(Window::Flag::UNDECORATED)
        assert_true Window.undecorated?

        Window.clear_flag(Window::Flag::UNDECORATED)
        flush_frame

        assert_false Window.flag?(Window::Flag::UNDECORATED)
        assert_false Window.undecorated?
      ensure
        reset_window if Window.ready?
      end

      def test_vsync_hinted?
        skip_unless_display_present
        skip "No window access for browsers" if browser?

        assert_false Window.flag?(Window::Flag::VSYNC_HINT)
        assert_false Window.vsync_hinted?

        Window.flags = Window::Flag::VSYNC_HINT
        flush_frame

        assert_true Window.flag?(Window::Flag::VSYNC_HINT)
        assert_true Window.vsync_hinted?

        Window.clear_flag(Window::Flag::VSYNC_HINT)
        flush_frame

        assert_false Window.flag?(Window::Flag::VSYNC_HINT)
        assert_false Window.vsync_hinted?
      ensure
        reset_window if Window.ready?
      end

      def test_msaa_4x_hinted?
        skip_unless_display_present
        skip "No window access for browsers" if browser?

        assert_false Window.flag?(Window::Flag::MSAA_4X_HINT)
        assert_false Window.msaa_4x_hinted?

        reset_window do
          Window.config = Window::Flag::MSAA_4X_HINT
        end

        assert_true Window.flag?(Window::Flag::MSAA_4X_HINT)
        assert_true Window.msaa_4x_hinted?
      ensure
        reset_window if Window.ready?
      end

      def test_interlaced_hinted?
        skip_unless_display_present
        skip "No window access for browsers" if browser?

        assert_false Window.flag?(Window::Flag::INTERLACED_HINT)
        assert_false Window.interlaced_hinted?

        reset_window do
          Window.config = Window::Flag::INTERLACED_HINT
        end

        assert_true Window.flag?(Window::Flag::INTERLACED_HINT)
        assert_true Window.interlaced_hinted?
      ensure
        reset_window if Window.ready?
      end

      def test_unfocused?
        skip_unless_display_present
        skip "No window access for browsers" if browser?

        assert_false Window.flag?(Window::Flag::UNFOCUSED)
        assert_false Window.unfocused?
        assert_true Window.focused?

        # Minimise to simulate a user switching away
        Window.flags = Window::Flag::MINIMISED
        flush_frame

        assert_true Window.flag?(Window::Flag::UNFOCUSED)
        assert_true Window.unfocused?
        assert_false Window.focused?
      ensure
        reset_window if Window.ready?
      end

      def test_transparent?
        skip_unless_display_present
        skip "No window access for browsers" if browser?

        assert_false Window.flag?(Window::Flag::TRANSPARENT)
        assert_false Window.transparent?

        reset_window do
          Window.config = Window::Flag::TRANSPARENT
        end

        assert_true Window.flag?(Window::Flag::TRANSPARENT)
        assert_true Window.transparent?
      ensure
        reset_window if Window.ready?
      end

      def test_high_dpi?
        skip_unless_display_present
        skip "No window access for browsers" if browser?

        assert_false Window.flag?(Window::Flag::HIGH_DPI)
        assert_false Window.high_dpi?

        reset_window do
          Window.config = Window::Flag::HIGH_DPI
        end

        assert_true Window.flag?(Window::Flag::HIGH_DPI)
        assert_true Window.high_dpi?
      ensure
        reset_window if Window.ready?
      end
    end
  end
end
