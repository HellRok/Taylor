@unit.describe "Touch.[]" do
  Given "the screen has been touched" do
    Taylor::Raylib.mock_call("GetTouchPosition", Vector2.mock_return(x: 5, y: 6))
  end

  Then "return the touch position" do
    expect(Touch[4]).to_equal(Vector2[5, 6])
  end

  And "Raylib was called with the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(GetTouchPosition) { index: 4 }"
      ]
    )
  end
end

@unit.describe "Touch.position_for" do
  Given "the screen has been touched" do
    Taylor::Raylib.mock_call("GetTouchPosition", Vector2.mock_return(x: 6, y: 7))
  end

  Then "return the touch position" do
    expect(Touch.position_for(6)).to_equal(Vector2[6, 7])
  end

  And "Raylib was called with the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(GetTouchPosition) { index: 6 }"
      ]
    )
  end
end

@unit.describe "Touch.positions" do
  Given "the screen has been touched a few times" do
    Taylor::Raylib.mock_call("GetTouchPosition", Vector2.mock_return(x: 1, y: 2))
    Taylor::Raylib.mock_call("GetTouchPosition", Vector2.mock_return(x: 2, y: 3))
    Taylor::Raylib.mock_call("GetTouchPosition", Vector2.mock_return(x: 3, y: 4))
    Taylor::Raylib.mock_call("GetTouchPosition", Vector2.mock_return(x: 0, y: 0))
  end

  Then "return the touch position" do
    positions = Touch.positions
    expect(positions[0]).to_equal(Vector2[1, 2])
    expect(positions[1]).to_equal(Vector2[2, 3])
    expect(positions[2]).to_equal(Vector2[3, 4])
  end

  And "Raylib was called with the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(GetTouchPosition) { index: 0 }",
        "(GetTouchPosition) { index: 1 }",
        "(GetTouchPosition) { index: 2 }",
        "(GetTouchPosition) { index: 3 }"
      ]
    )
    Taylor::Raylib.reset_calls
  end

  But "when there are too many positions" do
    21.times { Taylor::Raylib.mock_call("GetTouchPosition", Vector2.mock_return(x: 1, y: 2)) }
  end

  Then "raise an error assuming it's a bug" do
    expect { Touch.positions }.to_raise(
      Touch::TooManyTouchesError,
      "We received more than the expected limit of touches, is your input device having an issue?"
    )
  end

  And "Raylib was called with the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(GetTouchPosition) { index: 0 }",
        "(GetTouchPosition) { index: 1 }",
        "(GetTouchPosition) { index: 2 }",
        "(GetTouchPosition) { index: 3 }",
        "(GetTouchPosition) { index: 4 }",
        "(GetTouchPosition) { index: 5 }",
        "(GetTouchPosition) { index: 6 }",
        "(GetTouchPosition) { index: 7 }",
        "(GetTouchPosition) { index: 8 }",
        "(GetTouchPosition) { index: 9 }",
        "(GetTouchPosition) { index: 10 }",
        "(GetTouchPosition) { index: 11 }",
        "(GetTouchPosition) { index: 12 }",
        "(GetTouchPosition) { index: 13 }",
        "(GetTouchPosition) { index: 14 }",
        "(GetTouchPosition) { index: 15 }",
        "(GetTouchPosition) { index: 16 }",
        "(GetTouchPosition) { index: 17 }",
        "(GetTouchPosition) { index: 18 }",
        "(GetTouchPosition) { index: 19 }",
        "(GetTouchPosition) { index: 20 }"
      ]
    )
  end
end
