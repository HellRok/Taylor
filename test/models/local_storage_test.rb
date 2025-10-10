if Taylor::Platform.browser?
  @unit.describe "LocalStorage" do
    Given "we have nothing set" do
    end

    Then "return an empty string" do
      expect(LocalStorage.get_item("test")).to_equal("")
    end

    When "we set the item" do
      LocalStorage.set_item("test", "value")
    end

    Then "return the value" do
      expect(LocalStorage.get_item("test")).to_equal("value")
    end
  end

else
  @unit.describe "LocalStorage.get" do
    When "called from an unsupported platform" do
    end

    Then "raise an error" do
      expect {
        LocalStorage.get_item("test")
      }.to_raise(Taylor::Platform::MethodCalledOnInvalidPlatformError)
    end
  end

  @unit.describe "LocalStorage.set" do
    When "called from an unsupported platform" do
    end

    Then "raise an error" do
      expect {
        LocalStorage.set_item("test", "value")
      }.to_raise(Taylor::Platform::MethodCalledOnInvalidPlatformError)
    end
  end
end
