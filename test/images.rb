class TestImage < MTest::Unit::TestCase
  def test_image_load
    image = load_image('test/assets/test.png')
    assert_equal fixture_image_load, image.data
    unload_image(image)
  end

  def test_image_generate_colour
    image = generate_image_colour(10, 10, RAYWHITE)
    assert_equal fixture_generate_colour, image.data
    unload_image(image)
  end
end
