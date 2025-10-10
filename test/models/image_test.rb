@unit.describe "Image#initialize" do
  Given "we load an image" do
    Image.new("./assets/test.png")
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(FileExists) { fileName: './assets/test.png' }",
        "(LoadImage) { fileName: './assets/test.png' }"
      ]
    )
  end

  When "we try to load a file that doesn't exist raise an error" do
    Taylor::Raylib.mock_call("FileExists", "false")
    expect {
      Image.new("./assets/fail.png")
    }.to_raise(Image::NotFoundError, "Unable to find './assets/fail.png'")
  end
end

@unit.describe "Image#unload" do
  Given "we have an image" do
    Taylor::Raylib.mock_call("LoadImage", Image.mock_return(width: 2, height: 3, mipmaps: 4, format: 5))
    @image = Image.new("./assets/test.png")
    Taylor::Raylib.reset_calls
  end

  When "we unload it" do
    @image.unload
  end

  Then "Raylib receivs the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(UnloadImage) { " \
          "image: { " \
            "width: 2 " \
            "height: 3 " \
            "mipmaps: 4 " \
            "format: 5 " \
          "} " \
        "}"
      ]
    )
  end
end

@unit.describe "Image#valid?" do
  Given "we have a valid image" do
    Taylor::Raylib.mock_call("IsImageValid", "true")
    @image = Image.new("./assets/test.png")
  end

  Then "return true" do
    expect(@image.valid?).to_be_true
  end

  Given "we have an invalid image" do
    Taylor::Raylib.mock_call("IsImageValid", "false")
  end

  Then "return true" do
    expect(@image.valid?).to_be_false
  end
end

@unit.describe "Image#to_h" do
  Given "we have an image" do
    Taylor::Raylib.mock_call("LoadImage", Image.mock_return(width: 1, height: 2, mipmaps: 3, format: 4))
    @image = Image.new("./assets/test.png")
  end

  Then "return a hash with all the attributes" do
    expect(@image.to_h).to_equal(
      {
        width: 1,
        height: 2,
        mipmaps: 3,
        format: 4
      }
    )
  end
end

@unit.describe "Image#export" do
  Given "we generate an image" do
    Taylor::Raylib.mock_call("GenImageColor", Image.mock_return(width: 3, height: 4, mipmaps: 5, format: 5))
    @image = Image.generate(width: 3, height: 4)
    Taylor::Raylib.reset_calls
  end

  When "we export it" do
    @image.export("./blah.png")
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(ExportImage) { " \
          "image: { " \
            "width: 3 " \
            "height: 4 " \
            "mipmaps: 5 " \
            "format: 5 " \
          "} " \
          "fileName: './blah.png' " \
        "}"
      ]
    )
  end
end

@unit.describe "Image#generate" do
  When "we generate an image with no colour" do
    Image.generate(width: 10, height: 11)
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(GenImageColor) { " \
          "width: 10 " \
          "height: 11 " \
          "color: { " \
            "r: 0 " \
            "g: 0 " \
            "b: 0 " \
            "a: 0 " \
          "} " \
        "}"
      ]
    )
  end

  When "we generate an image with no colour" do
    Image.generate(width: 10, height: 11, colour: Colour::GREEN)
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(GenImageColor) { " \
          "width: 10 " \
          "height: 11 " \
          "color: { " \
            "r: 0 " \
            "g: 228 " \
            "b: 48 " \
            "a: 255 " \
          "} " \
        "}"
      ]
    )
  end
end

@unit.describe "Image#copy" do
  Given "We have an image" do
    Taylor::Raylib.mock_call("LoadImage", Image.mock_return(width: 4, height: 5, mipmaps: 6, format: 7))
    @image = Image.new("./assets/image.png")
    Taylor::Raylib.reset_calls
  end

  When "we call copy without a source" do
    @copy = @image.copy
  end

  Then "we get the full image back" do
    expect(@copy).to_be_a(Image)
  end

  And "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(ImageFromImage) { " \
          "image: { " \
            "width: 4 " \
            "height: 5 " \
            "mipmaps: 6 " \
            "format: 7 " \
          "} " \
          "rec: { " \
            "x: 0.000000 " \
            "y: 0.000000 " \
            "width: 4.000000 " \
            "height: 5.000000 " \
          "} " \
        "}"
      ]
    )
  end

  When "we call copy with a source" do
    @copy = @image.copy(source: Rectangle[1, 2, 3, 4])
  end

  Then "we get part of the image back" do
    expect(@copy).to_be_a(Image)
  end

  And "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(ImageFromImage) { " \
          "image: { " \
            "width: 4 " \
            "height: 5 " \
            "mipmaps: 6 " \
            "format: 7 " \
          "} " \
          "rec: { " \
            "x: 1.000000 " \
            "y: 2.000000 " \
            "width: 3.000000 " \
            "height: 4.000000 " \
          "} " \
        "}"
      ]
    )
  end
end

@unit.describe "Image#to_texture" do
  Given "we have an image" do
    Taylor::Raylib.mock_call("LoadImage", Image.mock_return(width: 4, height: 5, mipmaps: 6, format: 7))
    @image = Image.new("./assets/image.png")
    Taylor::Raylib.reset_calls
  end

  When "we call to_texture" do
    @texture = @image.to_texture
  end

  Then "return a texture" do
    expect(@texture).to_be_a(Texture2D)
  end

  And "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(LoadTextureFromImage) { " \
          "image: { " \
            "width: 4 " \
            "height: 5 " \
            "mipmaps: 6 " \
            "format: 7 " \
          "} " \
        "}"
      ]
    )
  end
end

@unit.describe "Image.resize!" do
  Given "we have an image" do
    Taylor::Raylib.mock_call("LoadImage", Image.mock_return(width: 4, height: 5, mipmaps: 6, format: 7))
    @image = Image.new("./assets/image.png")
    Taylor::Raylib.reset_calls
  end

  When "we call resize! with no scaler specified" do
    @image.resize!(width: 6, height: 12)
  end

  Then "Raylib is called with the nearest neighbour scaler" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(ImageResizeNN) { " \
          "image: { " \
            "width: 4 " \
            "height: 5 " \
            "mipmaps: 6 " \
            "format: 7 " \
          "} " \
          "newWidth: 6 " \
          "newHeight: 12 " \
        "}"
      ]
    )
  end

  When "we call resize! with the bicubic scaler specified" do
    @image.resize!(width: 6, height: 12, scaler: :bicubic)
  end

  Then "Raylib is called with the bicubic scalar" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(ImageResize) { " \
          "image: { " \
            "width: 4 " \
            "height: 5 " \
            "mipmaps: 6 " \
            "format: 7 " \
          "} " \
          "newWidth: 6 " \
          "newHeight: 12 " \
        "}"
      ]
    )
  end

  But "raises an error when called with an invalid scaler" do
    expect {
      @image.resize!(width: 6, height: 6, scaler: :nope)
    }.to_raise(
      ArgumentError,
      "Invalid scaler provided, you must provide :bicubic or :nearest_neighbour"
    )
  end
end

@unit.describe "Image.crop!" do
  Given "we have an image" do
    Taylor::Raylib.mock_call("LoadImage", Image.mock_return(width: 4, height: 5, mipmaps: 6, format: 7))
    @image = Image.new("./assets/image.png")
    Taylor::Raylib.reset_calls
  end

  When "we call crop!" do
    @image.crop!(source: Rectangle[0, 1, 2, 3])
  end

  Then "Raylib is called with the nearest neighbour scaler" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(ImageCrop) { " \
          "image: { " \
            "width: 4 " \
            "height: 5 " \
            "mipmaps: 6 " \
            "format: 7 " \
          "} " \
          "crop: { " \
            "x: 0.000000 " \
            "y: 1.000000 " \
            "width: 2.000000 " \
            "height: 3.000000 " \
          "} " \
        "}"
      ]
    )
  end
end

@unit.describe "Image.alpha_mask!" do
  Given "we have two images" do
    Taylor::Raylib.mock_call("GenImageColor", Image.mock_return(width: 10, height: 11, mipmaps: 12, format: 13))
    Taylor::Raylib.mock_call("GenImageColor", Image.mock_return(width: 11, height: 12, mipmaps: 13, format: 14))
    @image = Image.generate(width: 10, height: 11)
    @mask = Image.generate(width: 11, height: 12)
    Taylor::Raylib.reset_calls
  end

  When "we call alpha_mask!" do
    @image.alpha_mask!(@mask)
  end

  Then "Raylib is called with the nearest neighbour scaler" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(ImageAlphaMask) { " \
          "image: { " \
            "width: 10 " \
            "height: 11 " \
            "mipmaps: 12 " \
            "format: 13 " \
          "} " \
          "alphaMask: { " \
            "width: 11 " \
            "height: 12 " \
            "mipmaps: 13 " \
            "format: 14 " \
          "} " \
        "}"
      ]
    )
  end
end

@unit.describe "Image.generate_mipmaps!" do
  Given "we have an image" do
    Taylor::Raylib.mock_call("GenImageColor", Image.mock_return(width: 12, height: 13, mipmaps: 14, format: 15))
    @image = Image.generate(width: 12, height: 13)
    Taylor::Raylib.reset_calls
  end

  When "we call generate_mipmaps!" do
    @image.generate_mipmaps!
  end

  Then "Raylib is called with the nearest neighbour scaler" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(ImageMipmaps) { " \
          "image: { " \
            "width: 12 " \
            "height: 13 " \
            "mipmaps: 14 " \
            "format: 15 " \
          "} " \
        "}"
      ]
    )
  end
end

@unit.describe "Image.flip_vertically!" do
  Given "we have an image" do
    Taylor::Raylib.mock_call("GenImageColor", Image.mock_return(width: 13, height: 14, mipmaps: 15, format: 16))
    @image = Image.generate(width: 13, height: 14)
    Taylor::Raylib.reset_calls
  end

  When "we call flip_vertically!" do
    @image.flip_vertically!
  end

  Then "Raylib is called with the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(ImageFlipVertical) { " \
          "image: { " \
            "width: 13 " \
            "height: 14 " \
            "mipmaps: 15 " \
            "format: 16 " \
          "} " \
        "}"
      ]
    )
  end
end

@unit.describe "Image.flip_horizontally!" do
  Given "we have an image" do
    Taylor::Raylib.mock_call("GenImageColor", Image.mock_return(width: 13, height: 14, mipmaps: 15, format: 16))
    @image = Image.generate(width: 13, height: 14)
    Taylor::Raylib.reset_calls
  end

  When "we call flip_horizontally!" do
    @image.flip_horizontally!
  end

  Then "Raylib is called with the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(ImageFlipHorizontal) { " \
          "image: { " \
            "width: 13 " \
            "height: 14 " \
            "mipmaps: 15 " \
            "format: 16 " \
          "} " \
        "}"
      ]
    )
  end
end

@unit.describe "Image.rotate_clockwise!" do
  Given "we have an image" do
    Taylor::Raylib.mock_call("GenImageColor", Image.mock_return(width: 15, height: 16, mipmaps: 17, format: 18))
    @image = Image.generate(width: 15, height: 16)
    Taylor::Raylib.reset_calls
  end

  When "we call rotate_clockwise!" do
    @image.rotate_clockwise!
  end

  Then "Raylib is called with the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(ImageRotateCW) { " \
          "image: { " \
            "width: 15 " \
            "height: 16 " \
            "mipmaps: 17 " \
            "format: 18 " \
          "} " \
        "}"
      ]
    )
  end
end

@unit.describe "Image.rotate_counter_clockwise!" do
  Given "we have an image" do
    Taylor::Raylib.mock_call("GenImageColor", Image.mock_return(width: 15, height: 16, mipmaps: 17, format: 18))
    @image = Image.generate(width: 15, height: 16)
    Taylor::Raylib.reset_calls
  end

  When "we call rotate_counter_clockwise!" do
    @image.rotate_counter_clockwise!
  end

  Then "Raylib is called with the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(ImageRotateCCW) { " \
          "image: { " \
            "width: 15 " \
            "height: 16 " \
            "mipmaps: 17 " \
            "format: 18 " \
          "} " \
        "}"
      ]
    )
  end
end

@unit.describe "Image.premultiply_alpha!" do
  Given "we have an image" do
    Taylor::Raylib.mock_call("GenImageColor", Image.mock_return(width: 17, height: 18, mipmaps: 19, format: 20))
    @image = Image.generate(width: 17, height: 18)
    Taylor::Raylib.reset_calls
  end

  When "we call premultiply_alpha!" do
    @image.premultiply_alpha!
  end

  Then "Raylib is called with the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(ImageAlphaPremultiply) { " \
          "image: { " \
            "width: 17 " \
            "height: 18 " \
            "mipmaps: 19 " \
            "format: 20 " \
          "} " \
        "}"
      ]
    )
  end
end

@unit.describe "Image.tint!" do
  Given "we have an image" do
    Taylor::Raylib.mock_call("GenImageColor", Image.mock_return(width: 18, height: 19, mipmaps: 20, format: 21))
    @image = Image.generate(width: 18, height: 19)
    Taylor::Raylib.reset_calls
  end

  When "we call tint!" do
    @image.tint!(colour: Colour[0, 1, 2, 3])
  end

  Then "Raylib is called with the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(ImageColorTint) { " \
          "image: { " \
            "width: 18 " \
            "height: 19 " \
            "mipmaps: 20 " \
            "format: 21 " \
          "} " \
          "color: { " \
            "r: 0 " \
            "g: 1 " \
            "b: 2 " \
            "a: 3 " \
          "} " \
        "}"
      ]
    )
  end
end

@unit.describe "Image.invert!" do
  Given "we have an image" do
    Taylor::Raylib.mock_call("GenImageColor", Image.mock_return(width: 19, height: 20, mipmaps: 21, format: 22))
    @image = Image.generate(width: 19, height: 20)
    Taylor::Raylib.reset_calls
  end

  When "we call invert!" do
    @image.invert!
  end

  Then "Raylib is called with the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(ImageColorInvert) { " \
          "image: { " \
            "width: 19 " \
            "height: 20 " \
            "mipmaps: 21 " \
            "format: 22 " \
          "} " \
        "}"
      ]
    )
  end
end

@unit.describe "Image.greyscale!" do
  Given "we have an image" do
    Taylor::Raylib.mock_call("GenImageColor", Image.mock_return(width: 20, height: 21, mipmaps: 22, format: 23))
    @image = Image.generate(width: 20, height: 21)
    Taylor::Raylib.reset_calls
  end

  When "we call greyscale!" do
    @image.greyscale!
  end

  Then "Raylib is called with the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(ImageColorGrayscale) { " \
          "image: { " \
            "width: 20 " \
            "height: 21 " \
            "mipmaps: 22 " \
            "format: 23 " \
          "} " \
        "}"
      ]
    )
  end
end

@unit.describe "Image.contrast!" do
  Given "we have an image" do
    Taylor::Raylib.mock_call("GenImageColor", Image.mock_return(width: 21, height: 22, mipmaps: 23, format: 24))
    @image = Image.generate(width: 21, height: 22)
    Taylor::Raylib.reset_calls
  end

  When "we call contrast!" do
    @image.contrast!(10)
  end

  Then "Raylib is called with the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(ImageColorContrast) { " \
          "image: { " \
            "width: 21 " \
            "height: 22 " \
            "mipmaps: 23 " \
            "format: 24 " \
          "} " \
          "contrast: 10.000000 " \
        "}"
      ]
    )
  end

  But "raises an error when called with less than -100" do
    expect {
      @image.contrast!(-101)
    }.to_raise(ArgumentError, "Must be within (-100..100)")
  end

  Or "when called with more than 100" do
    expect {
      @image.contrast!(101)
    }.to_raise(ArgumentError, "Must be within (-100..100)")
  end
end

@unit.describe "Image.brightness!" do
  Given "we have an image" do
    Taylor::Raylib.mock_call("GenImageColor", Image.mock_return(width: 22, height: 23, mipmaps: 24, format: 25))
    @image = Image.generate(width: 22, height: 23)
    Taylor::Raylib.reset_calls
  end

  When "we call brightness!" do
    @image.brightness!(10)
  end

  Then "Raylib is called with the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(ImageColorBrightness) { " \
          "image: { " \
            "width: 22 " \
            "height: 23 " \
            "mipmaps: 24 " \
            "format: 25 " \
          "} " \
          "brightness: 10 " \
        "}"
      ]
    )
  end

  But "raises an error when called with less than -255" do
    expect {
      @image.brightness!(-256)
    }.to_raise(ArgumentError, "Must be within (-255..255)")
  end

  Or "when called with more than 255" do
    expect {
      @image.brightness!(256)
    }.to_raise(ArgumentError, "Must be within (-255..255)")
  end
end

@unit.describe "Image.replace!" do
  Given "we have an image" do
    Taylor::Raylib.mock_call("GenImageColor", Image.mock_return(width: 23, height: 24, mipmaps: 25, format: 26))
    @image = Image.generate(width: 23, height: 24)
    Taylor::Raylib.reset_calls
  end

  When "we call replace! with no arguments" do
    @image.replace!
  end

  Then "We replace Colour::VIOLET with Colour::TRANSPARENT" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(ImageColorReplace) { " \
          "image: { " \
            "width: 23 " \
            "height: 24 " \
            "mipmaps: 25 " \
            "format: 26 " \
          "} " \
          "color: { " \
            "r: 135 " \
            "g: 60 " \
            "b: 190 " \
            "a: 255 " \
          "} " \
          "replace: { " \
            "r: 0 " \
            "g: 0 " \
            "b: 0 " \
            "a: 0 " \
          "} " \
        "}"
      ]
    )
  end

  When "we call replace! with arguments" do
    @image.replace!(from: Colour[1, 2, 3, 4], to: Colour[5, 6, 7, 8])
  end

  Then "Raylib is called with the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(ImageColorReplace) { " \
          "image: { " \
            "width: 23 " \
            "height: 24 " \
            "mipmaps: 25 " \
            "format: 26 " \
          "} " \
          "color: { " \
            "r: 1 " \
            "g: 2 " \
            "b: 3 " \
            "a: 4 " \
          "} " \
          "replace: { " \
            "r: 5 " \
            "g: 6 " \
            "b: 7 " \
            "a: 8 " \
          "} " \
        "}"
      ]
    )
  end
end

@unit.describe "Image.draw!" do
  Given "we have an image" do
    Taylor::Raylib.mock_call("GenImageColor", Image.mock_return(width: 25, height: 26, mipmaps: 27, format: 28))
    Taylor::Raylib.mock_call("GenImageColor", Image.mock_return(width: 26, height: 27, mipmaps: 28, format: 29))
    @image = Image.generate(width: 25, height: 26)
    @to_copy = Image.generate(width: 26, height: 27)
    Taylor::Raylib.reset_calls
  end

  When "we call draw! with no extra arguments" do
    @image.draw!(image: @to_copy)
  end

  Then "We draw the full image at 0, 0" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(ImageDraw) { " \
          "dst: { " \
            "width: 25 " \
            "height: 26 " \
            "mipmaps: 27 " \
            "format: 28 " \
          "} " \
          "src: { " \
            "width: 26 " \
            "height: 27 " \
            "mipmaps: 28 " \
            "format: 29 " \
          "} " \
          "srcRec: { " \
            "x: 0.000000 " \
            "y: 0.000000 " \
            "width: 25.000000 " \
            "height: 26.000000 " \
          "} " \
          "dstRec: { " \
            "x: 0.000000 " \
            "y: 0.000000 " \
            "width: 25.000000 " \
            "height: 26.000000 " \
          "} " \
          "tint: { " \
            "r: 255 " \
            "g: 255 " \
            "b: 255 " \
            "a: 255 " \
          "} " \
        "}"
      ]
    )
  end

  When "we call draw! with extra arguments" do
    @image.draw!(
      image: @to_copy,
      source: Rectangle[1, 2, 3, 4],
      destination: Rectangle[5, 6, 7, 8],
      colour: Colour[9, 10, 11, 12]
    )
  end

  Then "Raylib is called with the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(ImageDraw) { " \
          "dst: { " \
            "width: 25 " \
            "height: 26 " \
            "mipmaps: 27 " \
            "format: 28 " \
          "} " \
          "src: { " \
            "width: 26 " \
            "height: 27 " \
            "mipmaps: 28 " \
            "format: 29 " \
          "} " \
          "srcRec: { " \
            "x: 1.000000 " \
            "y: 2.000000 " \
            "width: 3.000000 " \
            "height: 4.000000 " \
          "} " \
          "dstRec: { " \
            "x: 5.000000 " \
            "y: 6.000000 " \
            "width: 7.000000 " \
            "height: 8.000000 " \
          "} " \
          "tint: { " \
            "r: 9 " \
            "g: 10 " \
            "b: 11 " \
            "a: 12 " \
          "} " \
        "}"
      ]
    )
  end
end
