class Test
  class Models
    class Image_Test < MTest::Unit::TestCaseWithAnalytics
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
        image.format = 1

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
        image = Image.load("./assets/test.png")
        assert_equal fixture_models_image_load, image.data
        unload_image(image)
      end

      def test_load_fail
        assert_raise(Image::NotFound) {
          Image.load("./assets/fail.png")
        }
      end

      def test_generate_default
        image = Image.generate(width: 10, height: 10)
        assert_equal fixture_models_generate_default, image.data
        unload_image(image)
      end

      def test_generate
        image = Image.generate(width: 10, height: 10, colour: Colour::GREEN)
        assert_equal fixture_models_generate, image.data
        unload_image(image)
      end

      def test_copy
        image = Image.generate(width: 10, height: 10, colour: Colour::GREEN)
        copy = image.copy
        assert_equal image.data, copy.data
        unload_image(image)
        unload_image(copy)
      end

      def test_to_texture
        skip_unless_display_present

        set_window_title(__method__.to_s)
        image = Image.load("./assets/test.png")
        texture = image.to_texture

        assert_equal image.width, texture.width
        assert_equal image.height, texture.height

        texture.unload
        image.unload
      end

      def test_copy_with_source
        image = Image.load("assets/test.png")
        new_image = image.copy(source: Rectangle.new(1, 1, 2, 2))
        assert_equal fixture_models_copy_with_source, new_image.data
        unload_image(image)
        unload_image(new_image)
      end

      def test_resize_default_scaling!
        image = Image.load("./assets/test.png")
        image.resize!(width: 6, height: 6)
        assert_equal fixture_models_image_resize_default_scaing!, image.data
        unload_image(image)
      end

      def test_resize_bicubic_scaling!
        image = Image.load("./assets/test.png")
        image.resize!(width: 6, height: 6, scaling: :bicubic)
        assert_equal fixture_models_image_resize_bicubic_scaing!, image.data
        unload_image(image)
      end

      def test_resize_incorrect_scaling!
        image = Image.load("./assets/test.png")
        assert_raise(ArgumentError) {
          image.resize!(width: 6, height: 6, scaling: :nope)
        }
        unload_image(image)
      end

      def test_crop!
        image = Image.load("./assets/test.png")
        image.crop!(Rectangle.new(0, 0, 2, 3))
        assert_equal fixture_models_image_crop!, image.data
        unload_image(image)
      end

      def test_alpha_mask
        image = Image.load("./assets/test.png")
        mask = Image.load("./assets/alpha.png")

        image.alpha_mask = mask

        assert_equal fixture_models_image_alpha_mask, image.data

        mask.unload
        image.unload
      end

      def test_generate_mipmaps!
        image = Image.load("./assets/test.png")
        assert_equal 1, image.mipmaps

        image.generate_mipmaps!
        assert_equal 2, image.mipmaps

        image.unload
      end

      def test_image_flip_vertical!
        image = Image.load("assets/asymettrical.png")

        image.flip_vertical!
        assert_equal fixture_models_image_flip_vertical!, image.data

        image.unload
      end

      def test_image_flip_horizontal!
        image = Image.load("assets/asymettrical.png")

        image.flip_horizontal!
        assert_equal fixture_models_image_flip_horizontal!, image.data

        image.unload
      end

      def test_image_rotate_nil!
        image = Image.load("assets/asymettrical.png")

        image.rotate!
        assert_equal fixture_models_image_rotate_nil!, image.data

        image.unload
      end

      def test_image_rotate_cw!
        image = Image.load("assets/asymettrical.png")

        image.rotate! :cw
        assert_equal fixture_models_image_rotate_cw!, image.data

        image.unload
      end

      def test_image_rotate_ccw!
        image = Image.load("assets/asymettrical.png")

        image.rotate! :ccw
        assert_equal fixture_models_image_rotate_ccw!, image.data

        image.unload
      end

      def test_image_rotate_invalid_direction!
        image = Image.load("assets/asymettrical.png")

        assert_raise(ArgumentError) {
          image.rotate! :blah
        }

        image.unload
      end

      def test_image_tint!
        image = Image.generate(width: 1, height: 1, colour: Colour::BLUE)

        image.tint!(Colour::GREEN)
        assert_equal fixture_models_image_tint!, image.data

        image.unload
      end

      def test_image_invert!
        image = Image.generate(width: 1, height: 1, colour: Colour::BLACK)

        image.invert!
        assert_equal fixture_models_image_invert!, image.data

        image.unload
      end

      def test_image_grayscale!
        red = Image.generate(width: 1, height: 1, colour: Colour::RED)
        blue = Image.generate(width: 1, height: 1, colour: Colour::BLUE)
        green = Image.generate(width: 1, height: 1, colour: Colour::GREEN)

        red.grayscale!
        blue.grayscale!
        green.grayscale!

        assert_equal fixture_models_image_grayscale![0], red.data
        assert_equal fixture_models_image_grayscale![1], blue.data
        assert_equal fixture_models_image_grayscale![2], green.data

        red.unload
        blue.unload
        green.unload
      end

      def test_image_contrast!
        darken = Image.generate(width: 1, height: 1, colour: Colour::LIME)
        lighten = Image.generate(width: 1, height: 1, colour: Colour::LIME)

        darken.contrast!(10)
        lighten.contrast!(-10)

        assert_equal fixture_models_image_contrast![0], darken.data
        assert_equal fixture_models_image_contrast![1], lighten.data

        unload_image(darken)
        unload_image(lighten)
      end

      def test_image_contrast_too_low
        image = Image.generate(width: 1, height: 1, colour: Colour::LIME)

        assert_raise(ArgumentError) {
          image.contrast!(-101)
        }

        unload_image(image)
      end

      def test_image_contrast_too_high
        image = Image.generate(width: 1, height: 1, colour: Colour::LIME)

        assert_raise(ArgumentError) {
          image.contrast!(101)
        }

        unload_image(image)
      end

      def test_image_brightness!
        darken = Image.generate(width: 1, height: 1, colour: Colour::VIOLET)
        lighten = Image.generate(width: 1, height: 1, colour: Colour::VIOLET)

        darken.brightness!(-10)
        lighten.brightness!(10)

        assert_equal fixture_models_image_brightness![1], darken.data
        assert_equal fixture_models_image_brightness![0], lighten.data

        unload_image(darken)
        unload_image(lighten)
      end

      def test_image_brightness_too_low
        image = Image.generate(width: 1, height: 1, colour: Colour::VIOLET)

        assert_raise(ArgumentError) {
          image.brightness!(-256)
        }

        unload_image(image)
      end

      def test_image_brightness_too_high
        image = Image.generate(width: 1, height: 1, colour: Colour::VIOLET)

        assert_raise(ArgumentError) {
          image.brightness!(256)
        }

        unload_image(image)
      end

      def test_image_replace!
        image = load_image("assets/test.png")

        image.replace!(Colour::WHITE, Colour::BLUE)
        assert_equal fixture_models_image_replace!, image.data

        image.unload
      end

      def test_image_draw!
        image = Image.generate(width: 3, height: 3, colour: Colour::RAYWHITE)
        to_copy = load_image("assets/test.png")

        image.draw!(
          image: to_copy,
          source: Rectangle.new(0, 0, 2, 2),
          destination: Rectangle.new(1, 1, 2, 2)
        )
        assert_equal fixture_models_image_draw!, image.data

        image.unload
        to_copy.unload
      end

      def test_image_draw_no_args!
        image = Image.generate(width: 3, height: 3, colour: Colour::RAYWHITE)
        to_copy = load_image("assets/test.png")

        image.draw!(image: to_copy)
        assert_equal fixture_models_image_draw_no_args!, image.data

        image.unload
        to_copy.unload
      end
    end
  end
end
