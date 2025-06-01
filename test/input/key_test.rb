class Test
  class Models
    class Key_Test < Test::Base
      def test_pressed?
        Key.pressed?(Key::A)

        assert_called [
          "(IsKeyPressed) { key: 65 }"
        ]
      end

      def test_down?
        Key.down?(Key::B)

        assert_called [
          "(IsKeyDown) { key: 66 }"
        ]
      end

      def test_released?
        Key.released?(Key::C)

        assert_called [
          "(IsKeyReleased) { key: 67 }"
        ]
      end

      def test_up?
        Key.up?(Key::D)

        assert_called [
          "(IsKeyUp) { key: 68 }"
        ]
      end

      def test_pressed
        Taylor::Raylib.mock_call("GetKeyPressed", "0")

        assert_equal nil, Key.pressed, "No frame has happened and no key has been pressed"

        assert_called [
          "(GetKeyPressed) { }"
        ]

        Taylor::Raylib.reset_calls
        Taylor::Raylib.mock_call("GetKeyPressed", "65")
        Taylor::Raylib.mock_call("GetKeyPressed", "66")

        assert_equal Key.pressed, Key::A, "A was the first pressed key"
        assert_equal Key.pressed, Key::B, "B was the second pressed key"

        assert_called [
          "(GetKeyPressed) { }",
          "(GetKeyPressed) { }"
        ]
      end

      def test_pressed_character
        Taylor::Raylib.mock_call("GetCharPressed", "0")

        assert_equal nil, Key.pressed_character, "No frame has happened and no key has been pressed"

        assert_called [
          "(GetCharPressed) { }"
        ]

        Taylor::Raylib.reset_calls
        Taylor::Raylib.mock_call("GetCharPressed", "97")
        Taylor::Raylib.mock_call("GetCharPressed", "66")

        assert_equal "a", Key.pressed_character, "a was the first pressed key"
        assert_equal "B", Key.pressed_character, "B was the second pressed key"

        assert_called [
          "(GetCharPressed) { }",
          "(GetCharPressed) { }"
        ]
      end
    end
  end
end
