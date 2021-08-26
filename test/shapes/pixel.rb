class TestShapesPixel < MTest::Unit::TestCase
  def test_draw_pixel
    skip_unless_display_present

    init_window(10, 10, __method__.to_s)

    begin_drawing
    draw_pixel(2, 2, VIOLET)
    end_drawing

    assert_within 99, fixture_draw_pixel, get_screen_data.data

    close_window
  end

  def test_draw_pixel_v
    skip_unless_display_present

    init_window(10, 10, __method__.to_s)

    begin_drawing
    draw_pixel_v(Vector2.new(2, 2), VIOLET)
    end_drawing

    assert_within 99, fixture_draw_pixel, get_screen_data.data

    close_window
  end
end
