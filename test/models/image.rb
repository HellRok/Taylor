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

  def test_load
    image = Image.load('./test/assets/test.png')
    assert_equal fixture_models_image_load, image.data
    unload_image(image)
  end

  def test_load_fail
    assert_raise(Image::NotFound) {
      image = Image.load('./test/assets/fail.png')
    }
  end

  def test_generate_default
    image = Image.generate(width: 10, height: 10)
    assert_equal fixture_models_generate_default, image.data
    unload_image(image)
  end

  def test_generate
    image = Image.generate(width: 10, height: 10, colour: GREEN)
    assert_equal fixture_models_generate, image.data
    unload_image(image)
  end

  def test_copy
    image = Image.generate(width: 10, height: 10, colour: GREEN)
    copy = image.copy
    assert_equal image.data, copy.data
    unload_image(image)
    unload_image(copy)
  end

  def test_to_texture
    skip_unless_display_present

    set_window_title(__method__.to_s)
    image = Image.load('./test/assets/test.png')
    texture = image.to_texture

    assert_equal image.width, texture.width
    assert_equal image.height, texture.height

    texture.unload
    image.unload
  end

  def test_copy_with_source
    image = Image.load('test/assets/test.png')
    new_image = image.copy(source: Rectangle.new(1, 1, 2, 2))
    assert_equal fixture_models_copy_with_source, new_image.data
    unload_image(image)
    unload_image(new_image)
  end

  def test_resize_default_scaling!
    image = Image.load('./test/assets/test.png')
    image.resize!(width: 6, height: 6)
    assert_equal fixture_models_image_resize_default_scaing!, image.data
    unload_image(image)
  end

  def test_resize_bicubic_scaling!
    image = Image.load('./test/assets/test.png')
    image.resize!(width: 6, height: 6, scaling: :bicubic)
    assert_equal fixture_models_image_resize_bicubic_scaing!, image.data
    unload_image(image)
  end

  def test_resize_incorrect_scaling!
    image = Image.load('./test/assets/test.png')
    assert_raise(ArgumentError) {
      image.resize!(width: 6, height: 6, scaling: :nope)
    }
    unload_image(image)
  end

  def test_crop!
    image = Image.load('./test/assets/test.png')
    image.crop!(Rectangle.new(0, 0, 2, 3))
    assert_equal fixture_models_image_crop!, image.data
    unload_image(image)
  end

  def test_alpha_mask
    image = Image.load('./test/assets/test.png')
    mask = Image.load('./test/assets/alpha.png')

    image.alpha_mask =  mask

    assert_equal fixture_models_image_alpha_mask, image.data

    mask.unload
    image.unload
  end

  def test_generate_mipmaps!
    image = Image.load('./test/assets/test.png')
    assert_equal 1, image.mipmaps

    image.generate_mipmaps!
    assert_equal 2, image.mipmaps

    image.unload
  end
end
