class Test
  class Core_Test < Test::Base
    # def test_clear_background
    #  skip_unless_display_present

    #  set_window_title(__method__.to_s)

    #  clear_and_draw do
    #    clear_background(Colour::RED)
    #  end

    #  assert_equal fixture_clear_background, get_screen_data.data
    # end

    # def test_window_position
    #  skip_unless_display_present
    #  skip "No window access for browsers" if browser?

    #  set_window_title(__method__.to_s)
    #  set_target_fps 5

    #  set_window_position 50, 50
    #  flush_frame
    #  assert_equal Vector2.new(50, 50), get_window_position

    #  set_window_position 70, 70
    #  flush_frame
    #  assert_equal Vector2.new(70, 70), get_window_position
    # end

    # def test_set_window_size
    #  skip_unless_display_present

    #  set_window_title(__method__.to_s)
    #  set_target_fps 5

    #  flush_frame
    #  assert_equal 10, Window.width
    #  assert_equal 10, Window.height

    #  set_window_size 128, 48

    #  flush_frames 5
    #  assert_equal 128, Window.width
    #  assert_equal 48, Window.height
    # ensure
    #  reset_window if Window.ready?
    # end

    # def test_clipboard
    #  skip_unless_display_present
    #  skip "No clipboard access for webbrowsers" if browser?

    #  set_window_title(__method__.to_s)

    #  set_clipboard_text("TEST STRING")
    #  assert_equal "TEST STRING", get_clipboard_text
    # end
  end
end
