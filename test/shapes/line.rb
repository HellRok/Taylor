class TestShapesLine < MTest::Unit::TestCase
  def test_draw_line
    skip_unless_display_present

    init_window(10, 10, __method__.to_s)

    begin_drawing
    draw_line(0, 0, 10, 10, GREEN)
    end_drawing

    assert_within 99, fixture_draw_line, get_screen_data.data

    close_window
  end

  def test_draw_line_v
    skip_unless_display_present

    init_window(10, 10, __method__.to_s)

    begin_drawing
    draw_line_v(Vector2.new(0, 0), Vector2.new(10, 10), GREEN)
    end_drawing

    assert_within 99, fixture_draw_line, get_screen_data.data

    close_window
  end

  def test_draw_line_ex
    skip_unless_display_present

    init_window(10, 10, __method__.to_s)

    begin_drawing
    draw_line_ex(Vector2.new(0, 0), Vector2.new(10, 10), 3, GREEN)
    end_drawing

    assert_within 99, fixture_draw_line_ex, get_screen_data.data

    close_window
  end

  def test_draw_line_bezier
    skip_unless_display_present

    init_window(10, 10, __method__.to_s)

    begin_drawing
    draw_line_bezier(Vector2.new(0, 0), Vector2.new(10, 10), 1, GREEN)
    end_drawing

    assert_within 99, fixture_draw_line_bezier, get_screen_data.data

    close_window
  end

  def test_draw_line_bezier_quad
    skip_unless_display_present

    init_window(10, 10, __method__.to_s)

    begin_drawing
    draw_line_bezier_quad(Vector2.new(0, 0), Vector2.new(10, 10), Vector2.new(7, 3), 1, GREEN)
    end_drawing

    assert_within 99, fixture_draw_line_bezier_quad, get_screen_data.data

    close_window
  end
end
