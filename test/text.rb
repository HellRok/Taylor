class TestText < MTest::Unit::TestCase
  def test_draw_text
    skip_unless_display_present

    set_window_title(__method__.to_s)
    clear_and_draw do
      draw_text('a', 0, 0, 10, BLACK)
    end

    assert_equal fixture_draw_text, get_screen_data.data
  end

  def test_draw_text_ex
    skip_unless_display_present

    set_window_title(__method__.to_s)
    font = Font.load('./assets/tiny.ttf')
    clear_and_draw do
      draw_text_ex(font, 'x', Vector2.new(0, 0), 12, 0, BLACK)
    end

    assert_within 97, fixture_draw_text_ex, get_screen_data.data
    font.unload
  end

  def test_measure_text_ex
    skip_unless_display_present

    set_window_title(__method__.to_s)
    font = Font.load('./assets/tiny.ttf')
    size = measure_text_ex(font, 'hello', 12, 0)
    flush_frame

    assert_equal 31.125, size.x
    assert_equal 12, size.y
    font.unload
  end
end
