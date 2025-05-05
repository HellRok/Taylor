class Test
  class Models
    class Mouse_Test < Test::Base
      def test_pressed?
        Mouse.pressed?(Mouse::LEFT)

        assert_called [
          "(IsMouseButtonPressed) { button: 0 }"
        ]
      end

      def test_down?
        Mouse.down?(Mouse::LEFT)

        assert_called [
          "(IsMouseButtonDown) { button: 0 }"
        ]
      end

      def test_released?
        Mouse.released?(Mouse::LEFT)

        assert_called [
          "(IsMouseButtonReleased) { button: 0 }"
        ]
      end

      def test_up?
        Mouse.up?(Mouse::LEFT)

        assert_called [
          "(IsMouseButtonUp) { button: 0 }"
        ]
      end

      def test_position
        Taylor::Raylib.mock_call("GetMousePosition", Vector2.mock_return(x: 1, y: 2))
        assert_equal Vector2[1, 2], Mouse.position

        assert_called [
          "(GetMousePosition) { }"
        ]
      end

      def test_position=
        Mouse.position = Vector2[4, 8]

        assert_called [
          "(SetMousePosition) { x: 4 y: 8 }"
        ]
      end

      def test_offset=
        Mouse.offset = Vector2[2, 3]

        assert_called [
          "(SetMouseOffset) { offsetX: 2 offsetY: 3 }"
        ]
      end

      def test_scale=
        Mouse.scale = Vector2[0.5, 2.0]

        assert_called [
          "(SetMouseScale) { scaleX: 0.500000 scaleY: 2.000000 }"
        ]
      end

      def test_wheel_moved
        Taylor::Raylib.mock_call("GetMouseWheelMoveV", Vector2.mock_return(x: 3, y: 4))

        assert_equal Vector2[3, 4], Mouse.wheel_moved

        assert_called [
          "(GetMouseWheelMoveV) { }"
        ]
      end
    end
  end
end
