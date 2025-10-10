@unit.describe "Audio.open" do
  When "we call open" do
    Audio.open
  end

  Then "Raylib was called with the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(InitAudioDevice) { }"
      ]
    )
  end
end

@unit.describe "Audio.ready?" do
  When "we call ready?" do
    Audio.ready?
  end

  Then "Raylib was called with the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(IsAudioDeviceReady) { }"
      ]
    )
  end
end

@unit.describe "Audio.volume" do
  Given "the volume has been set" do
    Taylor::Raylib.mock_call("GetMasterVolume", "70")
  end

  Then "we get the volume" do
    expect(Audio.volume).to_equal(70)
  end

  And "Raylib was called with the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(IsAudioDeviceReady) { }",
        "(GetMasterVolume) { }"
      ]
    )
  end

  But "raises an error when called with a negative value" do
    expect {
      Audio.volume = -1
    }.to_raise(ArgumentError, "Must be within (0..100)")
  end

  And "raises an error when called with a value over 100" do
    expect {
      Audio.volume = 101
    }.to_raise(ArgumentError, "Must be within (0..100)")
  end

  Given "Audio isn't ready" do
    Taylor::Raylib.mock_call("IsAudioDeviceReady", "false")
  end

  Then "raise an error" do
    expect {
      Audio.volume
    }.to_raise(Audio::NotOpenError, "You must use Audio.open before calling Audio.volume")
  end
end

@unit.describe "Audio.volume=" do
  When "we set the volume" do
    Audio.volume = 70
  end

  Then "Raylib was called with the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(IsAudioDeviceReady) { }",
        "(SetMasterVolume) { volume: 0.700000 }"
      ]
    )
  end

  But "raises an error when called with a negative value" do
    expect {
      Audio.volume = -1
    }.to_raise(ArgumentError, "Must be within (0..100)")
  end

  And "raises an error when called with a value over 100" do
    expect {
      Audio.volume = 101
    }.to_raise(ArgumentError, "Must be within (0..100)")
  end

  Given "Audio isn't ready" do
    Taylor::Raylib.mock_call("IsAudioDeviceReady", "false")
  end

  Then "raise an error" do
    expect {
      Audio.volume = 50
    }.to_raise(Audio::NotOpenError, "You must use Audio.open before calling Audio.volume=")
  end
end
