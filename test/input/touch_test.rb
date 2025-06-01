class Test
  class Models
    class Touch_Test < Test::Base
      def test_brackets
        Taylor::Raylib.mock_call("GetTouchPosition", Vector2.mock_return(x: 5, y: 6))

        position = Touch[4]

        assert_equal Vector2[5, 6], position

        assert_called [
          "(GetTouchPosition) { index: 4 }"
        ]
      end

      def test_position_for
        Taylor::Raylib.mock_call("GetTouchPosition", Vector2.mock_return(x: 5, y: 6))

        position = Touch.position_for(6)

        assert_equal Vector2[5, 6], position

        assert_called [
          "(GetTouchPosition) { index: 6 }"
        ]
      end

      def test_positions
        Taylor::Raylib.mock_call("GetTouchPosition", Vector2.mock_return(x: 1, y: 2))
        Taylor::Raylib.mock_call("GetTouchPosition", Vector2.mock_return(x: 2, y: 3))
        Taylor::Raylib.mock_call("GetTouchPosition", Vector2.mock_return(x: 3, y: 4))
        Taylor::Raylib.mock_call("GetTouchPosition", Vector2.mock_return(x: 0, y: 0))

        positions = Touch.positions

        assert_equal 3, positions.size
        assert_equal Vector2[1, 2], positions[0]
        assert_equal Vector2[2, 3], positions[1]
        assert_equal Vector2[3, 4], positions[2]

        assert_called [
          "(GetTouchPosition) { index: 0 }",
          "(GetTouchPosition) { index: 1 }",
          "(GetTouchPosition) { index: 2 }",
          "(GetTouchPosition) { index: 3 }"
        ]
      end

      def test_positions_too_many
        21.times { Taylor::Raylib.mock_call("GetTouchPosition", Vector2.mock_return(x: 1, y: 2)) }

        assert_raise_with_message(
          Touch::TooManyTouchesError,
          "We received more than the expected limit of touches, is your input device having an issue?"
        ) { Touch.positions }

        assert_called [
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
      end
    end
  end
end
