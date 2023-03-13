class Test
  class Platform_Test < MTest::Unit::TestCaseWithAnalytics
    def test_released?
      assert_true released?
    end
  end
end
