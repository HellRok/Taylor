class Test
  class Models
    class Image_Test < Test::Base
      def test_initialize
        Image.new("./assets/test.png")

        assert_called [
          "(FileExists) { fileName: './assets/test.png' }",
          "(LoadImage) { fileName: './assets/test.png' }"
        ]
      end

      def test_initialize_fail
        Taylor::Raylib.mock_call("FileExists", "false")

        assert_raise_with_message(Image::NotFoundError, "Unable to find './assets/fail.png'") {
          Image.new("./assets/fail.png")
        }

        assert_called [
          "(FileExists) { fileName: './assets/fail.png' }"
        ]
      end

      def test_unload
        Taylor::Raylib.mock_call("LoadImage", Image.mock_return(width: 2, height: 3, mipmaps: 4, format: 5))
        image = Image.new("./assets/test.png")
        Taylor::Raylib.reset_calls

        image.unload

        assert_called [
          "(UnloadImage) { image: { width: 2 height: 3 mipmaps: 4 format: 5 } }"
        ]
      end

      def test_to_h
        Taylor::Raylib.mock_call("LoadImage", Image.mock_return(width: 1, height: 2, mipmaps: 3, format: 4))

        image = Image.new("./assets/test.png")

        assert_equal(
          {
            width: 1,
            height: 2,
            mipmaps: 3,
            format: 4
          },
          image.to_h
        )
      end

      def test_export
        Taylor::Raylib.mock_call("GenImageColor", Image.mock_return(width: 3, height: 4, mipmaps: 5, format: 5))
        image = Image.generate(width: 3, height: 4)
        Taylor::Raylib.reset_calls

        image.export("./blah.png")
        assert_called [
          "(ExportImage) { image: { width: 3 height: 4 mipmaps: 5 format: 5 } fileName: './blah.png' }"
        ]
      end

      def test_generate_default
        Image.generate(width: 10, height: 11)

        assert_called [
          "(GenImageColor) { width: 10 height: 11 color: { r: 0 g: 0 b: 0 a: 0 } }"
        ]
      end

      def test_generate
        Image.generate(width: 11, height: 12, colour: Colour::GREEN)

        assert_called [
          "(GenImageColor) { width: 11 height: 12 color: { r: 0 g: 228 b: 48 a: 255 } }"
        ]
      end

      def test_copy
        Taylor::Raylib.mock_call("GenImageColor", Image.mock_return(width: 4, height: 5, mipmaps: 6, format: 7))
        image = Image.generate(width: 4, height: 5)
        Taylor::Raylib.reset_calls

        image.copy

        assert_called [
          "(ImageFromImage) { image: { width: 4 height: 5 mipmaps: 6 format: 7 } rec: { x: 0.000000 y: 0.000000 width: 4.000000 height: 5.000000 } }"
        ]
      end

      def test_copy_with_source
        Taylor::Raylib.mock_call("GenImageColor", Image.mock_return(width: 5, height: 6, mipmaps: 7, format: 8))
        image = Image.generate(width: 5, height: 6)
        Taylor::Raylib.reset_calls

        image.copy(source: Rectangle.new(1, 2, 3, 4))
        assert_called [
          "(ImageFromImage) { image: { width: 5 height: 6 mipmaps: 7 format: 8 } rec: { x: 1.000000 y: 2.000000 width: 3.000000 height: 4.000000 } }"
        ]
      end

      def test_to_texture
        Taylor::Raylib.mock_call("GenImageColor", Image.mock_return(width: 6, height: 7, mipmaps: 8, format: 9))
        image = Image.generate(width: 6, height: 7)
        Taylor::Raylib.reset_calls

        image.to_texture

        assert_called [
          "(LoadTextureFromImage) { image: { width: 6 height: 7 mipmaps: 8 format: 9 } }"
        ]
      end

      def test_resize_bang_default_scaler
        Taylor::Raylib.mock_call("GenImageColor", Image.mock_return(width: 7, height: 8, mipmaps: 9, format: 10))
        image = Image.generate(width: 7, height: 8)
        Taylor::Raylib.reset_calls

        image.resize!(width: 6, height: 12)

        assert_called [
          "(ImageResizeNN) { image: { width: 7 height: 8 mipmaps: 9 format: 10 } newWidth: 6 newHeight: 12 }"
        ]
      end

      def test_resize_bang_bicubic_scaler
        Taylor::Raylib.mock_call("GenImageColor", Image.mock_return(width: 8, height: 9, mipmaps: 10, format: 11))
        image = Image.generate(width: 8, height: 9)
        Taylor::Raylib.reset_calls

        image.resize!(width: 6, height: 7, scaler: :bicubic)

        assert_called [
          "(ImageResize) { image: { width: 8 height: 9 mipmaps: 10 format: 11 } newWidth: 6 newHeight: 7 }"
        ]
      end

      def test_resize_bang_incorrect_scaler
        Taylor::Raylib.mock_call("GenImageColor", Image.mock_return)
        image = Image.generate(width: 1, height: 1)
        Taylor::Raylib.reset_calls

        begin
          image.resize!(width: 6, height: 6, scaler: :nope)
        rescue ArgumentError => e
          assert_equal "Invalid scaler provided, you must provide :bicubic or :nearest_neighbour",
            e.message
        end

        assert_no_calls
      end

      def test_crop!
        Taylor::Raylib.mock_call("GenImageColor", Image.mock_return(width: 9, height: 10, mipmaps: 11, format: 12))
        image = Image.generate(width: 9, height: 10)
        Taylor::Raylib.reset_calls

        image.crop!(source: Rectangle.new(0, 0, 2, 3))

        assert_called [
          "(ImageCrop) { image: { width: 9 height: 10 mipmaps: 11 format: 12 } crop: { x: 0.000000 y: 0.000000 width: 2.000000 height: 3.000000 } }"
        ]
      end

      def test_alpha_mask!
        Taylor::Raylib.mock_call("GenImageColor", Image.mock_return(width: 10, height: 11, mipmaps: 12, format: 13))
        Taylor::Raylib.mock_call("GenImageColor", Image.mock_return(width: 11, height: 12, mipmaps: 13, format: 14))
        image = Image.generate(width: 10, height: 11)
        mask = Image.generate(width: 11, height: 12)
        Taylor::Raylib.reset_calls

        image.alpha_mask!(mask)

        assert_called [
          "(ImageAlphaMask) { image: { width: 10 height: 11 mipmaps: 12 format: 13 } alphaMask: { width: 11 height: 12 mipmaps: 13 format: 14 } }"
        ]
      end

      def test_generate_mipmaps!
        Taylor::Raylib.mock_call("GenImageColor", Image.mock_return(width: 12, height: 13, mipmaps: 14, format: 15))
        image = Image.generate(width: 12, height: 13)
        Taylor::Raylib.reset_calls

        image.generate_mipmaps!

        assert_called [
          "(ImageMipmaps) { image: { width: 12 height: 13 mipmaps: 14 format: 15 } }"
        ]
      end

      def test_image_flip_vertically!
        Taylor::Raylib.mock_call("GenImageColor", Image.mock_return(width: 13, height: 14, mipmaps: 15, format: 16))
        image = Image.generate(width: 13, height: 14)
        Taylor::Raylib.reset_calls

        image.flip_vertically!

        assert_called [
          "(ImageFlipVertical) { image: { width: 13 height: 14 mipmaps: 15 format: 16 } }"
        ]
      end

      def test_image_flip_horizontally!
        Taylor::Raylib.mock_call("GenImageColor", Image.mock_return(width: 14, height: 15, mipmaps: 16, format: 17))
        image = Image.generate(width: 14, height: 15)
        Taylor::Raylib.reset_calls

        image.flip_horizontally!

        assert_called [
          "(ImageFlipHorizontal) { image: { width: 14 height: 15 mipmaps: 16 format: 17 } }"
        ]
      end

      def test_image_rotate_clockwise!
        Taylor::Raylib.mock_call("GenImageColor", Image.mock_return(width: 15, height: 16, mipmaps: 17, format: 18))
        image = Image.generate(width: 15, height: 16)
        Taylor::Raylib.reset_calls

        image.rotate_clockwise!

        assert_called [
          "(ImageRotateCW) { image: { width: 15 height: 16 mipmaps: 17 format: 18 } }"
        ]
      end

      def test_image_rotate_counter_clockwise!
        Taylor::Raylib.mock_call("GenImageColor", Image.mock_return(width: 16, height: 17, mipmaps: 18, format: 19))
        image = Image.generate(width: 16, height: 17)
        Taylor::Raylib.reset_calls

        image.rotate_counter_clockwise!

        assert_called [
          "(ImageRotateCCW) { image: { width: 16 height: 17 mipmaps: 18 format: 19 } }"
        ]
      end

      def test_image_premultiply_alpha!
        Taylor::Raylib.mock_call("GenImageColor", Image.mock_return(width: 17, height: 18, mipmaps: 19, format: 20))
        image = Image.generate(width: 17, height: 18)
        Taylor::Raylib.reset_calls

        image.premultiply_alpha!

        assert_called [
          "(ImageAlphaPremultiply) { image: { width: 17 height: 18 mipmaps: 19 format: 20 } }"
        ]
      end

      def test_image_tint!
        Taylor::Raylib.mock_call("GenImageColor", Image.mock_return(width: 18, height: 19, mipmaps: 20, format: 21))
        image = Image.generate(width: 18, height: 19)
        Taylor::Raylib.reset_calls

        image.tint!(colour: Colour[0, 1, 2, 3])

        assert_called [
          "(ImageColorTint) { image: { width: 18 height: 19 mipmaps: 20 format: 21 } color: { r: 0 g: 1 b: 2 a: 3 } }"
        ]
      end

      def test_image_invert!
        Taylor::Raylib.mock_call("GenImageColor", Image.mock_return(width: 19, height: 20, mipmaps: 21, format: 22))
        image = Image.generate(width: 19, height: 20)
        Taylor::Raylib.reset_calls

        image.invert!

        assert_called [
          "(ImageColorInvert) { image: { width: 19 height: 20 mipmaps: 21 format: 22 } }"
        ]
      end

      def test_image_greyscale!
        Taylor::Raylib.mock_call("GenImageColor", Image.mock_return(width: 20, height: 21, mipmaps: 22, format: 23))
        image = Image.generate(width: 20, height: 21)
        Taylor::Raylib.reset_calls

        image.greyscale!

        assert_called [
          "(ImageColorGrayscale) { image: { width: 20 height: 21 mipmaps: 22 format: 23 } }"
        ]
      end

      def test_image_contrast!
        Taylor::Raylib.mock_call("GenImageColor", Image.mock_return(width: 21, height: 22, mipmaps: 23, format: 24))
        image = Image.generate(width: 21, height: 22)
        Taylor::Raylib.reset_calls

        image.contrast!(10)

        assert_called [
          "(ImageColorContrast) { image: { width: 21 height: 22 mipmaps: 23 format: 24 } contrast: 10.000000 }"
        ]
      end

      def test_image_contrast_bang_too_low
        Taylor::Raylib.mock_call("GenImageColor", Image.mock_return)
        image = Image.generate(width: 1, height: 1)
        Taylor::Raylib.reset_calls

        begin
          image.contrast!(-101)
        rescue ArgumentError => e
          assert_equal "Must be within (-100..100)", e.message
        end

        assert_no_calls
      end

      def test_image_contrast_bang_too_high
        Taylor::Raylib.mock_call("GenImageColor", Image.mock_return)
        image = Image.generate(width: 1, height: 1)
        Taylor::Raylib.reset_calls

        begin
          image.contrast!(101)
        rescue ArgumentError => e
          assert_equal "Must be within (-100..100)", e.message
        end

        assert_no_calls
      end

      def test_image_brightness!
        Taylor::Raylib.mock_call("GenImageColor", Image.mock_return(width: 22, height: 23, mipmaps: 24, format: 25))
        image = Image.generate(width: 22, height: 23)
        Taylor::Raylib.reset_calls

        image.brightness!(-10)
        image.brightness!(10)

        assert_called [
          "(ImageColorBrightness) { image: { width: 22 height: 23 mipmaps: 24 format: 25 } brightness: -10 }",
          "(ImageColorBrightness) { image: { width: 22 height: 23 mipmaps: 24 format: 25 } brightness: 10 }"
        ]
      end

      def test_image_brightness_too_low
        Taylor::Raylib.mock_call("GenImageColor", Image.mock_return)
        image = Image.generate(width: 1, height: 1)
        Taylor::Raylib.reset_calls

        begin
          image.brightness!(-256)
        rescue ArgumentError => e
          assert_equal "Must be within (-255..255)", e.message
        end

        assert_no_calls
      end

      def test_image_brightness_too_high
        Taylor::Raylib.mock_call("GenImageColor", Image.mock_return)
        image = Image.generate(width: 1, height: 1)
        Taylor::Raylib.reset_calls

        begin
          image.brightness!(256)
        rescue ArgumentError => e
          assert_equal "Must be within (-255..255)", e.message
        end

        assert_no_calls
      end

      def test_image_replace!
        Taylor::Raylib.mock_call("GenImageColor", Image.mock_return(width: 23, height: 24, mipmaps: 25, format: 26))
        image = Image.generate(width: 23, height: 24)
        Taylor::Raylib.reset_calls

        image.replace!

        assert_called [
          "(ImageColorReplace) { image: { width: 23 height: 24 mipmaps: 25 format: 26 } color: { r: 135 g: 60 b: 190 a: 255 } replace: { r: 0 g: 0 b: 0 a: 0 } }"
        ]
      end

      def test_image_replace_bang_with_options
        Taylor::Raylib.mock_call("GenImageColor", Image.mock_return(width: 24, height: 25, mipmaps: 26, format: 27))
        image = Image.generate(width: 24, height: 25)
        Taylor::Raylib.reset_calls

        image.replace!(from: Colour[1, 2, 3, 4], to: Colour[5, 6, 7, 8])

        assert_called [
          "(ImageColorReplace) { image: { width: 24 height: 25 mipmaps: 26 format: 27 } color: { r: 1 g: 2 b: 3 a: 4 } replace: { r: 5 g: 6 b: 7 a: 8 } }"
        ]
      end

      def test_image_draw!
        Taylor::Raylib.mock_call("GenImageColor", Image.mock_return(width: 25, height: 26, mipmaps: 27, format: 28))
        Taylor::Raylib.mock_call("GenImageColor", Image.mock_return(width: 26, height: 27, mipmaps: 28, format: 29))
        image = Image.generate(width: 25, height: 26)
        to_copy = Image.generate(width: 26, height: 27)
        Taylor::Raylib.reset_calls

        image.draw!(
          image: to_copy,
          source: Rectangle[1, 2, 3, 4],
          destination: Rectangle[5, 6, 7, 8],
          colour: Colour[9, 10, 11, 12]
        )

        assert_called [
          "(ImageDraw) { dst: { width: 25 height: 26 mipmaps: 27 format: 28 } src: { width: 26 height: 27 mipmaps: 28 format: 29 } srcRec: { x: 1.000000 y: 2.000000 width: 3.000000 height: 4.000000 } dstRec: { x: 5.000000 y: 6.000000 width: 7.000000 height: 8.000000 } tint: { r: 9 g: 10 b: 11 a: 12 } }"
        ]
      end

      def test_image_draw_bang_no_args
        Taylor::Raylib.mock_call("GenImageColor", Image.mock_return(width: 27, height: 28, mipmaps: 29, format: 30))
        Taylor::Raylib.mock_call("GenImageColor", Image.mock_return(width: 28, height: 29, mipmaps: 30, format: 31))
        image = Image.generate(width: 27, height: 28)
        to_copy = Image.generate(width: 28, height: 29)
        Taylor::Raylib.reset_calls

        image.draw!(image: to_copy)

        assert_called [
          "(ImageDraw) { dst: { width: 27 height: 28 mipmaps: 29 format: 30 } src: { width: 28 height: 29 mipmaps: 30 format: 31 } srcRec: { x: 0.000000 y: 0.000000 width: 27.000000 height: 28.000000 } dstRec: { x: 0.000000 y: 0.000000 width: 27.000000 height: 28.000000 } tint: { r: 255 g: 255 b: 255 a: 255 } }"
        ]
      end
    end
  end
end
