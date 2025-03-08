class Test
  class Models
    class Window_Test < MTest::Unit::TestCaseWithAnalytics
      def test_open
        assert_equal 10, Window.width
        assert_equal 10, Window.height
        assert_equal "Taylor Test Suite", Window.title

        close_window

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
    end
  end
end
