class Test
  class Taylor_Test < MTest::Unit::TestCaseWithAnalytics
    def test_released?
      if ENV["BUILDKITE_BUILD_ID"]
        assert_true Taylor.released?
      else
        assert_include [true, false], Taylor.released?
      end
    end
  end
end
