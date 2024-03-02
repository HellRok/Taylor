class Test
  class Image_Test < MTest::Unit::TestCaseWithAnalytics
    def test_image_mipmaps!
      image = Image.new("assets/test.png")
      assert_equal 1, image.mipmaps

      image_mipmaps!(image)
      assert_equal 2, image.mipmaps
    ensure
      image.unload
    end

    def test_image_colour_tint!
      image = Image.generate(width: 1, height: 1, colour: Colour::BLUE)

      image_colour_tint!(image, Colour::GREEN)
      assert_equal fixture_image_colour_tint!, image.data
    ensure
      image.unload
    end

    def test_image_colour_invert!
      image = Image.generate(width: 1, height: 1, colour: Colour::BLACK)

      image_colour_invert!(image)
      assert_equal fixture_image_colour_invert!, image.data
    ensure
      image.unload
    end

    def test_image_colour_grayscale!
      red = Image.generate(width: 1, height: 1, colour: Colour::RED)
      blue = Image.generate(width: 1, height: 1, colour: Colour::BLUE)
      green = Image.generate(width: 1, height: 1, colour: Colour::GREEN)

      image_colour_grayscale!(red)
      image_colour_grayscale!(blue)
      image_colour_grayscale!(green)

      assert_equal fixture_image_colour_grayscale![0], red.data
      assert_equal fixture_image_colour_grayscale![1], blue.data
      assert_equal fixture_image_colour_grayscale![2], green.data
    ensure
      red.unload
      blue.unload
      green.unload
    end

    def test_image_colour_contrast!
      darken = Image.generate(width: 1, height: 1, colour: Colour::LIME)
      lighten = Image.generate(width: 1, height: 1, colour: Colour::LIME)

      image_colour_contrast!(darken, 50)
      image_colour_contrast!(lighten, -50)

      assert_equal fixture_image_colour_contrast![0], darken.data
      assert_equal fixture_image_colour_contrast![1], lighten.data
    ensure
      darken.unload
      lighten.unload
    end

    def test_image_colour_brightness!
      darken = Image.generate(width: 1, height: 1, colour: Colour::VIOLET)
      lighten = Image.generate(width: 1, height: 1, colour: Colour::VIOLET)

      image_colour_brightness!(darken, -50)
      image_colour_brightness!(lighten, 50)

      assert_equal fixture_image_colour_brightness![1], darken.data
      assert_equal fixture_image_colour_brightness![0], lighten.data
    ensure
      darken.unload
      lighten.unload
    end

    def test_image_colour_replace!
      image = Image.new("assets/test.png")

      image_colour_replace!(image, Colour::WHITE, Colour::BLUE)
      assert_equal fixture_image_colour_replace!, image.data
    ensure
      image.unload
    end

    def test_image_draw!
      image = Image.generate(width: 3, height: 3, colour: Colour::RAYWHITE)
      to_copy = Image.new("assets/test.png")

      image_draw!(
        image,
        to_copy,
        Rectangle.new(0, 0, 2, 2),
        Rectangle.new(1, 1, 2, 2),
        Colour::WHITE
      )
      assert_equal fixture_image_draw!, image.data
    ensure
      image.unload
      to_copy.unload
    end
  end
end
