class TestColour < MTest::Unit::TestCase
  def test_initialize
    colour = Colour.new(1, 2, 3, 4)

    assert_kind_of Colour, colour
    assert colour.red   == 1
    assert colour.green == 2
    assert colour.blue  == 3
    assert colour.alpha == 4
  end

  def test_assignment
    colour = Colour.new(0, 0, 0, 0)
    colour.red = 4
    colour.green = 3
    colour.blue = 2
    colour.alpha = 1

    assert colour.red   == 4
    assert colour.green == 3
    assert colour.blue  == 2
    assert colour.alpha == 1
  end

  def test_to_h
    colour = Colour.new(1, 2, 3, 4)

    assert colour.to_h == {
      red: 1,
      green: 2,
      blue: 3,
      alpha: 4
    }
  end
end
