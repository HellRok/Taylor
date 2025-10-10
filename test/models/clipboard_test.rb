@unit.describe "Clipboard.text" do
  When "we call it" do
    Clipboard.text
  end

  Then "Raylib receives the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(*GetClipboardText) { }"
      ]
    )
  end
end

@unit.describe "Clipboard.text=" do
  When "we call it" do
    Clipboard.text = "Hello!"
    Clipboard.text = "Good bye :("
  end

  Then "Raylib receives the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(SetClipboardText) { text: 'Hello!' }",
        "(SetClipboardText) { text: 'Good bye :(' }"
      ]
    )
  end
end
