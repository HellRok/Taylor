@unit.describe "Gesture.enabled=" do
  When "we set the gestures" do
    Gesture.enabled = Gesture::TAP | Gesture::HOLD
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(SetGesturesEnabled) { flags: 5 }"
      ]
    )
  end
end

@unit.describe "Gesture.detected" do
  Given "a player has done gestures" do
    Taylor::Raylib.mock_call("GetGestureDetected", Gesture::SWIPE_RIGHT.to_s)
    Taylor::Raylib.mock_call("GetGestureDetected", Gesture::SWIPE_LEFT.to_s)
  end

  Then "we get the gestures" do
    expect(Gesture.detected).to_equal(Gesture::SWIPE_RIGHT)
    expect(Gesture.detected).to_equal(Gesture::SWIPE_LEFT)
  end
end

@unit.describe "Gesture.detected?" do
  Given "a player has only tapped" do
    Taylor::Raylib.mock_call("IsGestureDetected", "true")
    Taylor::Raylib.mock_call("IsGestureDetected", "false")
  end

  Then "we detect the gestures" do
    expect(Gesture.detected?(Gesture::TAP)).to_be_true
    expect(Gesture.detected?(Gesture::PINCH_IN)).to_be_false
  end

  And "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(IsGestureDetected) { gesture: 1 }",
        "(IsGestureDetected) { gesture: 256 }"
      ]
    )
  end
end

@unit.describe "Gesture.duration" do
  Given "a player has done gestures" do
    Taylor::Raylib.mock_call("GetGestureHoldDuration", "0.25")
    Taylor::Raylib.mock_call("GetGestureHoldDuration", "2.00")
  end

  Then "return the gesture durations" do
    expect(Gesture.duration).to_equal(0.25)
    expect(Gesture.duration).to_equal(2.00)
  end
end

@unit.describe "Gesture.dragged" do
  Given "a player has done gestures" do
    Taylor::Raylib.mock_call("GetGestureDragVector", Vector2.mock_return(x: 1, y: 2))
    Taylor::Raylib.mock_call("GetGestureDragVector", Vector2.mock_return(x: 3, y: 4))
  end

  Then "return the gesture drag vectors" do
    expect(Gesture.dragged).to_equal(Vector2[1, 2])
    expect(Gesture.dragged).to_equal(Vector2[3, 4])
  end
end

@unit.describe "Gesture.drag_angle" do
  Given "a player has done gestures" do
    Taylor::Raylib.mock_call("GetGestureDragAngle", "90.0")
    Taylor::Raylib.mock_call("GetGestureDragAngle", "128.5")
  end

  Then "return the gesture drag vectors" do
    expect(Gesture.drag_angle).to_equal(90.0)
    expect(Gesture.drag_angle).to_equal(128.5)
  end
end

@unit.describe "Gesture.pinched" do
  Given "a player has done gestures" do
    Taylor::Raylib.mock_call("GetGesturePinchVector", Vector2.mock_return(x: 2, y: 3))
    Taylor::Raylib.mock_call("GetGesturePinchVector", Vector2.mock_return(x: 4, y: 5))
  end

  Then "return the gesture drag vectors" do
    expect(Gesture.pinched).to_equal(Vector2[2, 3])
    expect(Gesture.pinched).to_equal(Vector2[4, 5])
  end
end

@unit.describe "Gesture.pinch_angle" do
  Given "a player has done gestures" do
    Taylor::Raylib.mock_call("GetGesturePinchAngle", "72.0")
    Taylor::Raylib.mock_call("GetGesturePinchAngle", "304.75")
  end

  Then "return the gesture drag vectors" do
    expect(Gesture.pinch_angle).to_equal(72.0)
    expect(Gesture.pinch_angle).to_equal(304.75)
  end
end
