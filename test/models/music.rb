class TestMusic < MTest::Unit::TestCase
  def test_initialize
    music = Music.new(1, true, 2)

    assert_kind_of Music, music
    assert_equal 1, music.context_type
    assert_equal true, music.looping
    assert_equal 2, music.sample_count
  end

  def test_assignment
    music = Music.new(0, false, 0)
    music.context_type = 4
    music.looping = true
    music.sample_count = 2

    assert_equal 4, music.context_type
    assert_equal true, music.looping
    assert_equal 2, music.sample_count
  end

  def test_to_h
    music = Music.new(1, false, 3)

    assert_equal(
      {
        context_type: 1,
        looping: false,
        sample_count: 3,
      },
      music.to_h
    )
  end
end
