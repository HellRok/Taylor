class Test
  class Image_Test < MTest::Unit::TestCaseWithAnalytics
    def test_image_load
      image = load_image('assets/test.png')
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
      image = load_image('assets/test.png')
      new_image = image_from_image(image, Rectangle.new(1, 1, 2, 2))
      assert_equal fixture_image_from_image, new_image.data
      unload_image(image)
      unload_image(new_image)
    end

    def test_image_text_ex
      skip_unless_display_present

      set_window_title(__method__.to_s)
      font = Font.load('./assets/tiny.ttf', size: 16)

      image = image_text_ex(font, 'S', 16, 0, BLACK)
      assert_equal fixture_image_text_ex, image.data

      unload_image(image)
      font.unload
    end

    def test_image_resize!
      image = load_image('assets/test.png')
      image_resize!(image, 6, 6)
      assert_equal fixture_image_resize!, image.data
      unload_image(image)
    end

    def test_image_resize_nearest_neighbour!
      image = load_image('assets/test.png')
      image_resize_nearest_neighbour!(image, 6, 6)
      assert_equal fixture_image_resize_nearest_neighbour!, image.data
      unload_image(image)
    end

    def test_image_crop!
      image = load_image('assets/test.png')
      image_crop!(image, Rectangle.new(0, 0, 3, 2))
      assert_equal fixture_image_crop!, image.data
      unload_image(image)
    end

    def test_image_alpha_mask!
      image = load_image('assets/test.png')
      mask = load_image('assets/alpha.png')

      image_alpha_mask!(image, mask)
      assert_equal fixture_image_alpha_mask!, image.data

      unload_image(mask)
      unload_image(image)
    end

    def test_image_mipmaps!
      image = load_image('assets/test.png')
      assert_equal 1, image.mipmaps

      image_mipmaps!(image)
      assert_equal 2, image.mipmaps

      unload_image(image)
    end

    def test_image_flip_vertical!
      image = load_image('assets/asymettrical.png')

      image_flip_vertical!(image)
      assert_equal fixture_image_flip_vertical!, image.data

      unload_image(image)
    end

    def test_image_flip_horizontal!
      image = load_image('assets/asymettrical.png')

      image_flip_horizontal!(image)
      assert_equal fixture_image_flip_horizontal!, image.data

      unload_image(image)
    end

    def test_image_rotate_cw!
      image = load_image('assets/asymettrical.png')

      image_rotate_cw!(image)
      assert_equal fixture_image_rotate_cw!, image.data

      unload_image(image)
    end

    def test_image_rotate_ccw!
      image = load_image('assets/asymettrical.png')

      image_rotate_ccw!(image)
      assert_equal fixture_image_rotate_ccw!, image.data

      unload_image(image)
    end

    def test_image_colour_tint!
      image = Image.generate(width: 1, height: 1, colour: BLUE)

      image_colour_tint!(image, GREEN)
      assert_equal fixture_image_colour_tint!, image.data

      unload_image(image)
    end

    def test_image_colour_invert!
      image = Image.generate(width: 1, height: 1, colour: BLACK)

      image_colour_invert!(image)
      assert_equal fixture_image_colour_invert!, image.data

      unload_image(image)
    end

    def test_image_colour_grayscale!
      red = Image.generate(width: 1, height: 1, colour: RED)
      blue = Image.generate(width: 1, height: 1, colour: BLUE)
      green = Image.generate(width: 1, height: 1, colour: GREEN)

      image_colour_grayscale!(red)
      image_colour_grayscale!(blue)
      image_colour_grayscale!(green)

      assert_equal fixture_image_colour_grayscale![0], red.data
      assert_equal fixture_image_colour_grayscale![1], blue.data
      assert_equal fixture_image_colour_grayscale![2], green.data

      unload_image(red)
      unload_image(blue)
      unload_image(green)
    end

    def test_image_colour_contrast!
      darken = Image.generate(width: 1, height: 1, colour: LIME)
      lighten = Image.generate(width: 1, height: 1, colour: LIME)

      image_colour_contrast!(darken, 50)
      image_colour_contrast!(lighten, -50)

      assert_equal fixture_image_colour_contrast![0], darken.data
      assert_equal fixture_image_colour_contrast![1], lighten.data

      unload_image(darken)
      unload_image(lighten)
    end

    def test_image_colour_brightness!
      darken = Image.generate(width: 1, height: 1, colour: VIOLET)
      lighten = Image.generate(width: 1, height: 1, colour: VIOLET)

      image_colour_brightness!(darken, -50)
      image_colour_brightness!(lighten, 50)

      assert_equal fixture_image_colour_brightness![1], darken.data
      assert_equal fixture_image_colour_brightness![0], lighten.data

      unload_image(darken)
      unload_image(lighten)
    end

    def test_image_colour_replace!
      image = load_image('assets/test.png')

      image_colour_replace!(image, WHITE, BLUE)
      assert_equal fixture_image_colour_replace!, image.data

      unload_image(image)
    end

    def test_image_draw!
      image = generate_image_colour(3, 3, RAYWHITE)
      to_copy = load_image('assets/test.png')

      image_draw!(
        image,
        to_copy,
        Rectangle.new(0, 0, 2, 2),
        Rectangle.new(1, 1, 2, 2),
        WHITE
      )
      assert_equal fixture_image_draw!, image.data

      unload_image(image)
      unload_image(to_copy)
    end
  end
end
