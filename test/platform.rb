class Test
  class Platform_Test < MTest::Unit::TestCaseWithAnalytics
    if ENV["BUILDKITE_BUILD_ID"]
      def test_released?
        assert_true released?
      end
    end
  end
end
