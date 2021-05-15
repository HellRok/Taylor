class TestSound < MTest::Unit::TestCase
  def test_initialize
    sound = Sound.new(2)

    assert_kind_of Sound, sound
    assert_equal 2, sound.sample_count
  end

  def test_assignment
    sound = Sound.new(0)
    sound.sample_count = 3

    assert_equal 3, sound.sample_count
  end

  def test_to_h
    sound = Sound.new(1)

    assert_equal(
      {
        sample_count: 1,
      },
      sound.to_h
    )
  end
end
