@unit.describe "Key.pressed?" do
  Given "a key has been pressed" do
    Taylor::Raylib.mock_call("IsKeyPressed", "true")
    Taylor::Raylib.mock_call("IsKeyPressed", "false")
  end

  Then "return true" do
    expect(Key.pressed?(Key::A)).to_be_true
    expect(Key.pressed?(Key::B)).to_be_false
  end

  And "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(IsKeyPressed) { key: 65 }",
        "(IsKeyPressed) { key: 66 }"
      ]
    )
  end
end

@unit.describe "Key.down?" do
  Given "a key is down" do
    Taylor::Raylib.mock_call("IsKeyDown", "true")
    Taylor::Raylib.mock_call("IsKeyDown", "false")
  end

  Then "return true" do
    expect(Key.down?(Key::B)).to_be_true
    expect(Key.down?(Key::C)).to_be_false
  end

  And "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(IsKeyDown) { key: 66 }",
        "(IsKeyDown) { key: 67 }"
      ]
    )
  end
end

@unit.describe "Key.released?" do
  Given "a key is released" do
    Taylor::Raylib.mock_call("IsKeyReleased", "true")
    Taylor::Raylib.mock_call("IsKeyReleased", "false")
  end

  Then "return true" do
    expect(Key.released?(Key::C)).to_be_true
    expect(Key.released?(Key::D)).to_be_false
  end

  And "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(IsKeyReleased) { key: 67 }",
        "(IsKeyReleased) { key: 68 }"
      ]
    )
  end
end

@unit.describe "Key.up?" do
  Given "a key is up" do
    Taylor::Raylib.mock_call("IsKeyUp", "true")
    Taylor::Raylib.mock_call("IsKeyUp", "false")
  end

  Then "return true" do
    expect(Key.up?(Key::D)).to_be_true
    expect(Key.up?(Key::E)).to_be_false
  end

  And "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(IsKeyUp) { key: 68 }",
        "(IsKeyUp) { key: 69 }"
      ]
    )
  end
end

@unit.describe "Key.pressed" do
  Given "no key has been pressed" do
    Taylor::Raylib.mock_call("GetKeyPressed", "0")
  end

  Then "return nil" do
    expect(Key.pressed).to_be_nil
  end

  Given "a key has been pressed" do
    Taylor::Raylib.mock_call("GetKeyPressed", "65")
    Taylor::Raylib.mock_call("GetKeyPressed", "66")
  end

  Then "return the pressed keys one at a time" do
    expect(Key.pressed).to_equal(Key::A)
    expect(Key.pressed).to_equal(Key::B)
  end
end

@unit.describe "Key.pressed_character" do
  Given "no key has been pressed" do
    Taylor::Raylib.mock_call("GetCharPressed", "0")
  end

  Then "return nil" do
    expect(Key.pressed_character).to_be_nil
  end

  Given "a key has been pressed" do
    Taylor::Raylib.mock_call("GetCharPressed", "97")
    Taylor::Raylib.mock_call("GetCharPressed", "66")
  end

  Then "return the pressed characters one at a time" do
    expect(Key.pressed_character).to_equal("a")
    expect(Key.pressed_character).to_equal("B")
  end
end
