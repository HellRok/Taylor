@unit.describe "Gamepad#initialize" do
  gamepad = Gamepad.new(index: 1)

  expect(gamepad).to_be_a(Gamepad)
  expect(gamepad.index).to_equal(1)
end

@unit.describe "Gamepad#[]" do
  Given "one gamepad is available" do
    Taylor::Raylib.mock_call("IsGamepadAvailable", "true")
    Taylor::Raylib.mock_call("IsGamepadAvailable", "false")
  end

  Then "we can get that gamepad" do
    gamepad = Gamepad[0]
    expect(gamepad).to_be_a(Gamepad)
    expect(gamepad.index).to_equal(0)
  end

  Given "two gamepads are available" do
    Taylor::Raylib.mock_call("IsGamepadAvailable", "true")
    Taylor::Raylib.mock_call("IsGamepadAvailable", "true")
    Taylor::Raylib.mock_call("IsGamepadAvailable", "false")
  end

  Then "it raises when trying to get a negative index" do
    expect {
      Gamepad[-1]
    }.to_raise(ArgumentError, "Must be an integer in (0..1)")
  end

  Given "three gamepads are available" do
    Taylor::Raylib.mock_call("IsGamepadAvailable", "true")
    Taylor::Raylib.mock_call("IsGamepadAvailable", "true")
    Taylor::Raylib.mock_call("IsGamepadAvailable", "true")
    Taylor::Raylib.mock_call("IsGamepadAvailable", "false")
  end

  Then "it when we try to access the fourth index" do
    expect {
      Gamepad[3]
    }.to_raise(ArgumentError, "Must be an integer in (0..2)")
  end
end

@unit.describe "Gamepad.all" do
  Given "there are two gamepads available" do
    Taylor::Raylib.mock_call("IsGamepadAvailable", "true")
    Taylor::Raylib.mock_call("IsGamepadAvailable", "true")
    Taylor::Raylib.mock_call("IsGamepadAvailable", "false")
  end

  Then "we can get those gamepads" do
    gamepads = Gamepad.all

    expect(gamepads.size).to_equal(2)
    expect(gamepads[0]).to_be_a(Gamepad)
    expect(gamepads[0].index).to_equal(0)
    expect(gamepads[1]).to_be_a(Gamepad)
    expect(gamepads[1].index).to_equal(1)
  end

  Given "there are too many gamepads connected" do
    11.times { Taylor::Raylib.mock_call("IsGamepadAvailable", "true") }
  end

  Then "raise an error suggesting it's a bug" do
    expect { Gamepad.all }.to_raise(
      Gamepad::TooManyGamepadsError,
      "We received more than the expected limit of gamepads, if you mean to have more than 10 set Gamepad::MAX_GAMEPADS higher"
    )
  end
end

@unit.describe "Gamepad#available?" do
  Given "there is a gamepad available" do
    Taylor::Raylib.mock_call("IsGamepadAvailable", "true")
    Taylor::Raylib.mock_call("IsGamepadAvailable", "false")
  end

  Then "it is available" do
    expect(Gamepad.new(index: 0).available?).to_be_true
    expect(Gamepad.new(index: 1).available?).to_be_false
  end
end

@unit.describe "Gamepad#name" do
  Given "there is a gamepad" do
    Taylor::Raylib.mock_call("*GetGamepadName", "the gamepad name")
  end

  Then "return the name" do
    expect(Gamepad.new(index: 0).name).to_equal("the gamepad name")
  end
end

@unit.describe "Gamepad#pressed?" do
  Given "there is a gamepad" do
    Taylor::Raylib.mock_call("IsGamepadButtonPressed", "true")
    Taylor::Raylib.mock_call("IsGamepadButtonPressed", "false")
  end

  Then "return the button state" do
    expect(Gamepad.new(index: 0).pressed?(Gamepad::Dpad::UP)).to_be_true
    expect(Gamepad.new(index: 1).pressed?(Gamepad::Button::UP)).to_be_false
  end

  And "Raylib received the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(IsGamepadButtonPressed) { gamepad: 0 button: 1 }",
        "(IsGamepadButtonPressed) { gamepad: 1 button: 5 }"
      ]
    )
  end
end

@unit.describe "Gamepad#released?" do
  Given "there is a gamepad" do
    Taylor::Raylib.mock_call("IsGamepadButtonReleased", "true")
    Taylor::Raylib.mock_call("IsGamepadButtonReleased", "false")
  end

  Then "return the button state" do
    expect(Gamepad.new(index: 0).released?(Gamepad::Trigger::RIGHT_2)).to_be_true
    expect(Gamepad.new(index: 1).released?(Gamepad::Button::LEFT)).to_be_false
  end

  And "Raylib received the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(IsGamepadButtonReleased) { gamepad: 0 button: 12 }",
        "(IsGamepadButtonReleased) { gamepad: 1 button: 8 }"
      ]
    )
  end
end

@unit.describe "Gamepad#down?" do
  Given "there is a gamepad" do
    Taylor::Raylib.mock_call("IsGamepadButtonDown", "true")
    Taylor::Raylib.mock_call("IsGamepadButtonDown", "false")
  end

  Then "return the button state" do
    expect(Gamepad.new(index: 0).down?(Gamepad::Trigger::LEFT_1)).to_be_true
    expect(Gamepad.new(index: 1).down?(Gamepad::Button::RIGHT_JOYSTICK)).to_be_false
  end

  And "Raylib received the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(IsGamepadButtonDown) { gamepad: 0 button: 9 }",
        "(IsGamepadButtonDown) { gamepad: 1 button: 17 }"
      ]
    )
  end
end

@unit.describe "Gamepad#up?" do
  Given "there is a gamepad" do
    Taylor::Raylib.mock_call("IsGamepadButtonUp", "true")
    Taylor::Raylib.mock_call("IsGamepadButtonUp", "false")
  end

  Then "return the button state" do
    expect(Gamepad.new(index: 0).up?(Gamepad::Button::LEFT)).to_be_true
    expect(Gamepad.new(index: 1).up?(Gamepad::Trigger::RIGHT_2)).to_be_false
  end

  And "Raylib received the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(IsGamepadButtonUp) { gamepad: 0 button: 8 }",
        "(IsGamepadButtonUp) { gamepad: 1 button: 12 }"
      ]
    )
  end
end

@unit.describe "Gamepad#axis_count" do
  Given "there is a gamepad" do
    Taylor::Raylib.mock_call("GetGamepadAxisCount", "6")
  end

  Then "return the amount of axis" do
    expect(Gamepad.new(index: 0).axis_count).to_equal(6)
  end

  And "Raylib received the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(GetGamepadAxisCount) { gamepad: 0 }"
      ]
    )
  end
end

@unit.describe "Gamepad#axis" do
  Given "there is a gamepad" do
    Taylor::Raylib.mock_call("GetGamepadAxisCount", "2")
    Taylor::Raylib.mock_call("GetGamepadAxisMovement", "0.5")
  end

  Then "return the axis position" do
    expect(Gamepad.new(index: 0).axis(1)).to_equal(0.5)
  end

  And "Raylib received the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(GetGamepadAxisCount) { gamepad: 0 }",
        "(GetGamepadAxisMovement) { gamepad: 0 axis: 1 }"
      ]
    )
  end

  Given "there is a gamepad" do
    Taylor::Raylib.mock_call("GetGamepadAxisCount", "2")
  end

  Then "errors if called with a negative index" do
    expect {
      Gamepad.new(index: 0).axis(-1)
    }.to_raise(ArgumentError, "Must be an integer in (0..1)")
  end

  Given "there is a gamepad" do
    Taylor::Raylib.mock_call("GetGamepadAxisCount", "3")
  end

  Then "errors if called with an out of range index" do
    expect {
      Gamepad.new(index: 0).axis(3)
    }.to_raise(ArgumentError, "Must be an integer in (0..2)")
  end
end

@unit.describe "Gamepad.add_mappings" do
  Given "Raylib expects calls" do
    Taylor::Raylib.mock_call("SetGamepadMappings", "1")
    Taylor::Raylib.mock_call("SetGamepadMappings", "0")
  end

  Then "return the success" do
    expect(Gamepad.add_mappings("mappings-1")).to_be_true
    expect(Gamepad.add_mappings("mappings-2")).to_be_false
  end

  And "Raylib received the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(SetGamepadMappings) { mappings: 'mappings-1' }",
        "(SetGamepadMappings) { mappings: 'mappings-2' }"
      ]
    )
  end
end
