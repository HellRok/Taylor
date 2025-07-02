class Test
  class Input
    class Gesture_Test < Test::Base
      def test_enabled=
        Gesture.enabled = Gesture::TAP | Gesture::HOLD

        assert_called [
          "(SetGesturesEnabled) { flags: 5 }"
        ]
      end
    end
  end
end
