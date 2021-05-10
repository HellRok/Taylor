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
end
