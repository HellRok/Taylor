class TestCamera2D < MTest::Unit::TestCase
  def test_initialize
    camera = Camera2D.new(Vector2.new(1, 2), Vector2.new(3, 4), 5, 6)

    assert_kind_of Camera2D, camera
    assert_equal 1, camera.offset.x
    assert_equal 2, camera.offset.y
    assert_equal 3, camera.target.x
    assert_equal 4, camera.target.y
    assert_equal 5, camera.rotation
    assert_equal 6, camera.zoom
  end

  def test_assignment

    camera = Camera2D.new(Vector2.new(0, 0), Vector2.new(0, 0), 0, 0)
    camera.offset.x = 6
    camera.offset.y = 5
    camera.target.x = 4
    camera.target.y = 3
    camera.rotation = 2
    camera.zoom = 1

    assert_equal 6, camera.offset.x
    assert_equal 5, camera.offset.y
    assert_equal 4, camera.target.x
    assert_equal 3, camera.target.y
    assert_equal 2, camera.rotation
    assert_equal 1, camera.zoom
  end

  def test_to_h
    camera = Camera2D.new(Vector2.new(1, 2), Vector2.new(3, 4), 5, 6)

    assert_equal(
      {
        offset: {
          x: 1,
          y: 2,
        },
        target: {
          x: 3,
          y: 4,
        },
        rotation: 5,
        zoom: 6,
      },
      camera.to_h
    )
  end

  def test_drawing
    skip_unless_display_present

    init_window(10, 10, __method__.to_s)
    set_target_fps 5
    rectangle = Rectangle.new(2, 2, 6, 6)
    camera = Camera2D.new(Vector2.new(0, 0), Vector2.new(0, 0), 0, 1)

    begin_drawing
    camera.drawing do
      draw_rectangle_rec(rectangle, RED)
    end
    end_drawing

    assert_equal fixture_camera2d_drawing[0], get_screen_data.data
    clear_background(RAYWHITE)

    camera.offset.x = -2
    camera.offset.y = -2

    begin_drawing
    camera.drawing do
      draw_rectangle_rec(rectangle, RED)
    end

    assert_equal fixture_camera2d_drawing[1], get_screen_data.data

    end_drawing
    close_window
  end
end
