class TestCore < MTest::Unit::TestCase
  def test_clear_background
    skip_unless_display_present

    set_window_title(__method__.to_s)
    clear_and_draw do
      clear_background(RED)
    end
    assert_equal fixture_clear_background, get_screen_data.data
  end

  def test_get_world_to_screen2D
    skip_unless_display_present

    set_window_title(__method__.to_s)
    vector = Vector2.new(5, 5)
    camera = Camera2D.new(Vector2.new(0, 0), Vector2.new(0, 0), 0, 1)

    assert_equal Vector2.new(5, 5), get_world_to_screen2D(vector, camera)

    camera.target.x = 5
    camera.target.y = 5

    assert_equal Vector2.new(0, 0), get_world_to_screen2D(vector, camera)
  end

  def test_get_screen_to_world2D
    skip_unless_display_present

    set_window_title(__method__.to_s)
    vector = Vector2.new(5, 5)
    camera = Camera2D.new(Vector2.new(0, 0), Vector2.new(0, 0), 0, 1)

    assert_equal Vector2.new(5, 5), get_screen_to_world2D(vector, camera)

    camera.target.x = 5
    camera.target.y = 5

    assert_equal Vector2.new(10, 10), get_screen_to_world2D(vector, camera)
  end

  def test_set_window_state_fullscreen
    skip_unless_display_present

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
    if window_ready?
      clear_window_state(FLAG_FULLSCREEN_MODE)
      set_window_size(10, 10)
      flush_frame
    end
  end

  def test_set_window_state_hidden
    skip_unless_display_present

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
    clear_window_state(FLAG_WINDOW_HIDDEN) if window_ready?
  end

  def test_set_window_state_minimised
    skip_unless_display_present

    set_window_title(__method__.to_s)

    assert_false window_state?(FLAG_WINDOW_MINIMISED)

    set_target_fps 5
    set_window_state(FLAG_WINDOW_MINIMISED)
    # Need to actually wait for the window to minimise
    flush_frames 5

    assert_true window_state?(FLAG_WINDOW_MINIMISED)
    assert_true window_minimised?
  ensure
    restore_window if window_ready?
  end

  def test_set_window_state_maximised
    skip_unless_display_present

    set_window_title(__method__.to_s)

    assert_false window_state?(FLAG_WINDOW_MAXIMISED)

    set_window_state(FLAG_WINDOW_MAXIMISED | FLAG_WINDOW_RESIZABLE)
    flush_frame

    assert_true window_state?(FLAG_WINDOW_MAXIMISED)
    assert_true window_maximised?

    restore_window
    set_window_size(10, 10)
    flush_frame

    assert_false window_state?(FLAG_WINDOW_MAXIMISED)

  ensure
    if window_ready?
      clear_window_state(FLAG_WINDOW_MAXIMISED | FLAG_WINDOW_RESIZABLE)
      set_window_size(10, 10)
      flush_frame
    end
  end

  def test_set_window_state_other
    skip_unless_display_present

    set_window_title(__method__.to_s)
    set_target_fps 5

    [
      FLAG_WINDOW_ALWAYS_RUN,
      FLAG_WINDOW_RESIZABLE,
      FLAG_WINDOW_TOPMOST,
      FLAG_WINDOW_UNDECORATED,
    ].each do |state|
      set_window_state(state)
      flush_frame

      assert_true window_state?(state)

      clear_window_state(state)
      flush_frame

      assert_false window_state?(state)
    ensure
      clear_window_state(state) if window_ready?
    end
  end

  def test_window_position
    skip_unless_display_present

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
    assert_equal 10, get_screen_width
    assert_equal 10, get_screen_height

    set_window_size 64, 48

    flush_frames 5
    assert_equal 64, get_screen_width
    assert_equal 48, get_screen_height
  ensure
    if window_ready?
      set_window_size 10, 10
      flush_frame
    end
  end

  def test_clipboard
    skip_unless_display_present

    set_window_title(__method__.to_s)

    set_clipboard_text('TEST STRING')
    assert_equal 'TEST STRING', get_clipboard_text
  end
end
