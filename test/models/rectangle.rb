class TestRectangle < MTest::Unit::TestCase
  def test_initialize
    rectangle = Rectangle.new(1, 2, 3, 4)

    assert_kind_of Rectangle, rectangle
    assert_equal 1, rectangle.x
    assert_equal 2, rectangle.y
    assert_equal 3, rectangle.width
    assert_equal 4, rectangle.height
  end

  def test_assignment
    rectangle = Rectangle.new(0, 0, 0, 0)
    rectangle.x = 4
    rectangle.y = 3
    rectangle.width = 2
    rectangle.height = 1

    assert_equal 4, rectangle.x
    assert_equal 3, rectangle.y
    assert_equal 2, rectangle.width
    assert_equal 1, rectangle.height
  end

  def test_to_h
    rectangle = Rectangle.new(1, 2, 3, 4)

    assert_equal(
      {
        x: 1,
        y: 2,
        width: 3,
        height: 4
      },
      rectangle.to_h
    )
  end

  def test_draw_rectangle
    skip_unless_display_present

    init_window(10, 10, __method__.to_s)

    begin_drawing
    Rectangle.new(2, 2, 5, 5).draw(origin: Vector2::ZERO, rotation: 45, colour: RED)
    end_drawing

    assert_within 99, fixture_draw_rectangle_pro, get_screen_data.data

    close_window
  end

  def test_draw_rectangle_with_outline_not_rounded
    skip_unless_display_present

    init_window(10, 10, __method__.to_s)

    begin_drawing
    Rectangle.new(2, 2, 8, 8).draw(outline: true, colour: RED)
    end_drawing

    assert_within 99, fixture_draw_rectangle_lines_ex, get_screen_data.data

    close_window
  end

  def test_draw_rectangle_no_outline_but_rounded
    skip_unless_display_present

    init_window(10, 10, __method__.to_s)

    begin_drawing
    Rectangle.new(1, 1, 8, 8).draw(rounded: true, radius: 0.5, segments: 8, colour: RED)
    end_drawing

    assert_within 99, fixture_draw_rectangle_rounded, get_screen_data.data

    close_window
  end

  def test_draw_rectangle_with_outline_and_rounded
    skip_unless_display_present

    init_window(10, 10, __method__.to_s)

    begin_drawing
    Rectangle.new(2, 2, 6, 6).draw(
      rounded: true, radius: 0.5, segments: 8, outline: true, thickness: 2, colour: RED
    )
    end_drawing

    assert_within 99, fixture_draw_rectangle_rounded_lines, get_screen_data.data

    close_window
  end

  def test_draw_rectangle_raises_when_radius_below_zero
    assert_raise(ArgumentError) {
      Rectangle.new(2, 2, 6, 6).draw(rounded: true, radius: -0.1)
    }
  end

  def test_draw_rectangle_raises_when_radius_above_one
    assert_raise(ArgumentError) {
      Rectangle.new(2, 2, 6, 6).draw(rounded: true, radius: 1.1)
    }
  end
end
