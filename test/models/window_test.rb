class Test
  class Models
    class Window_Test < MTest::Unit::TestCaseWithAnalytics
      def test_open
        assert_equal 10, Window.width
        assert_equal 10, Window.height
        assert_equal "Taylor Test Suite", Window.title

        Window.close

        Window.open(
          width: 12,
          height: 15,
          title: "Some other title"
        )

        assert_equal 12, Window.width
        assert_equal 15, Window.height
        assert_equal "Some other title", Window.title
      ensure
        reset_window
      end

      def test_close?
        skip "xdotool not available" unless XDo.available?

        assert_equal false, Window.close?

        XDo::Key.press "Escape"
        flush_frame

        assert_equal true, Window.close?
      end

      def test_ready?
        assert_true Window.ready?

        Window.close
        assert_false Window.ready?

        Window.open(width: 10, height: 10, title: "Taylor Test Suite")
        assert_true Window.ready?
      end
    end
  end
end
