class TestVector2 < MTest::Unit::TestCase
  def test_initialize
    vector = Vector2.new(1, 2)

    assert_kind_of Vector2, vector
    assert vector.x == 1
    assert vector.y == 2
  end

  def test_assignment
    vector = Vector2.new(0, 0)
    vector.x = 3
    vector.y = 8

    assert vector.x == 3
    assert vector.y == 8
  end

  def test_add
    vector = Vector2.new(1, 3) + Vector2.new(2, 5)

    assert_kind_of Vector2, vector
    assert vector.x == 3
    assert vector.y == 8
  end

  def test_minus
    vector = Vector2.new(1, 3) - Vector2.new(2, 5)

    assert_kind_of Vector2, vector
    assert vector.x == -1
    assert vector.y == -2
  end

  def test_scalar
    vector = Vector2.new(1, 3).scale(4)

    assert_kind_of Vector2, vector
    assert vector.x == 4
    assert vector.y == 12
  end

  def test_length
    assert Vector2.new(3, -4).length == 5
  end

  def test_to_h
    assert Vector2.new(3, -4).to_h == { x: 3, y: -4 }
  end
end
