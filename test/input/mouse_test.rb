@unit.describe "Mouse.pressed?" do
  Given "a mouse button has been pressed" do
    Taylor::Raylib.mock_call("IsMouseButtonPressed", "true")
    Taylor::Raylib.mock_call("IsMouseButtonPressed", "false")
  end

  Then "return true" do
    expect(Mouse.pressed?(Mouse::LEFT)).to_be_true
    expect(Mouse.pressed?(Mouse::RIGHT)).to_be_false
  end

  And "Raylib was called with the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(IsMouseButtonPressed) { button: 0 }",
        "(IsMouseButtonPressed) { button: 1 }"
      ]
    )
  end
end

@unit.describe "Mouse.down?" do
  Given "a mouse button is down" do
    Taylor::Raylib.mock_call("IsMouseButtonDown", "true")
    Taylor::Raylib.mock_call("IsMouseButtonDown", "false")
  end

  Then "return true" do
    expect(Mouse.down?(Mouse::RIGHT)).to_be_true
    expect(Mouse.down?(Mouse::LEFT)).to_be_false
  end

  And "Raylib was called with the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(IsMouseButtonDown) { button: 1 }",
        "(IsMouseButtonDown) { button: 0 }"
      ]
    )
  end
end

@unit.describe "Mouse.released?" do
  Given "a mouse button has been released" do
    Taylor::Raylib.mock_call("IsMouseButtonReleased", "true")
    Taylor::Raylib.mock_call("IsMouseButtonReleased", "false")
  end

  Then "return true" do
    expect(Mouse.released?(Mouse::LEFT)).to_be_true
    expect(Mouse.released?(Mouse::RIGHT)).to_be_false
  end

  And "Raylib was called with the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(IsMouseButtonReleased) { button: 0 }",
        "(IsMouseButtonReleased) { button: 1 }"
      ]
    )
  end
end

@unit.describe "Mouse.up?" do
  Given "a mouse button is up" do
    Taylor::Raylib.mock_call("IsMouseButtonUp", "true")
    Taylor::Raylib.mock_call("IsMouseButtonUp", "false")
  end

  Then "return true" do
    expect(Mouse.up?(Mouse::RIGHT)).to_be_true
    expect(Mouse.up?(Mouse::LEFT)).to_be_false
  end

  And "Raylib was called with the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(IsMouseButtonUp) { button: 1 }",
        "(IsMouseButtonUp) { button: 0 }"
      ]
    )
  end
end

@unit.describe "Mouse.position" do
  Given "a mouse is attached" do
    Taylor::Raylib.mock_call("GetMousePosition", Vector2.mock_return(x: 1, y: 2))
  end

  Then "return its position" do
    expect(Mouse.position).to_equal(Vector2[1, 2])
  end
end

@unit.describe "Mouse.position=" do
  Given "we set the position" do
    Mouse.position = Vector2[4, 8]
  end

  Then "Raylib was called with the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(SetMousePosition) { x: 4 y: 8 }"
      ]
    )
  end
end

@unit.describe "Mouse.offset=" do
  Given "we set the offset" do
    Mouse.offset = Vector2[2, 3]
  end

  Then "Raylib was called with the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(SetMouseOffset) { offsetX: 2 offsetY: 3 }"
      ]
    )
  end
end

@unit.describe "Mouse.scale=" do
  Given "we set the scale" do
    Mouse.scale = Vector2[0.5, 2.0]
  end

  Then "Raylib was called with the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(SetMouseScale) { scaleX: 0.500000 scaleY: 2.000000 }"
      ]
    )
  end
end

@unit.describe "Mouse.wheel_moved" do
  Given "the mouse wheel has moved" do
    Taylor::Raylib.mock_call("GetMouseWheelMoveV", Vector2.mock_return(x: 3, y: 4))
  end

  Then "return the movement" do
    expect(Mouse.wheel_moved).to_equal(Vector2[3, 4])
  end
end
