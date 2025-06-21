class Test
  class Input
    class Gamepad_Test < Test::Base
      def test_initialize
        gamepad = Gamepad.new(index: 1)

        assert_kind_of Gamepad, gamepad
        assert_equal 1, gamepad.index

        assert_no_calls
      end

      def test_brackets
        Taylor::Raylib.mock_call("IsGamepadAvailable", "true")
        Taylor::Raylib.mock_call("IsGamepadAvailable", "false")

        gamepad = Gamepad[0]

        assert_kind_of Gamepad, gamepad
        assert_equal 0, gamepad.index

        assert_called [
          "(IsGamepadAvailable) { gamepad: 0 }",
          "(IsGamepadAvailable) { gamepad: 1 }"
        ]
      end

      def test_brackets_too_low
        Taylor::Raylib.mock_call("IsGamepadAvailable", "true")
        Taylor::Raylib.mock_call("IsGamepadAvailable", "true")
        Taylor::Raylib.mock_call("IsGamepadAvailable", "false")

        assert_raise_with_message(ArgumentError, "Must be an integer in (0..1)") {
          Gamepad[-1]
        }

        assert_called [
          "(IsGamepadAvailable) { gamepad: 0 }",
          "(IsGamepadAvailable) { gamepad: 1 }",
          "(IsGamepadAvailable) { gamepad: 2 }"
        ]
      end

      def test_brackets_too_high
        Taylor::Raylib.mock_call("IsGamepadAvailable", "true")
        Taylor::Raylib.mock_call("IsGamepadAvailable", "true")
        Taylor::Raylib.mock_call("IsGamepadAvailable", "true")
        Taylor::Raylib.mock_call("IsGamepadAvailable", "false")

        assert_raise_with_message(ArgumentError, "Must be an integer in (0..2)") {
          Gamepad[3]
        }

        assert_called [
          "(IsGamepadAvailable) { gamepad: 0 }",
          "(IsGamepadAvailable) { gamepad: 1 }",
          "(IsGamepadAvailable) { gamepad: 2 }",
          "(IsGamepadAvailable) { gamepad: 3 }"
        ]
      end

      def test_all
        Taylor::Raylib.mock_call("IsGamepadAvailable", "true")
        Taylor::Raylib.mock_call("IsGamepadAvailable", "true")
        Taylor::Raylib.mock_call("IsGamepadAvailable", "false")

        gamepads = Gamepad.all

        assert_equal 2, gamepads.size
        assert_kind_of Gamepad, gamepads[0]
        assert_equal 0, gamepads[0].index
        assert_kind_of Gamepad, gamepads[1]
        assert_equal 1, gamepads[1].index

        assert_called [
          "(IsGamepadAvailable) { gamepad: 0 }",
          "(IsGamepadAvailable) { gamepad: 1 }",
          "(IsGamepadAvailable) { gamepad: 2 }"
        ]
      end

      def test_all_too_many
        11.times { Taylor::Raylib.mock_call("IsGamepadAvailable", "true") }

        assert_raise_with_message(
          Gamepad::TooManyGamepadsError,
          "We received more than the expected limit of gamepads, if you mean to have more than 10 set Gamepad::MAX_GAMEPADS higher"
        ) { Gamepad.all }

        assert_called [
          "(IsGamepadAvailable) { gamepad: 0 }",
          "(IsGamepadAvailable) { gamepad: 1 }",
          "(IsGamepadAvailable) { gamepad: 2 }",
          "(IsGamepadAvailable) { gamepad: 3 }",
          "(IsGamepadAvailable) { gamepad: 4 }",
          "(IsGamepadAvailable) { gamepad: 5 }",
          "(IsGamepadAvailable) { gamepad: 6 }",
          "(IsGamepadAvailable) { gamepad: 7 }",
          "(IsGamepadAvailable) { gamepad: 8 }",
          "(IsGamepadAvailable) { gamepad: 9 }",
          "(IsGamepadAvailable) { gamepad: 10 }"
        ]
      end

      def test_available?
        Taylor::Raylib.mock_call("IsGamepadAvailable", "true")
        Taylor::Raylib.mock_call("IsGamepadAvailable", "false")

        assert_true Gamepad.new(index: 0).available?
        assert_false Gamepad.new(index: 1).available?

        assert_called [
          "(IsGamepadAvailable) { gamepad: 0 }",
          "(IsGamepadAvailable) { gamepad: 1 }"
        ]
      end

      def test_name
        Taylor::Raylib.mock_call("*GetGamepadName", "the gamepad name")

        assert_equal "the gamepad name", Gamepad.new(index: 0).name

        assert_called [
          "(*GetGamepadName) { gamepad: 0 }"
        ]
      end
    end
  end
end
