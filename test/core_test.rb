class Test
  class Core_Test < MTest::Unit::TestCaseWithAnalytics
    def test_clear_background
      skip_unless_display_present

      set_window_title(__method__.to_s)

      clear_and_draw do
        clear_background(Colour::RED)
      end

      assert_equal fixture_clear_background, get_screen_data.data
    end

    def test_set_window_state_fullscreen
      skip_unless_display_present
      skip "No window access for browsers" if browser?

      set_window_title(__method__.to_s)
      set_target_fps 5

      current_monitor = get_current_monitor
      set_window_size get_monitor_width(current_monitor), get_monitor_height(current_monitor)
      flush_frame

      assert_false window_state?(FLAG_FULLSCREEN_MODE)

      set_window_state(FLAG_FULLSCREEN_MODE)
      flush_frame

      assert_true window_state?(FLAG_FULLSCREEN_MODE)
      assert_true window_fullscreen?

      clear_window_state(FLAG_FULLSCREEN_MODE)
      flush_frame

      assert_false window_state?(FLAG_FULLSCREEN_MODE)
    ensure
      reset_window if window_ready?
    end

    def test_set_window_state_hidden
      skip_unless_display_present
      skip "No window access for browsers" if browser?

      set_window_title(__method__.to_s)
      set_target_fps 5

      assert_false window_state?(FLAG_WINDOW_HIDDEN)

      set_window_state(FLAG_WINDOW_HIDDEN)
      flush_frame

      assert_true window_state?(FLAG_WINDOW_HIDDEN)
      assert_true window_hidden?

      clear_window_state(FLAG_WINDOW_HIDDEN)
      flush_frame

      assert_false window_state?(FLAG_WINDOW_HIDDEN)
    ensure
      reset_window if window_ready?
    end

    def test_set_window_state_minimised
      skip_unless_display_present
      skip "No window access for browsers" if browser?

      set_window_title(__method__.to_s)

      assert_false window_state?(FLAG_WINDOW_MINIMISED)

      set_target_fps 5
      set_window_state(FLAG_WINDOW_MINIMISED)
      # Need to actually wait for the window to minimise
      flush_frames 5

      assert_true window_state?(FLAG_WINDOW_MINIMISED)
      assert_true window_minimised?
    ensure
      reset_window if window_ready?
    end

    def test_set_window_state_maximised
      skip_unless_display_present
      skip "No window access for browsers" if browser?

      set_window_title(__method__.to_s)

      assert_false window_state?(FLAG_WINDOW_MAXIMISED)

      set_window_state(FLAG_WINDOW_MAXIMISED | FLAG_WINDOW_RESIZABLE)
      flush_frame

      assert_true window_state?(FLAG_WINDOW_MAXIMISED)
      assert_true window_maximised?

      clear_window_state(FLAG_WINDOW_MAXIMISED)
      flush_frame
      restore_window
      flush_frame
      set_window_size(10, 10)

      assert_false window_state?(FLAG_WINDOW_MAXIMISED)
    ensure
      reset_window if window_ready?
    end

    def test_set_window_state_other
      skip_unless_display_present
      skip "No window access for browsers" if browser?

      set_window_title(__method__.to_s)
      set_target_fps 5

      [
        FLAG_WINDOW_ALWAYS_RUN,
        FLAG_WINDOW_RESIZABLE,
        FLAG_WINDOW_TOPMOST,
        FLAG_WINDOW_UNDECORATED
      ].each do |state|
        set_window_state(state)
        flush_frame

        assert_true window_state?(state)

        clear_window_state(state)
        flush_frame

        assert_false window_state?(state)
      ensure
        reset_window if window_ready?
      end
    end

    def test_window_position
      skip_unless_display_present
      skip "No window access for browsers" if browser?

      set_window_title(__method__.to_s)
      set_target_fps 5

      set_window_position 50, 50
      flush_frame
      assert_equal Vector2.new(50, 50), get_window_position

      set_window_position 70, 70
      flush_frame
      assert_equal Vector2.new(70, 70), get_window_position
    end

    def test_set_window_size
      skip_unless_display_present

      set_window_title(__method__.to_s)
      set_target_fps 5

      flush_frame
      assert_equal 10, Window.width
      assert_equal 10, Window.height

      set_window_size 128, 48

      flush_frames 5
      assert_equal 128, Window.width
      assert_equal 48, Window.height
    ensure
      reset_window if window_ready?
    end

    def test_clipboard
      skip_unless_display_present
      skip "No clipboard access for webbrowsers" if browser?

      set_window_title(__method__.to_s)

      set_clipboard_text("TEST STRING")
      assert_equal "TEST STRING", get_clipboard_text
    end
  end
end
