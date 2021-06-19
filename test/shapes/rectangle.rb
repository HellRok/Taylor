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
end
