class TestShapesCircle < MTest::Unit::TestCase
  def test_draw_circle
    skip_unless_display_present

    set_window_title(__method__.to_s)

    clear_and_draw do
      draw_circle(5, 5, 3, PURPLE)
    end

    assert_within 99, fixture_draw_circle, get_screen_data.data
  end

  def test_draw_circle_v
    skip_unless_display_present

    set_window_title(__method__.to_s)

    clear_and_draw do
      draw_circle_v(Vector2.new(5, 5), 3, PURPLE)
    end

    assert_within 99, fixture_draw_circle, get_screen_data.data
  end

  def test_draw_circle_sector
    skip_unless_display_present

    set_window_title(__method__.to_s)

    clear_and_draw do
      draw_circle_sector(
        Vector2.new(5, 5),
        5,
        180,
        270,
        8,
        PURPLE)
    end

    assert_within 99, fixture_draw_circle_sector, get_screen_data.data
  end

  def test_draw_circle_sector_lines
    skip_unless_display_present

    set_window_title(__method__.to_s)

    clear_and_draw do
      draw_circle_sector_lines(
        Vector2.new(5, 5),
        5,
        180,
        270,
        8,
        PURPLE)
    end

    assert_within 98, fixture_draw_circle_sector_lines, get_screen_data.data
  end

  def test_draw_circle_gradient
    skip_unless_display_present

    set_window_title(__method__.to_s)

    clear_and_draw do
      draw_circle_gradient(5, 5, 3, PURPLE, GREEN)
    end

    assert_within 99, fixture_draw_circle_gradient, get_screen_data.data
  end

  def test_draw_lines
    skip_unless_display_present

    set_window_title(__method__.to_s)

    clear_and_draw do
      draw_circle_lines(5, 5, 3, PURPLE)
    end

    assert_within 99, fixture_draw_circle_lines, get_screen_data.data
  end
end
