class Test
  class Taylor_Test < Test::Base
    def test_released?
      if ENV["BUILDKITE_BUILD_ID"]
        assert_true Taylor.released?
      else
        assert_include [true, false], Taylor.released?
      end
    end
  end
end
