class TestShapesRectangle < MTest::Unit::TestCase
  def test_draw_rectangle
    skip_unless_display_present

    init_window(10, 10, __method__.to_s)

    begin_drawing
    draw_rectangle(2, 2, 4, 5, RED)
    end_drawing

    assert_within 99, fixture_draw_rectangle, get_screen_data.data

    close_window
  end

  def test_draw_rectangle_rec
    skip_unless_display_present

    init_window(10, 10, __method__.to_s)
    rectangle = Rectangle.new(2, 2, 4, 5)

    begin_drawing
    draw_rectangle_rec(rectangle, RED)
    end_drawing

    assert_within 99, fixture_draw_rectangle, get_screen_data.data

    close_window
  end

  def test_draw_rectangle_gradient_v
    skip_unless_display_present

    init_window(10, 10, __method__.to_s)

    begin_drawing
    draw_rectangle_gradient_v(1, 1, 8, 8, RED, YELLOW)
    end_drawing

    assert_within 99, fixture_draw_rectangle_gradient_v, get_screen_data.data

    close_window
  end

  def test_draw_rectangle_gradient_h
    skip_unless_display_present

    init_window(10, 10, __method__.to_s)

    begin_drawing
    draw_rectangle_gradient_h(1, 1, 8, 8, RED, YELLOW)
    end_drawing

    assert_within 99, fixture_draw_rectangle_gradient_h, get_screen_data.data

    close_window
  end

  def test_draw_rectangle_gradient_ex
    skip_unless_display_present

    init_window(10, 10, __method__.to_s)

    begin_drawing
    draw_rectangle_gradient_ex(Rectangle.new(1, 1, 8, 8), RED, YELLOW, GREEN, BLUE)
    end_drawing

    assert_within 99, fixture_draw_rectangle_gradient_ex, get_screen_data.data

    close_window
  end

  def test_draw_rectangle_lines
    skip_unless_display_present

    init_window(10, 10, __method__.to_s)

    begin_drawing
    draw_rectangle_lines(2, 2, 4, 5, RED)
    end_drawing

    assert_within 99, fixture_draw_rectangle_lines, get_screen_data.data

    close_window
  end

  def test_draw_rectangle_lines_ex
    skip_unless_display_present

    init_window(10, 10, __method__.to_s)

    begin_drawing
    draw_rectangle_lines_ex(Rectangle.new(2, 2, 8, 8), 2, RED)
    end_drawing

    assert_within 99, fixture_draw_rectangle_lines_ex, get_screen_data.data

    close_window
  end

  def test_draw_rectangle_pro
    skip_unless_display_present

    init_window(10, 10, __method__.to_s)

    begin_drawing
    draw_rectangle_pro(Rectangle.new(2, 2, 5, 5), Vector2.new(0, 0), 45, RED)
    end_drawing

    assert_within 99, fixture_draw_rectangle_pro, get_screen_data.data

    close_window
  end

  def test_draw_rectangle_rounded
    skip_unless_display_present

    init_window(10, 10, __method__.to_s)

    begin_drawing
    draw_rectangle_rounded(Rectangle.new(1, 1, 8, 8), 0.5, 8, RED)
    end_drawing

    assert_within 99, fixture_draw_rectangle_rounded, get_screen_data.data

    close_window
  end

  def test_draw_rectangle_rounded_lines
    skip_unless_display_present

    init_window(10, 10, __method__.to_s)

    begin_drawing
    draw_rectangle_rounded_lines(Rectangle.new(2, 2, 6, 6), 0.5, 8, 2, RED)
    end_drawing

    assert_within 99, fixture_draw_rectangle_rounded_lines, get_screen_data.data

    close_window
  end
end
