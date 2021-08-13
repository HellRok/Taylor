class TestShapesTriangle < MTest::Unit::TestCase
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

    assert_within 99, fixture_draw_triangle, get_screen_data.data

    close_window
  end

  def test_draw_triangle_lines
    init_window(10, 10, 'hi')

    begin_drawing
    draw_triangle_lines(
      Vector2.new(5, 0),
      Vector2.new(0, 7),
      Vector2.new(10, 7),
      BLUE
    )
    end_drawing

    assert_within 99, fixture_draw_triangle_lines, get_screen_data.data

    close_window
  end
end
