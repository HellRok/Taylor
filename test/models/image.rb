class TestImage < MTest::Unit::TestCase
  def test_initialize
    image = Image.new(2, 3, 4, 5)

    assert_kind_of Image, image
    assert_equal 2, image.width
    assert_equal 3, image.height
    assert_equal 4, image.mipmaps
    assert_equal 5, image.format
  end

  def test_assignment
    image = Image.new(0, 0, 0, 0)
    image.width = 4
    image.height = 3
    image.mipmaps = 2
    image.format  = 1

    assert_equal 4, image.width
    assert_equal 3, image.height
    assert_equal 2, image.mipmaps
    assert_equal 1, image.format
  end

  def test_to_h
    image = Image.new(2, 3, 4, 5)

    assert_equal(
      {
        width: 2,
        height: 3,
        mipmaps: 4,
        format: 5
      },
      image.to_h
    )
  end
end
