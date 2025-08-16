class Test
  class Models
    class Browser_Test < Test::Base
      def test_open
        Browser.open("https://taylormadetech.dev")
        Browser.open("https://sean.taylormadetech.dev")

        assert_called [
          "(OpenURL) { url: 'https://taylormadetech.dev' }",
          "(OpenURL) { url: 'https://sean.taylormadetech.dev' }"
        ]
      end
    end
  end
end
