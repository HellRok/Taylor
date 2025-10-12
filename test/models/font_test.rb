@unit.describe "Font#initialize" do
  Given "we have a font to load" do
    Taylor::Raylib.mock_call("FileExists", "true")
    Taylor::Raylib.mock_call("LoadFontEx", Font.mock_return(size: 32, glyph_count: 95, glyph_padding: 4))
  end

  When "we load the font" do
    @font = Font.new("./assets/tiny.ttf")
  end

  Then "it has the correct attributes" do
    expect(@font).to_be_a(Font)
    expect(@font.size).to_equal(32)
    expect(@font.glyph_count).to_equal(95)
    expect(@font.glyph_padding).to_equal(4)
  end

  And "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(FileExists) { fileName: './assets/tiny.ttf' }",
        "(LoadFontEx) { fileName: './assets/tiny.ttf' fontSize: 32 codepoints: 0x0 codepointCount: 95 }"
      ]
    )
  end

  Given "we have a font to load" do
    Taylor::Raylib.mock_call("FileExists", "true")
    Taylor::Raylib.mock_call("LoadFontEx", Font.mock_return(size: 6, glyph_count: 100, glyph_padding: 4))
  end

  When "we load the font with arguments" do
    @font = Font.new("./assets/tiny.ttf", size: 6, glyph_count: 100)
  end

  Then "it has the correct attributes" do
    expect(@font).to_be_a(Font)
    expect(@font.size).to_equal(6)
    expect(@font.glyph_count).to_equal(100)
    expect(@font.glyph_padding).to_equal(4)
  end

  And "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(FileExists) { fileName: './assets/tiny.ttf' }",
        "(LoadFontEx) { fileName: './assets/tiny.ttf' fontSize: 6 codepoints: 0x0 codepointCount: 100 }"
      ]
    )
  end

  Given "we have no font to load" do
    Taylor::Raylib.mock_call("FileExists", "false")
  end

  Then "we raise an error" do
    expect {
      Font.new("./assets/fail.ttf")
    }.to_raise(Font::NotFoundError, "Unable to find './assets/fail.ttf'")
  end

  Then "clean up" do
    @font = nil
  end
end

@unit.describe "Font#unload" do
  Given "we have a font loaded" do
    Taylor::Raylib.mock_call("LoadFontEx", Font.mock_return(size: 1, glyph_count: 2, glyph_padding: 3))
    @font = Font.new("./assets/tiny.ttf")
    Taylor::Raylib.reset_calls
  end

  When "we unload the font" do
    @font.unload
  end

  Then "Raylib receives the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(UnloadFont) { font: { baseSize: 1 glyphCount: 2 glyphPadding: 3 } }"
      ]
    )
  end

  Then "clean up" do
    @font = nil
  end
end

@unit.describe "Font#default" do
  When "we use the default font" do
    Taylor::Raylib.mock_call("GetFontDefault", Font.mock_return(size: 10, glyph_count: 224, glyph_padding: 0))
    @font = Font.default
  end

  Then "it has the correct attributes" do
    expect(@font).to_be_a(Font)
    expect(@font.size).to_equal(10)
    expect(@font.glyph_count).to_equal(224)
    expect(@font.glyph_padding).to_equal(0)
  end

  Then "clean up" do
    @font = nil
  end
end

@unit.describe "Font#to_h" do
  Given "we load a font" do
    Taylor::Raylib.mock_call("LoadFontEx", Font.mock_return(size: 32, glyph_count: 95, glyph_padding: 4))
    @font = Font.new("./assets/tiny.ttf")
  end

  Then "we return a hash with all the attributes" do
    expect(@font.to_h).to_equal(
      {
        size: 32,
        glyph_count: 95,
        glyph_padding: 4,
        texture: {
          id: 0.0,
          width: 0.0,
          height: 0.0,
          mipmaps: 0.0,
          format: 0.0
        }
      }
    )
  end

  Then "clean up" do
    @font = nil
  end
end

@unit.describe "Font#valid?" do
  Given "we have a valid font" do
    Taylor::Raylib.mock_call("IsFontValid", "true")
    Taylor::Raylib.mock_call("LoadFontEx", Font.mock_return(size: 4, glyph_count: 5, glyph_padding: 6))
    @font = Font.new("./assets/tiny.ttf")
    Taylor::Raylib.reset_calls
  end

  Then "return true" do
    expect(@font.valid?).to_be_true
  end

  And "Raylib receives the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(IsFontValid) { font: { baseSize: 4 glyphCount: 5 glyphPadding: 6 } }"
      ]
    )
  end

  Given "we have an invalid font" do
    Taylor::Raylib.mock_call("IsFontValid", "false")
    Taylor::Raylib.mock_call("LoadFontEx", Font.mock_return(size: 5, glyph_count: 6, glyph_padding: 7))
    @font = Font.new("./assets/tiny.ttf")
    Taylor::Raylib.reset_calls
  end

  Then "return false" do
    expect(@font.valid?).to_be_false
  end

  And "Raylib receives the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(IsFontValid) { font: { baseSize: 5 glyphCount: 6 glyphPadding: 7 } }"
      ]
    )
  end

  Then "clean up" do
    @font = nil
  end
end

@unit.describe "Font#draw" do
  Given "we have a font" do
    Taylor::Raylib.mock_call("LoadFontEx", Font.mock_return(size: 6, glyph_count: 7, glyph_padding: 8))
    @font = Font.new("./assets/tiny.ttf")
    Taylor::Raylib.reset_calls
  end

  When "we draw it" do
    @font.draw("text")
  end

  Then "Raylib receives the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(DrawTextEx) { " \
          "font: { " \
            "baseSize: 6 " \
            "glyphCount: 7 " \
            "glyphPadding: 8 " \
          "} " \
          "text: 'text' " \
          "position: { " \
            "x: 0.000000 " \
            "y: 0.000000 " \
          "} " \
          "fontSize: 6.000000 " \
          "spacing: 2.000000 " \
          "tint: { " \
            "r: 0 " \
            "g: 0 " \
            "b: 0 " \
            "a: 255 " \
          "} " \
        "}"
      ]
    )
  end

  When "we draw it with extra arguments" do
    @font.draw(
      "x",
      size: 12,
      spacing: 13,
      colour: Colour[1, 2, 3, 4]
    )
  end

  Then "Raylib receives the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(DrawTextEx) { " \
          "font: { " \
            "baseSize: 6 " \
            "glyphCount: 7 " \
            "glyphPadding: 8 " \
          "} " \
          "text: 'x' " \
          "position: { " \
            "x: 0.000000 " \
            "y: 0.000000 " \
          "} " \
          "fontSize: 12.000000 " \
          "spacing: 13.000000 " \
          "tint: { " \
            "r: 1 " \
            "g: 2 " \
            "b: 3 " \
            "a: 4 " \
          "} " \
        "}"
      ]
    )
  end

  When "we draw it with a vector position" do
    @font.draw(
      "q",
      position: Vector2.new(x: 2, y: 3)
    )
  end

  Then "Raylib receives the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(DrawTextEx) { " \
          "font: { " \
            "baseSize: 6 " \
            "glyphCount: 7 " \
            "glyphPadding: 8 " \
          "} " \
          "text: 'q' " \
          "position: { " \
            "x: 2.000000 " \
            "y: 3.000000 " \
          "} " \
          "fontSize: 6.000000 " \
          "spacing: 2.000000 " \
          "tint: { " \
            "r: 0 " \
            "g: 0 " \
            "b: 0 " \
            "a: 255 " \
          "} " \
        "}"
      ]
    )
  end

  When "we draw it with x and y for position" do
    @font.draw(
      "y",
      x: 2, y: 1
    )
  end

  Then "Raylib receives the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(DrawTextEx) { " \
          "font: { " \
            "baseSize: 6 " \
            "glyphCount: 7 " \
            "glyphPadding: 8 " \
          "} " \
          "text: 'y' " \
          "position: { " \
            "x: 2.000000 " \
            "y: 1.000000 " \
          "} " \
          "fontSize: 6.000000 " \
          "spacing: 2.000000 " \
          "tint: { " \
            "r: 0 " \
            "g: 0 " \
            "b: 0 " \
            "a: 255 " \
          "} " \
        "}"
      ]
    )
  end

  Then "clean up" do
    @font = nil
  end
end

@unit.describe "Font#measure" do
  Given "we have a font loaded" do
    Taylor::Raylib.mock_call("MeasureTextEx", "1 2")
    Taylor::Raylib.mock_call("LoadFontEx", Font.mock_return(size: 9))
    @font = Font.new("./assets/tiny.ttf", size: 9)
    Taylor::Raylib.reset_calls
  end

  Then "we can measure the font" do
    expect(@font.measure("xx")).to_equal(Vector2[1, 2])
  end

  And "Raylib receives the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(MeasureTextEx) { " \
          "font: { " \
            "baseSize: 9 " \
            "glyphCount: 0 " \
            "glyphPadding: 0 " \
          "} " \
          "text: 'xx' " \
          "fontSize: 9.000000 " \
          "spacing: 2.000000 " \
        "}"
      ]
    )
  end

  When "measured with extra arguments" do
    Taylor::Raylib.mock_call("MeasureTextEx", "2 3")
    expect(@font.measure("qq", size: 11, spacing: 12)).to_equal(Vector2[2, 3])
  end

  Then "Raylib receives the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(MeasureTextEx) { " \
          "font: { " \
            "baseSize: 9 " \
            "glyphCount: 0 " \
            "glyphPadding: 0 " \
          "} " \
          "text: 'qq' " \
          "fontSize: 11.000000 " \
          "spacing: 12.000000 " \
        "}"
      ]
    )
  end

  Then "clean up" do
    @font = nil
  end
end

@unit.describe "Font#to_image" do
  Given "we have a font" do
    Taylor::Raylib.mock_call("ImageTextEx", Image.mock_return(width: 1, height: 2, mipmaps: 3, format: 4))
    Taylor::Raylib.mock_call("LoadFontEx", Font.mock_return(size: 11))
    @font = Font.new("./assets/tiny.ttf", size: 11)
    Taylor::Raylib.reset_calls
  end

  When "we call to_image " do
    @image = @font.to_image("xx")
  end

  Then "the image has the correct attributes" do
    expect(@image).to_be_a(Image)
    expect(@image.width).to_equal(1)
    expect(@image.height).to_equal(2)
    expect(@image.mipmaps).to_equal(3)
    expect(@image.format).to_equal(4)
  end

  And "Raylib was receives the correct methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(ImageTextEx) { " \
          "font: { " \
            "baseSize: 11 " \
            "glyphCount: 0 " \
            "glyphPadding: 0 " \
          "} " \
          "text: 'xx' " \
          "fontSize: 11.000000 " \
          "spacing: 2.000000 " \
          "tint: { " \
            "r: 0 " \
            "g: 0 " \
            "b: 0 " \
            "a: 255 " \
          "} " \
        "}"
      ]
    )
  end

  When "called with arguments" do
    Taylor::Raylib.mock_call("ImageTextEx", Image.mock_return(width: 2, height: 3, mipmaps: 4, format: 5))
    @image = @font.to_image("x", size: 13, spacing: 14, colour: Colour[2, 3, 4, 5])
  end

  Then "the image has the correct arguments" do
    expect(@image).to_be_a(Image)
    expect(@image.width).to_equal(2)
    expect(@image.height).to_equal(3)
    expect(@image.mipmaps).to_equal(4)
    expect(@image.format).to_equal(5)
  end

  And "Raylib was receives the correct methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(ImageTextEx) { " \
          "font: { " \
            "baseSize: 11 " \
            "glyphCount: 0 " \
            "glyphPadding: 0 " \
          "} " \
          "text: 'x' " \
          "fontSize: 13.000000 " \
          "spacing: 14.000000 " \
          "tint: { " \
            "r: 2 " \
            "g: 3 " \
            "b: 4 " \
            "a: 5 " \
          "} " \
        "}"
      ]
    )
  end

  Then "clean up" do
    @font = nil
  end
end
