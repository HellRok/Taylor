class TestShapesTriangle < MTest::Unit::TestCase
  def test_draw_triangle
    skip_unless_display_present

    set_window_title(__method__.to_s)

    clear_and_draw do
      draw_triangle(
        Vector2.new(5, 0),
        Vector2.new(0, 7),
        Vector2.new(10, 7),
        BLUE
      )
    end

    assert_within 99, fixture_draw_triangle, get_screen_data.data
  end

  def test_draw_triangle_lines
    skip_unless_display_present

    set_window_title(__method__.to_s)

    clear_and_draw do
      draw_triangle_lines(
        Vector2.new(5, 0),
        Vector2.new(0, 7),
        Vector2.new(10, 7),
        BLUE
      )
    end

    # TODO: I have to come back and figure out why there is such a big
    # discrepancy of my desktop here.
    assert_within 93, fixture_draw_triangle_lines, get_screen_data.data
  end
end
