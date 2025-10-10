@unit.describe "Camera2D#initialize" do
  Given "we initialize a camera" do
    @camera = Camera2D.new(
      target: Vector2.new(x: 1, y: 2),
      offset: Vector2.new(x: 3, y: 4),
      rotation: 5,
      zoom: 6
    )
  end

  Then "it's setup correctly" do
    expect(@camera).to_be_a(Camera2D)
    expect(@camera.target.x).to_equal(1)
    expect(@camera.target.y).to_equal(2)
    expect(@camera.offset.x).to_equal(3)
    expect(@camera.offset.y).to_equal(4)
    expect(@camera.rotation).to_equal(5)
    expect(@camera.zoom).to_equal(6)
  end

  Given "we don't specify anything" do
    @camera = Camera2D.new
  end

  Then "it's setup correctly" do
    expect(@camera).to_be_a(Camera2D)
    expect(@camera.offset.x).to_equal(0)
    expect(@camera.offset.y).to_equal(0)
    expect(@camera.target.x).to_equal(0)
    expect(@camera.target.y).to_equal(0)
    expect(@camera.rotation).to_equal(0)
    expect(@camera.zoom).to_equal(1)
  end

  When "we set all the attributes" do
    @camera.target.x = 7
    @camera.target.y = 6
    @camera.offset.x = 5
    @camera.offset.y = 4
    @camera.rotation = 3
    @camera.zoom = 2
  end

  Then "they're persisted" do
    expect(@camera.target.x).to_equal(7)
    expect(@camera.target.y).to_equal(6)
    expect(@camera.offset.x).to_equal(5)
    expect(@camera.offset.y).to_equal(4)
    expect(@camera.rotation).to_equal(3)
    expect(@camera.zoom).to_equal(2)
  end

  Then "clean up" do
    @camera = nil
  end
end

@unit.describe "Camera2D#offset" do
  Given "we have a camera and a vector" do
    @offset = Vector2[0, 0]
    @camera = Camera2D.new(
      offset: @offset,
      target: Vector2.new(x: 0, y: 0),
      rotation: 0,
      zoom: 0
    )
  end

  Then "they are equal" do
    expect(@camera.offset).to_equal(@offset)
  end

  But "they are not the same object" do
    expect(@camera.offset.object_id).not_to_equal(@offset.object_id)
  end

  Then "clean up" do
    @camera = nil
  end
end

@unit.describe "Camera2D#target" do
  Given "we have a camera and a vector" do
    @target = Vector2[0, 0]
    @camera = Camera2D.new(
      offset: Vector2.new(x: 0, y: 0),
      target: @target,
      rotation: 0,
      zoom: 0
    )
  end

  Then "they are equal" do
    expect(@camera.target).to_equal(@target)
  end

  But "they are not the same object" do
    expect(@camera.target.object_id).not_to_equal(@target.object_id)
  end

  Then "clean up" do
    @camera = nil
  end
end

@unit.describe "Camera2D#to_h" do
  Given "we initialize a camera" do
    @camera = Camera2D.new(
      target: Vector2.new(x: 1, y: 2),
      offset: Vector2.new(x: 3, y: 4),
      rotation: 5,
      zoom: 6
    )
  end

  Then "we get a hash of it's attributes" do
    expect(@camera.to_h).to_equal(
      {
        target: {
          x: 1,
          y: 2
        },
        offset: {
          x: 3,
          y: 4
        },
        rotation: 5,
        zoom: 6
      }
    )
  end

  Then "clean up" do
    @camera = nil
  end
end

@unit.describe "Camera2D#draw" do
  When "we draw the camera with content" do
    @rectangle = Rectangle[2, 2, 6, 6, Colour::RED]
    @camera = Camera2D.new

    @camera.draw do
      @rectangle.draw
    end
  end

  Then "Raylib is called with the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(BeginMode2D) { camera: { offset.x: 0.000000 offset.y: 0.000000 target.x: 0.000000 target.y: 0.000000 rotation: 0.000000 zoom: 1.000000 } }",
        "(DrawRectangleRec) { rec: { x: 2.000000 y: 2.000000 width: 6.000000 height: 6.000000 } color: { r: 230 g: 41 b: 55 a: 255 } }",
        "(EndMode2D) { }"
      ]
    )
    Taylor::Raylib.reset_calls
  end

  When "we offset the camera" do
    @camera.offset.x = -2
    @camera.offset.y = -3
  end

  And "draw again" do
    @camera.draw do
      @rectangle.draw
    end
  end

  Then "Raylib is called with the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(BeginMode2D) { camera: { offset.x: -2.000000 offset.y: -3.000000 target.x: 0.000000 target.y: 0.000000 rotation: 0.000000 zoom: 1.000000 } }",
        "(DrawRectangleRec) { rec: { x: 2.000000 y: 2.000000 width: 6.000000 height: 6.000000 } color: { r: 230 g: 41 b: 55 a: 255 } }",
        "(EndMode2D) { }"
      ]
    )
    Taylor::Raylib.reset_calls
  end

  Then "clean up" do
    @camera = nil
    @rectangle = nil
  end
end

@unit.describe "Camera2D#as_in_viewport" do
  Given "Raylib expects the method" do
    Taylor::Raylib.mock_call("GetWorldToScreen2D", Vector2.mock_return(x: 2, y: 4))
  end

  When "we view the vector through the camera" do
    camera = Camera2D.new(target: Vector2[2, 1], offset: Vector2[3, 2])
    vector = Vector2[3, 3]

    @result = camera.as_in_viewport(vector)
  end

  Then "it returns the vector as though viewed through the camera" do
    expect(@result).to_equal(Vector2[2, 4])
  end

  And "Raylib is called with the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(GetWorldToScreen2D) { position: { x: 3.000000 y: 3.000000 } camera: { offset.x: 3.000000 offset.y: 2.000000 target.x: 2.000000 target.y: 1.000000 rotation: 0.000000 zoom: 1.000000 } }"
      ]
    )
    Taylor::Raylib.reset_calls
  end

  Then "clean up" do
    @camera = nil
  end
end

@unit.describe "Camera2D#as_in_world" do
  Given "Raylib expects the method" do
    Taylor::Raylib.mock_call("GetScreenToWorld2D", Vector2.mock_return(x: 2, y: 4))
  end

  When "we view the vector through the camera" do
    camera = Camera2D.new(target: Vector2[2, 1], offset: Vector2[3, 2])
    vector = Vector2[4, 4]

    @result = camera.as_in_world(vector)
  end

  Then "it returns the vector as though viewed through the camera" do
    expect(@result).to_equal(Vector2[2, 4])
  end

  And "Raylib is called with the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(GetScreenToWorld2D) { position: { x: 4.000000 y: 4.000000 } camera: { offset.x: 3.000000 offset.y: 2.000000 target.x: 2.000000 target.y: 1.000000 rotation: 0.000000 zoom: 1.000000 } }"
      ]
    )
    Taylor::Raylib.reset_calls
  end

  Then "clean up" do
    @camera = nil
  end
end
