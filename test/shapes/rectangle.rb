class TestShapesRectangle < MTest::Unit::TestCase
  def test_draw_rectangle
    init_window(10, 10, 'hi')

    begin_drawing
    draw_rectangle(2, 2, 4, 5, RED)
    end_drawing

    assert_equal fixture_draw_rectangle, get_screen_data.data

    close_window
  end

  def test_draw_rectangle_rec
    init_window(10, 10, 'hi')
    rectangle = Rectangle.new(2, 2, 4, 5)

    begin_drawing
    draw_rectangle_rec(rectangle, RED)
    end_drawing

    assert_equal fixture_draw_rectangle, get_screen_data.data

    close_window
  end

  def test_draw_rectangle_gradient_v
    init_window(10, 10, 'hi')

    begin_drawing
    draw_rectangle_gradient_v(1, 1, 8, 8, RED, YELLOW)
    end_drawing

    assert_equal fixture_draw_rectangle_gradient_v, get_screen_data.data

    close_window
  end

  def test_draw_rectangle_gradient_h
    init_window(10, 10, 'hi')

    begin_drawing
    draw_rectangle_gradient_h(1, 1, 8, 8, RED, YELLOW)
    end_drawing

    assert_equal fixture_draw_rectangle_gradient_h, get_screen_data.data

    close_window
  end

  def test_draw_rectangle_gradient_ex
    init_window(10, 10, 'hi')

    begin_drawing
    draw_rectangle_gradient_ex(Rectangle.new(1, 1, 8, 8), RED, YELLOW, GREEN, BLUE)
    end_drawing

    assert_equal fixture_draw_rectangle_gradient_ex, get_screen_data.data

    close_window
  end

  def test_draw_rectangle_lines
    init_window(10, 10, 'hi')

    begin_drawing
    draw_rectangle_lines(2, 2, 4, 5, RED)
    end_drawing

    assert_equal fixture_draw_rectangle_lines, get_screen_data.data

    close_window
  end

  def test_draw_rectangle_lines_ex
    init_window(10, 10, 'hi')

    begin_drawing
    draw_rectangle_lines_ex(Rectangle.new(2, 2, 8, 8), 2, RED)
    end_drawing

    assert_equal fixture_draw_rectangle_lines_ex, get_screen_data.data

    close_window
  end

  def test_draw_rectangle_pro
    init_window(10, 10, 'hi')

    begin_drawing
    draw_rectangle_pro(Rectangle.new(2, 2, 5, 5), Vector2.new(0, 0), 45, RED)
    end_drawing

    assert_equal fixture_draw_rectangle_pro, get_screen_data.data

    close_window
  end

  def test_draw_rectangle_rounded
    init_window(10, 10, 'hi')

    begin_drawing
    draw_rectangle_rounded(Rectangle.new(1, 1, 8, 8), 0.5, 8, RED)
    end_drawing

    assert_equal fixture_draw_rectangle_rounded, get_screen_data.data

    close_window
  end

  def test_draw_rectangle_rounded_lines
    init_window(10, 10, 'hi')

    begin_drawing
    draw_rectangle_rounded_lines(Rectangle.new(2, 2, 6, 6), 0.5, 8, 2, RED)
    end_drawing

    assert_equal fixture_draw_rectangle_rounded_lines, get_screen_data.data

    close_window
  end
end
