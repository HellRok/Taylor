class TestShapes < MTest::Unit::TestCase
  def test_draw_line
    init_window(10, 10, 'hi')

    begin_drawing
    draw_line(0, 0, 10, 10, GREEN)
    end_drawing

    assert_equal fixture_draw_line, get_screen_data.data

    close_window
  end

  def test_draw_circle
    init_window(10, 10, 'hi')

    begin_drawing
    draw_circle(5, 5, 3, PURPLE)
    end_drawing

    assert_equal fixture_draw_circle, get_screen_data.data

    close_window
  end

  def test_draw_circle_v
    init_window(10, 10, 'hi')

    begin_drawing
    draw_circle_v(Vector2.new(5, 5), 3, PURPLE)
    end_drawing

    assert_equal fixture_draw_circle, get_screen_data.data

    close_window
  end

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

  def test_draw_triangle
    init_window(10, 10, 'hi')

    begin_drawing
    draw_triangle(
      Vector2.new(5, 0),
      Vector2.new(0, 7),
      Vector2.new(10, 7),
      BLUE
    )
    end_drawing

    assert_equal fixture_draw_triangle, get_screen_data.data

    close_window
  end

  def test_check_collision_point_rec
    rectangle = Rectangle.new(2, 2, 4, 5)

    assert_false check_collision_point_rec(Vector2.new(0, 0), rectangle)
    assert_true  check_collision_point_rec(Vector2.new(2, 2), rectangle)
    assert_true  check_collision_point_rec(Vector2.new(4, 4), rectangle)
    assert_false check_collision_point_rec(Vector2.new(7, 8), rectangle)
  end
end
