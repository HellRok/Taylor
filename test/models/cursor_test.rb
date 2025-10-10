@unit.describe "Cursor.show" do
  Given "we have called show" do
    Cursor.show
  end

  Then "Raylib receives the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(ShowCursor) { }"
      ]
    )
  end
end

@unit.describe "Cursor.hide" do
  Given "we have called hide" do
    Cursor.hide
  end

  Then "Raylib receives the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(HideCursor) { }"
      ]
    )
  end
end

@unit.describe "Cursor.hidden?" do
  Given "the cursor is hidden" do
    Taylor::Raylib.mock_call("IsCursorHidden", "true")
  end

  Then "return true" do
    expect(Cursor.hidden?).to_be_true
  end

  Given "the cursor is not hidden" do
    Taylor::Raylib.mock_call("IsCursorHidden", "false")
  end

  Then "return false" do
    expect(Cursor.hidden?).to_be_false
  end
end

@unit.describe "Cursor.enable" do
  Given "we have called enable" do
    Cursor.enable
  end

  Then "Raylib receives the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(EnableCursor) { }"
      ]
    )
  end
end

@unit.describe "Cursor.disable" do
  Given "we have called disable" do
    Cursor.disable
  end

  Then "Raylib receives the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(DisableCursor) { }"
      ]
    )
  end
end

@unit.describe "Cursor.disabled?" do
  Given "the cursor is disabled" do
    Cursor.disable
  end

  Then "return true" do
    expect(Cursor.disabled?).to_be_true
  end

  Given "the cursor is not disabled" do
    Cursor.enable
  end

  Then "return false" do
    expect(Cursor.disabled?).to_be_false
  end
end

@unit.describe "Cursor.on_screen?" do
  Given "the cursor is on_screen" do
    Taylor::Raylib.mock_call("IsCursorOnScreen", "true")
  end

  Then "return true" do
    expect(Cursor.on_screen?).to_be_true
  end

  Given "the cursor is not on_screen" do
    Taylor::Raylib.mock_call("IsCursorOnScreen", "false")
  end

  Then "return false" do
    expect(Cursor.on_screen?).to_be_false
  end
end

@unit.describe "Cursor.icon" do
  Given "the cursor has not been set" do
  end

  Then "return the default cursor" do
    expect(Cursor.icon).to_equal(Cursor::DEFAULT)
  end

  Given "the cursor has been set" do
    Cursor.icon = Cursor::CROSSHAIR
  end

  Then "return the set cursor" do
    expect(Cursor.icon).to_equal(Cursor::CROSSHAIR)
  end
end

@unit.describe "Cursor.icon=" do
  When "we set the cursor" do
    Cursor.icon = Cursor::IBEAM
  end

  Then "the cursor is set" do
    expect(Cursor.icon).to_equal(Cursor::IBEAM)
  end

  And "Raylib receives the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(SetMouseCursor) { cursor: 2 }"
      ]
    )
  end

  But "if called with a negative number it raises" do
    expect {
      Cursor.icon = -1
    }.to_raise(ArgumentError, "Must be within (0..10)")
  end

  Or "if called with a larger number it raises" do
    expect {
      Cursor.icon = 11
    }.to_raise(ArgumentError, "Must be within (0..10)")
  end
end
