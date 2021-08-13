class TestShapesEllipse < MTest::Unit::TestCase
  def test_draw_ellipse
    init_window(10, 10, 'hi')

    begin_drawing
    draw_ellipse(5, 5, 3, 7, PURPLE)
    end_drawing

    assert_within 99, fixture_draw_ellipse, get_screen_data.data

    close_window
  end

  def test_draw_ellipse_lines
    init_window(10, 10, 'hi')

    begin_drawing
    draw_ellipse_lines(5, 5, 3, 5, PURPLE)
    end_drawing

    assert_within 99, fixture_draw_ellipse_lines, get_screen_data.data

    close_window
  end
end
