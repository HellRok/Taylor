class TestShapesPixel < MTest::Unit::TestCase
  def test_draw_pixel
    init_window(10, 10, 'hi')

    begin_drawing
    draw_pixel(2, 2, VIOLET)
    end_drawing

    assert_equal fixture_draw_pixel, get_screen_data.data

    close_window
  end

  def test_draw_pixel_v
    init_window(10, 10, 'hi')

    begin_drawing
    draw_pixel_v(Vector2.new(2, 2), VIOLET)
    end_drawing

    assert_equal fixture_draw_pixel, get_screen_data.data

    close_window
  end
end
