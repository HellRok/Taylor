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

  def test_image_copy
    image = generate_image_colour(10, 10, BLUE)
    copy = image_copy(image)
    assert_equal image.data, copy.data
    unload_image(image)
    unload_image(copy)
  end

  def test_image_from_image
    image = load_image('test/assets/test.png')
    new_image = image_from_image(image, Rectangle.new(1, 1, 2, 2))
    assert_equal fixture_image_from_image, new_image.data
    unload_image(image)
    unload_image(new_image)
  end

  def test_image_text_ex
    skip_unless_display_present

    set_window_title(__method__.to_s)
    font = Font.load('./test/assets/tiny.ttf', size: 16)

    image = image_text_ex(font, 'S', 16, 0, BLACK)
    assert_equal fixture_image_text_ex, image.data

    unload_image(image)
    font.unload
  end

  def test_image_resize!
    image = load_image('test/assets/test.png')
    image_resize!(image, 6, 6)
    raw_colour_data(image.data)
    assert_equal fixture_image_resize!, image.data
    unload_image(image)
  end

  def test_image_resize_nearest_neighbour!
    image = load_image('test/assets/test.png')
    image_resize_nearest_neighbour!(image, 6, 6)
    assert_equal fixture_image_resize_nearest_neighbour!, image.data
    unload_image(image)
  end
end
