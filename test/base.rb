class Test
  class Base < MTest::Unit::TestCaseWithAnalytics
    def teardown
      assert_true Taylor::Raylib.all_mocks_used?, "No mocks were left behind"
    ensure
      Window.close # We need this to reset the cvars
      Taylor::Raylib.reset_calls
      Taylor::Raylib.clear_mocks
      add_analytics
    end
  end
end
