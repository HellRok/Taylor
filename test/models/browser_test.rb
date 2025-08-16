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

      if Taylor::Platform.browser?
        # According to
        # https://emscripten.org/docs/api_reference/emscripten.h.html#c.emscripten_cancel_main_loop
        # we actually can't leave the main_loop we set here, so I guess we just
        # leave this as a non-test?
        def test_main_loop=
          assert_true Browser.methods.include?(:main_loop=)
        end

        def test_attribute_from_element
          assert_equal "data-thing", Browser.attribute_from_element("#test-attribute-from-element", "data-thing")
          assert_equal "class", Browser.attribute_from_element("#test-attribute-from-element", "classList")
          assert_equal "", Browser.attribute_from_element("#test-attribute-from-element", "non-existant")
        end

      else
        def test_set_main_loop
          assert_raise(Taylor::Platform::MethodCalledOnInvalidPlatformError) {
            Browser.main_loop = "method_name"
          }
        end

        def test_attribute_from_element
          assert_raise(Taylor::Platform::MethodCalledOnInvalidPlatformError) {
            Browser.attribute_from_element("#test-attribute-from-element", "data-thing")
          }
        end
      end
    end
  end
end
