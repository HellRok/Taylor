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
    end
  end
end
