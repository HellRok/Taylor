class TestCamera2D < MTest::Unit::TestCase
  def test_initialize
    camera = Camera2D.new(Vector2.new(1, 2), Vector2.new(3, 4), 5, 6)

    assert_kind_of Camera2D, camera
    assert camera.offset.x      == 1
    assert camera.offset.y      == 2
    assert camera.target.x      == 3
    assert camera.target.y      == 4
    assert camera.rotation      == 5
    assert camera.zoom          == 6
  end

  def test_assignment

    camera = Camera2D.new(Vector2.new(0, 0), Vector2.new(0, 0), 0, 0)
    camera.offset.x = 6
    camera.offset.y = 5
    camera.target.x = 4
    camera.target.y = 3
    camera.rotation = 2
    camera.zoom = 1

    assert camera.offset.x      == 6
    assert camera.offset.y      == 5
    assert camera.target.x      == 4
    assert camera.target.y      == 3
    assert camera.rotation      == 2
    assert camera.zoom          == 1
  end

  def test_to_h
    camera = Camera2D.new(Vector2.new(1, 2), Vector2.new(3, 4), 5, 6)

    assert camera.to_h == {
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
    }
  end
end
