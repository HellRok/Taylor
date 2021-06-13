class TestShapesCollision < MTest::Unit::TestCase
  def test_check_collision_point_rec
    rectangle = Rectangle.new(2, 2, 4, 5)

    assert_false check_collision_point_rec(Vector2.new(0, 0), rectangle)
    assert_true  check_collision_point_rec(Vector2.new(2, 2), rectangle)
    assert_true  check_collision_point_rec(Vector2.new(4, 4), rectangle)
    assert_false check_collision_point_rec(Vector2.new(7, 8), rectangle)
  end
end
