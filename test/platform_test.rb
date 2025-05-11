class Test
  class Platform_Test < MTest::Unit::TestCaseWithAnalytics
    def test_released?
      if ENV["BUILDKITE_BUILD_ID"]
        assert_true released?
      else
        assert_include [true, false], released?
      end
    end

    def test_platform_checks
      # This test is pretty meh, but it at least checks they exist and
      # return within a set of values.

      assert_include [true, false], android?
      assert_include [true, false], browser?
      assert_include [true, false], linux?
      assert_include [true, false], osx?
      assert_include [true, false], windows?
    end
  end
end
