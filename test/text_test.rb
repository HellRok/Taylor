class Test
  class Text_Test < MTest::Unit::TestCaseWithAnalytics
    def test_measure_text_ex
      skip_unless_display_present

      set_window_title(__method__.to_s)
      font = Font.new("./assets/tiny.ttf")
      size = measure_text_ex(font, "hello", 12, 0)
      flush_frame

      assert_equal 31.125, size.x
      assert_equal 12, size.y
      font.unload
    end
  end
end
