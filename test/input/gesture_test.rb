class Test
  class Input
    class Gesture_Test < Test::Base
      def test_enabled=
        Gesture.enabled = Gesture::TAP | Gesture::HOLD

        assert_called [
          "(SetGesturesEnabled) { flags: 5 }"
        ]
      end

      def test_detected
        Taylor::Raylib.mock_call("GetGestureDetected", Gesture::SWIPE_RIGHT.to_s)
        Taylor::Raylib.mock_call("GetGestureDetected", Gesture::SWIPE_LEFT.to_s)

        assert_equal Gesture::SWIPE_RIGHT, Gesture.detected
        assert_equal Gesture::SWIPE_LEFT, Gesture.detected

        assert_called [
          "(GetGestureDetected) { }",
          "(GetGestureDetected) { }"
        ]
      end

      def test_detected?
        Taylor::Raylib.mock_call("IsGestureDetected", "true")
        Taylor::Raylib.mock_call("IsGestureDetected", "false")

        assert_true Gesture.detected? Gesture::TAP
        assert_false Gesture.detected? Gesture::PINCH_IN

        assert_called [
          "(IsGestureDetected) { gesture: 1 }",
          "(IsGestureDetected) { gesture: 256 }"
        ]
      end

      def test_duration
        Taylor::Raylib.mock_call("GetGestureHoldDuration", "0.25")
        Taylor::Raylib.mock_call("GetGestureHoldDuration", "2.00")

        assert_equal 0.25, Gesture.duration
        assert_equal 2.00, Gesture.duration

        assert_called [
          "(GetGestureHoldDuration) { }",
          "(GetGestureHoldDuration) { }"
        ]
      end

      def test_dragged
        Taylor::Raylib.mock_call("GetGestureDragVector", Vector2.mock_return(x: 1, y: 2))
        Taylor::Raylib.mock_call("GetGestureDragVector", Vector2.mock_return(x: 3, y: 4))

        assert_equal Vector2[1, 2], Gesture.dragged
        assert_equal Vector2[3, 4], Gesture.dragged

        assert_called [
          "(GetGestureDragVector) { }",
          "(GetGestureDragVector) { }"
        ]
      end
    end
  end
end
