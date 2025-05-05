class Test
  class Base < MTest::Unit::TestCaseWithAnalytics
    def teardown
      Taylor::Raylib.reset_calls
    end
  end
end
