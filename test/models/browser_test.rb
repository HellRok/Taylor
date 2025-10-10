@unit.describe "Browser.open" do
  When "we call open" do
    Browser.open("https://taylormadetech.dev")
    Browser.open("https://sean.taylormadetech.dev")
  end

  Then "Raylib was called with the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(OpenURL) { url: 'https://taylormadetech.dev' }",
        "(OpenURL) { url: 'https://sean.taylormadetech.dev' }"
      ]
    )
  end
end

if Taylor::Platform.browser?
  # We actually can't leave the main_loop we set here, so I guess we just leave
  # this as a non-test?
  #
  # Source: https://emscripten.org/docs/api_reference/emscripten.h.html#c.emscripten_cancel_main_loop
  @browser.describe "Browser.main_loop=" do
    expect(Browser.methods.include?(:main_loop=)).to_be_true
  end

  @browser.describe "Browser.attribute_from_element" do
    When "calling for a data attribute" do
      expect(Browser.attribute_from_element("#test-attribute-from-element", "data-thing")).to_equal("data-thing")
    end

    When "calling on a normal attribute" do
      expect(Browser.attribute_from_element("#test-attribute-from-element", "classList")).to_equal("class")
    end

    When "calling on an element that doesn't exist" do
      expect(Browser.attribute_from_element("#test-attribute-from-element", "non-existant")).to_equal("")
    end
  end

else
  @unit.describe "Browser.main_loop=" do
    Given "We aren't in a browser" do
    end

    Then "raise an error" do
      expect {
        Browser.main_loop = "method_name"
      }.to_raise(Taylor::Platform::MethodCalledOnInvalidPlatformError)
    end
  end

  @unit.describe "Browser.attribute_from_element" do
    Given "We aren't in a browser" do
    end

    Then "raise an error" do
      expect {
        Browser.attribute_from_element("#test-attribute-from-element", "data-thing")
      }.to_raise(Taylor::Platform::MethodCalledOnInvalidPlatformError)
    end
  end
end
