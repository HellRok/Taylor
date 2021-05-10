class TestCore < MTest::Unit::TestCase
  def test_init_window
    init_window(10, 10, 'hi')
    assert_equal fixture_init_window, get_screen_data.data
    close_window
  end

  def test_clear_background
    init_window(10, 10, 'hi')
    clear_background(RED)
    assert_equal fixture_clear_background, get_screen_data.data
    close_window
  end

  def test_get_world_to_screen2D
    init_window(10, 10, 'hi')
    vector = Vector2.new(5, 5)
    camera = Camera2D.new(Vector2.new(0, 0), Vector2.new(0, 0), 0, 1)

    assert_equal Vector2.new(5, 5), get_world_to_screen2D(vector, camera)

    camera.target.x = 5
    camera.target.y = 5

    assert_equal Vector2.new(0, 0), get_world_to_screen2D(vector, camera)

    close_window
  end

  def test_get_screen_to_world2D
    init_window(10, 10, 'hi')
    vector = Vector2.new(5, 5)
    camera = Camera2D.new(Vector2.new(0, 0), Vector2.new(0, 0), 0, 1)

    assert_equal Vector2.new(5, 5), get_screen_to_world2D(vector, camera)

    camera.target.x = 5
    camera.target.y = 5

    assert_equal Vector2.new(10, 10), get_screen_to_world2D(vector, camera)

    close_window
  end

  def test_mode2D
    init_window(10, 10, 'hi')
    rectangle = Rectangle.new(2, 2, 6, 6)
    camera = Camera2D.new(Vector2.new(0, 0), Vector2.new(0, 0), 0, 1)

    begin_drawing
    begin_mode2D(camera)
    draw_rectangle_rec(rectangle, RED)
    end_mode2D
    end_drawing

    assert_equal fixture_mode2D[0], get_screen_data.data
    clear_background(RAYWHITE)

    camera.offset.x = -2
    camera.offset.y = -2

    begin_drawing
    begin_mode2D(camera)
    draw_rectangle_rec(rectangle, RED)
    end_mode2D
    end_drawing

    assert_equal fixture_mode2D[1], get_screen_data.data

    close_window
  end
end
