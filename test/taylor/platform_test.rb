class Test
  class Taylor_Platform_Test < MTest::Unit::TestCaseWithAnalytics
    def test_to_s
      assert_include [
        "arm64-android",
        "wasm32-browser",
        "amd64-linux",
        "amd64-osx",
        "arm64-osx",
        "amd64-windows"
      ], Taylor::Platform.to_s
    end

    def test_os
      assert_include [
        :android, :browser, :linux, :osx, :windows
      ], Taylor::Platform.os
    end

    def test_arch
      assert_include [:amd64, :arm64, :wasm32], Taylor::Platform.arch
    end

    def test_platform_checks
      if Taylor::Platform == "arm64-android"
        assert_equal :android, Taylor::Platform.os
        assert_equal :arm64, Taylor::Platform.arch
        assert_true Taylor::Platform.android?
        assert_false Taylor::Platform.browser?
        assert_false Taylor::Platform.linux?
        assert_false Taylor::Platform.osx?
        assert_false Taylor::Platform.windows?

      elsif Taylor::Platform == "wasm32-browser"
        assert_equal :browser, Taylor::Platform.os
        assert_equal :wasm32, Taylor::Platform.arch
        assert_false Taylor::Platform.android?
        assert_true Taylor::Platform.browser?
        assert_false Taylor::Platform.linux?
        assert_false Taylor::Platform.osx?
        assert_false Taylor::Platform.windows?

      elsif Taylor::Platform == "amd64-linux"
        assert_equal :linux, Taylor::Platform.os
        assert_equal :amd64, Taylor::Platform.arch
        assert_false Taylor::Platform.android?
        assert_false Taylor::Platform.browser?
        assert_true Taylor::Platform.linux?
        assert_false Taylor::Platform.osx?
        assert_false Taylor::Platform.windows?

      elsif Taylor::Platform == "amd64-osx"
        assert_equal :osx, Taylor::Platform.os
        assert_equal :amd64, Taylor::Platform.arch
        assert_false Taylor::Platform.android?
        assert_false Taylor::Platform.browser?
        assert_false Taylor::Platform.linux?
        assert_true Taylor::Platform.osx?
        assert_false Taylor::Platform.windows?

      elsif Taylor::Platform == "arm64-osx"
        assert_equal :osx, Taylor::Platform.os
        assert_equal :arm64, Taylor::Platform.arch
        assert_false Taylor::Platform.android?
        assert_false Taylor::Platform.browser?
        assert_false Taylor::Platform.linux?
        assert_true Taylor::Platform.osx?
        assert_false Taylor::Platform.windows?

      elsif Taylor::Platform == "amd64-windows"
        assert_equal :windows, Taylor::Platform.os
        assert_equal :amd64, Taylor::Platform.arch
        assert_false Taylor::Platform.android?
        assert_false Taylor::Platform.browser?
        assert_false Taylor::Platform.linux?
        assert_false Taylor::Platform.osx?
        assert_true Taylor::Platform.windows?

      else
        flunk "No platform checks for '#{Taylor::Platform}'"
      end
    end
  end
end
