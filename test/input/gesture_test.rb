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
    end
  end
end
