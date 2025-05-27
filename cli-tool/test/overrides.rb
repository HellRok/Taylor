class Test
  class Overrides_Test < MTest::Unit::TestCaseWithAnalytics
    def test_released?
      assert_false Taylor.released?
    end
  end
end
