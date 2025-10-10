@unit.describe "Texture2D#initialize" do
  When "we initialize a texture" do
    Taylor::Raylib.mock_call(
      "LoadTexture",
      Texture2D.mock_return(id: 1, width: 2, height: 3, mipmaps: 4, format: 5)
    )

    @texture = Texture2D.new("./assets/test.png")
  end

  Then "it has the correct attributes" do
    expect(@texture).to_be_a(Texture2D)
    expect(@texture.id).to_equal(1)
    expect(@texture.width).to_equal(2)
    expect(@texture.height).to_equal(3)
    expect(@texture.mipmaps).to_equal(4)
    expect(@texture.format).to_equal(5)
  end

  But "if we load a file that doesn't exist, raise an error" do
    Taylor::Raylib.mock_call("FileExists", "false")

    expect {
      Texture2D.new("./assets/fail.png")
    }.to_raise(Texture2D::NotFoundError, "Unable to find './assets/fail.png'")
  end
end

@unit.describe "Texture2D#unload" do
  Given "we have a texture" do
    Taylor::Raylib.mock_call(
      "LoadTexture",
      Texture2D.mock_return(id: 2, width: 3, height: 4, mipmaps: 5, format: 6)
    )
    @texture = Texture2D.new("./assets/test.png")
    Taylor::Raylib.reset_calls
  end

  When "we call unload" do
    @texture.unload
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(UnloadTexture) { texture: { id: 2 width: 3 height: 4 mipmaps: 5 format: 6 } }"
      ]
    )
  end
end

@unit.describe "Texture2D#valid?" do
  When "we have a valid texture" do
    Taylor::Raylib.mock_call("IsTextureValid", "true")
    @texture = Texture2D.new("./assets/test.png")
  end

  Then "return true" do
    expect(@texture.valid?).to_be_true
  end

  But "we have an invalid texture" do
    Taylor::Raylib.mock_call("IsTextureValid", "false")
  end

  Then "return false" do
    expect(@texture.valid?).to_be_false
  end
end

@unit.describe "Texture2D#to_h" do
  Given "we have a texture" do
    Taylor::Raylib.mock_call(
      "LoadTexture",
      Texture2D.mock_return(id: 3, width: 4, height: 5, mipmaps: 6, format: 7)
    )
    @texture = Texture2D.new("./assets/test.png")
  end

  Then "return a hash with the correct attributes" do
    expect(@texture.to_h).to_equal(
      {
        id: 3,
        width: 4,
        height: 5,
        mipmaps: 6,
        format: 7
      }
    )
  end
end

@unit.describe "Texture2D#filter=" do
  Given "we have a texture" do
    Taylor::Raylib.mock_call(
      "LoadTexture",
      Texture2D.mock_return(id: 3, width: 4, height: 5, mipmaps: 6, format: 7)
    )
    @texture = Texture2D.new("./assets/test.png")
    Taylor::Raylib.reset_calls
  end

  Then "the filter attribute defaults to NO_FILTER" do
    expect(@texture.filter).to_equal(Texture2D::NO_FILTER)
  end

  When "we set the filter" do
    expect {
      @texture.filter = Texture2D::BILINEAR
    }.to_equal(Texture2D::BILINEAR)
  end

  Then "the filter attribute is updated " do
    expect(@texture.filter).to_equal(Texture2D::BILINEAR)
  end

  And "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(SetTextureFilter) { texture: { id: 3 width: 4 height: 5 mipmaps: 6 format: 7 } filter: 1 }"
      ]
    )
  end

  But "when set too low, raise an error" do
    expect {
      @texture.filter = -1
    }.to_raise(
      ArgumentError,
      "Filter must be one of: Texture2D::NO_FILTER, " \
      "Texture2D::BILINEAR, Texture2D::TRILINEAR, " \
      "Texture2D::ANISOTROPIC_4X, Texture2D::ANISOTROPIC_8X, " \
      "or Texture2D::ANISOTROPIC_16X"
    )
  end

  Or "when set too high" do
    expect {
      @texture.filter = 6
    }.to_raise(
      ArgumentError,
      "Filter must be one of: Texture2D::NO_FILTER, " \
      "Texture2D::BILINEAR, Texture2D::TRILINEAR, " \
      "Texture2D::ANISOTROPIC_4X, Texture2D::ANISOTROPIC_8X, " \
      "or Texture2D::ANISOTROPIC_16X"
    )
  end
end

@unit.describe "Texture2D#generate_mipmaps" do
  Given "we have a texture" do
    Taylor::Raylib.mock_call(
      "LoadTexture",
      Texture2D.mock_return(id: 4, width: 5, height: 6, mipmaps: 7, format: 8)
    )
    @texture = Texture2D.new("./assets/test.png")
    Taylor::Raylib.reset_calls
  end

  When "we call generate_mipmaps" do
    @texture.generate_mipmaps
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(GenTextureMipmaps) { texture: { id: 4 width: 5 height: 6 mipmaps: 7 format: 8 } }"
      ]
    )
  end
end

@unit.describe "#Texture2D#draw" do
  Given "we have a texture" do
    Taylor::Raylib.mock_call(
      "LoadTexture",
      Texture2D.mock_return(id: 5, width: 6, height: 7, mipmaps: 8, format: 9)
    )
    @texture = Texture2D.new("./assets/test.png")
    Taylor::Raylib.reset_calls
  end

  When "we call draw with no arguments" do
    @texture.draw
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(DrawTexturePro) { " \
          "texture: { id: 5 width: 6 height: 7 mipmaps: 8 format: 9 } " \
          "source: { x: 0.000000 y: 0.000000 width: 6.000000 height: 7.000000 } " \
          "dest: { x: 0.000000 y: 0.000000 width: 6.000000 height: 7.000000 } " \
          "origin: { x: 3.000000 y: 3.500000 } " \
          "rotation: 0.000000 " \
          "tint: { r: 255 g: 255 b: 255 a: 255 } " \
        "}"
      ]
    )
  end

  When "we call draw with the simple arguments" do
    @texture.draw(
      origin: Vector2[11, 12],
      rotation: 13,
      colour: Colour[14, 15, 16, 17]
    )
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(DrawTexturePro) { " \
          "texture: { id: 5 width: 6 height: 7 mipmaps: 8 format: 9 } " \
          "source: { x: 0.000000 y: 0.000000 width: 6.000000 height: 7.000000 } " \
          "dest: { x: 0.000000 y: 0.000000 width: 6.000000 height: 7.000000 } " \
          "origin: { x: 11.000000 y: 12.000000 } " \
          "rotation: 13.000000 " \
          "tint: { r: 14 g: 15 b: 16 a: 17 } " \
        "}"
      ]
    )
  end

  When "called with source but no destination/position" do
    @texture.draw(
      source: Rectangle[10, 11, 12, 13]
    )
  end

  Then "it uses the source width and height for the destination and origin" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(DrawTexturePro) { " \
          "texture: { id: 5 width: 6 height: 7 mipmaps: 8 format: 9 } " \
          "source: { x: 10.000000 y: 11.000000 width: 12.000000 height: 13.000000 } " \
          "dest: { x: 0.000000 y: 0.000000 width: 12.000000 height: 13.000000 } " \
          "origin: { x: 6.000000 y: 6.500000 } " \
          "rotation: 0.000000 " \
          "tint: { r: 255 g: 255 b: 255 a: 255 } " \
        "}"
      ]
    )
  end

  When "called with position" do
    @texture.draw(position: Vector2[10, 11])
  end

  Then "it uses the position in the destination" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(DrawTexturePro) { " \
          "texture: { id: 5 width: 6 height: 7 mipmaps: 8 format: 9 } " \
          "source: { x: 0.000000 y: 0.000000 width: 6.000000 height: 7.000000 } " \
          "dest: { x: 10.000000 y: 11.000000 width: 6.000000 height: 7.000000 } " \
          "origin: { x: 3.000000 y: 3.500000 } " \
          "rotation: 0.000000 " \
          "tint: { r: 255 g: 255 b: 255 a: 255 } " \
        "}"
      ]
    )
  end

  When "called with destination" do
    @texture.draw(destination: Rectangle[10, 11, 12, 13])
  end

  Then "it uses the destination" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(DrawTexturePro) { " \
          "texture: { id: 5 width: 6 height: 7 mipmaps: 8 format: 9 } " \
          "source: { x: 0.000000 y: 0.000000 width: 6.000000 height: 7.000000 } " \
          "dest: { x: 10.000000 y: 11.000000 width: 12.000000 height: 13.000000 } " \
          "origin: { x: 6.000000 y: 6.500000 } " \
          "rotation: 0.000000 " \
          "tint: { r: 255 g: 255 b: 255 a: 255 } " \
        "}"
      ]
    )
  end

  But "when called with both position and destination, raises an error" do
    expect {
      @texture.draw(
        position: Vector2[2, 3],
        destination: Rectangle[4, 5, 6, 7]
      )
    }.to_raise(ArgumentError, "Can't specify both position and destination")
  end
end
