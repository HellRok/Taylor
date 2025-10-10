@unit.describe "RenderTexture#initialize" do
  When "we initialise a new render texture" do
    Taylor::Raylib.mock_call(
      "LoadRenderTexture",
      RenderTexture.mock_return(width: 1, height: 2)
    )
    @render_texture = RenderTexture.new(width: 1, height: 2)
  end

  Then "it has the correct attributes" do
    expect(@render_texture).to_be_a(RenderTexture)
    expect(@render_texture.width).to_equal(1)
    expect(@render_texture.height).to_equal(2)
    expect(@render_texture.texture.width).to_equal(1)
    expect(@render_texture.texture.height).to_equal(2)
  end

  And "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(LoadRenderTexture) { width: 1 height: 2 }"
      ]
    )
  end

  Then "clean up" do
    @render_texture = nil
  end
end

@unit.describe "RenderTexture#valid?" do
  When "we have an invalid render texture" do
    Taylor::Raylib.mock_call("IsRenderTextureValid", "false")
    @render_texture = RenderTexture.new(width: 2, height: 3)
  end

  Then "return false" do
    expect(@render_texture.valid?).to_be_false
  end

  When "we hav a valid render texture" do
    Taylor::Raylib.mock_call("IsRenderTextureValid", "true")
  end

  Then "return true" do
    expect(@render_texture.valid?).to_be_true
  end

  Then "clean up" do
    @render_texture = nil
  end
end

@unit.describe "RenderTexture#to_h" do
  When "we have a render texture" do
    Taylor::Raylib.mock_call(
      "LoadRenderTexture",
      RenderTexture.mock_return(width: 2, height: 3)
    )
    @render_texture = RenderTexture.new(width: 2, height: 3)
  end

  Then "return a hash with the correct attributes" do
    expect(@render_texture.to_h).to_equal(
      {
        width: 2,
        height: 3
      }
    )
  end

  Then "clean up" do
    @render_texture = nil
  end
end

@unit.describe "RenderTexture#texture" do
  Given "we have a render texture" do
    @render_texture = RenderTexture.new(width: 3, height: 4)
  end

  Then "texture will return a Texture2D" do
    expect(@render_texture.texture).to_be_a(Texture2D)
  end

  Then "clean up" do
    @render_texture = nil
  end
end

@unit.describe "RenderTexture#begin_drawing" do
  When "we call begin_drawing" do
    Taylor::Raylib.mock_call(
      "LoadRenderTexture",
      RenderTexture.mock_return(width: 3, height: 4)
    )
    texture = RenderTexture.new(width: 3, height: 4)
    Taylor::Raylib.reset_calls
    texture.begin_drawing
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(BeginTextureMode) { target: { id: 0 texture.width: 3 texture.height: 4 texture.mipmaps: 0 texture.format: 0 depth.width: 3 depth.height: 4 depth.mipmaps: 0 depth.format: 0 } }"
      ]
    )
  end
end

@unit.describe "RenderTexture#end_drawing" do
  When "we call end_drawing" do
    Taylor::Raylib.mock_call(
      "LoadRenderTexture",
      RenderTexture.mock_return(width: 3, height: 4)
    )
    texture = RenderTexture.new(width: 3, height: 4)
    Taylor::Raylib.reset_calls
    texture.end_drawing
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(EndTextureMode) { }"
      ]
    )
  end
end

@unit.describe "RenderTexture#draw" do
  Given "we have a render texture" do
    Taylor::Raylib.mock_call(
      "LoadRenderTexture",
      RenderTexture.mock_return(width: 1, height: 2)
    )
    @texture = RenderTexture.new(width: 1, height: 2)
    Taylor::Raylib.reset_calls
  end

  When "we call draw" do
    @texture.draw do
      Window.clear(colour: Colour[1, 0, 0, 0])
    end
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(BeginTextureMode) { target: { id: 0 texture.width: 1 texture.height: 2 texture.mipmaps: 0 texture.format: 0 depth.width: 1 depth.height: 2 depth.mipmaps: 0 depth.format: 0 } }",
        "(IsWindowReady) { }",
        "(ClearBackground) { color: { r: 1 g: 0 b: 0 a: 0 } }",
        "(EndTextureMode) { }"
      ]
    )
  end

  But "if an error is raised in the block" do
    @texture.draw do
      Window.clear(colour: Colour[2, 0, 0, 0])
      raise StandardError, "Oops!"
      Window.clear(colour: Colour[3, 0, 0, 0]) # standard:disable Lint/UnreachableCode
    end
  rescue => error
    expect(error.message).to_equal("Oops!")
  end

  Then "we make sure to call end_drawing" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(BeginTextureMode) { target: { id: 0 texture.width: 1 texture.height: 2 texture.mipmaps: 0 texture.format: 0 depth.width: 1 depth.height: 2 depth.mipmaps: 0 depth.format: 0 } }",
        "(IsWindowReady) { }",
        "(ClearBackground) { color: { r: 2 g: 0 b: 0 a: 0 } }",
        "(EndTextureMode) { }"
      ]
    )
  end

  Then "clean up" do
    @render_texture = nil
    @texture = nil
  end
end
