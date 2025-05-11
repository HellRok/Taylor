class Test
  class Web_Test < Test::Base
    if browser?
      # According to
      # https://emscripten.org/docs/api_reference/emscripten.h.html#c.emscripten_cancel_main_loop
      # we actually can't leave the main_loop we set here, so I guess we just
      # leave this as a non-test?
      def test_set_main_loop
        # set_main_loop 'set_main_loop_stub'
        # assert_true $set_main_loop_run
        assert_true methods.include?(:set_main_loop)
      ensure
        $set_main_loop_run = false
      end

      def test_LocalStorage
        assert_equal LocalStorage.get_item("test"), ""
        LocalStorage.set_item("test", "value")
        assert_equal LocalStorage.get_item("test"), "value"
      end

    else
      def test_set_main_loop
        assert_raise(PlatformSpecificMethodCalledOnWrongPlatformError) {
          set_main_loop "set_main_loop_stub"
        }
      end

      def test_LocalStorage_get_item
        assert_raise(PlatformSpecificMethodCalledOnWrongPlatformError) {
          LocalStorage.get_item("test")
        }
      end

      def test_LocalStorage_set_item
        assert_raise(PlatformSpecificMethodCalledOnWrongPlatformError) {
          LocalStorage.set_item("test", "value")
        }
      end
    end
  end
end
