class TestText < MTest::Unit::TestCase
  def test_draw_text
    skip_unless_display_present

    init_window(10, 10, __method__.to_s)
    draw_text('a', 0, 0, 10, BLACK)
    flush_frame

    assert_equal fixture_draw_text, get_screen_data.data
    close_window
  end

  def test_draw_text_ex
    skip_unless_display_present

    init_window(10, 10, __method__.to_s)
    font = load_font('./test/assets/tiny.ttf')
    draw_text_ex(font, 'x', Vector2.new(0, 0), 12, 0, BLACK)
    flush_frame

    assert_within 97, fixture_draw_text_ex, get_screen_data.data
    close_window
  end
end
