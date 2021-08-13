class TestShapesLine < MTest::Unit::TestCase
  def test_draw_line
    init_window(10, 10, 'hi')

    begin_drawing
    draw_line(0, 0, 10, 10, GREEN)
    end_drawing

    assert_within 99, fixture_draw_line, get_screen_data.data

    close_window
  end

  def test_draw_line_v
    init_window(10, 10, 'hi')

    begin_drawing
    draw_line_v(Vector2.new(0, 0), Vector2.new(10, 10), GREEN)
    end_drawing

    assert_within 99, fixture_draw_line, get_screen_data.data

    close_window
  end

  def test_draw_line_ex
    init_window(10, 10, 'hi')

    begin_drawing
    draw_line_ex(Vector2.new(0, 0), Vector2.new(10, 10), 3, GREEN)
    end_drawing

    assert_within 99, fixture_draw_line_ex, get_screen_data.data

    close_window
  end

  def test_draw_line_bezier
    init_window(10, 10, 'hi')

    begin_drawing
    draw_line_bezier(Vector2.new(0, 0), Vector2.new(10, 10), 1, GREEN)
    end_drawing

    assert_within 99, fixture_draw_line_bezier, get_screen_data.data

    close_window
  end

  def test_draw_line_bezier_quad
    init_window(10, 10, 'hi')

    begin_drawing
    draw_line_bezier_quad(Vector2.new(0, 0), Vector2.new(10, 10), Vector2.new(7, 3), 1, GREEN)
    end_drawing

    assert_within 99, fixture_draw_line_bezier_quad, get_screen_data.data

    close_window
  end
end
