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
end
