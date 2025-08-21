class Test
  class Base < MTest::Unit::TestCaseWithAnalytics
    def teardown
      add_analytics
    end
  end
end
