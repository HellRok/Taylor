class Test
  class LocalStorage_Test < Test::Base
    if Taylor::Platform.browser?
      def test_LocalStorage
        assert_equal LocalStorage.get_item("test"), ""
        LocalStorage.set_item("test", "value")
        assert_equal LocalStorage.get_item("test"), "value"
      end

    else
      def test_LocalStorage_get_item
        assert_raise(Taylor::Platform::MethodCalledOnInvalidPlatformError) {
          LocalStorage.get_item("test")
        }
      end

      def test_LocalStorage_set_item
        assert_raise(Taylor::Platform::MethodCalledOnInvalidPlatformError) {
          LocalStorage.set_item("test", "value")
        }
      end
    end
  end
end
