class TestRectangle < MTest::Unit::TestCase
  def test_initialize
    rectangle = Rectangle.new(1, 2, 3, 4)

    assert_kind_of Rectangle, rectangle
    assert rectangle.x      == 1
    assert rectangle.y      == 2
    assert rectangle.width  == 3
    assert rectangle.height == 4
  end

  def test_assignment
    rectangle = Rectangle.new(0, 0, 0, 0)
    rectangle.x = 4
    rectangle.y = 3
    rectangle.width = 2
    rectangle.height = 1

    assert rectangle.x      == 4
    assert rectangle.y      == 3
    assert rectangle.width  == 2
    assert rectangle.height == 1
  end

  def test_to_h
    rectangle = Rectangle.new(1, 2, 3, 4)

    assert rectangle.to_h == {
      x: 1,
      y: 2,
      width: 3,
      height: 4
    }
  end
end
