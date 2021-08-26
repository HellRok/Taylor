class TestShapesRing < MTest::Unit::TestCase
  def test_draw_ring
    skip_unless_display_present

    init_window(10, 10, __method__.to_s)

    begin_drawing
    draw_ring(Vector2.new(5, 5), 2, 4, 90, 180, 8, PURPLE)
    end_drawing

    assert_within 99, fixture_draw_ring, get_screen_data.data

    close_window
  end

  def test_draw_ring_lines
    skip_unless_display_present

    init_window(10, 10, __method__.to_s)

    begin_drawing
    draw_ring_lines(Vector2.new(5, 5), 2, 4, 90, 180, 8, PURPLE)
    end_drawing

    assert_within 99, fixture_draw_ring_lines, get_screen_data.data

    close_window
  end
end
