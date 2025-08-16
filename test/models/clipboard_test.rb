class Test
  class Models
    class Clipboard_Test < Test::Base
      def test_text=
        Clipboard.text = "Hello!"
        Clipboard.text = "Good bye :("

        assert_called [
          "(SetClipboardText) { text: 'Hello!' }",
          "(SetClipboardText) { text: 'Good bye :(' }"
        ]
      end

      def test_text
        Clipboard.text

        assert_called [
          "(*GetClipboardText) { }"
        ]
      end
    end
  end
end
