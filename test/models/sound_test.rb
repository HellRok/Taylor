@unit.describe "Sound#initialize" do
  When "we initialise a sound" do
    Taylor::Raylib.mock_call("LoadSound", Sound.mock_return(frame_count: 2))
    @sound = Sound.new("./assets/test.wav")
  end

  Then "we have the correct attributes" do
    expect(@sound.volume).to_equal(1)
    expect(@sound.pitch).to_equal(1)
    expect(@sound.frame_count).to_equal(2)
  end

  And "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(FileExists) { fileName: './assets/test.wav' }",
        "(LoadSound) { fileName: './assets/test.wav' }",
        "(SetSoundVolume) { sound: { frameCount: 2 } volume: 1.000000 }",
        "(SetSoundPitch) { sound: { frameCount: 2 } pitch: 1.000000 }"
      ]
    )
  end

  When "we initialise a sound with all the arguments" do
    Taylor::Raylib.mock_call("LoadSound", Sound.mock_return(frame_count: 3))
    @sound = Sound.new("./assets/test.wav", volume: 0.5, pitch: 1.3)
  end

  Then "we have the correct attributes" do
    expect(@sound.volume).to_equal(0.5)
    expect(@sound.pitch).to_equal(1.3)
    expect(@sound.frame_count).to_equal(3)
  end

  And "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(FileExists) { fileName: './assets/test.wav' }",
        "(LoadSound) { fileName: './assets/test.wav' }",
        "(SetSoundVolume) { sound: { frameCount: 3 } volume: 0.500000 }",
        "(SetSoundPitch) { sound: { frameCount: 3 } pitch: 1.300000 }"
      ]
    )
  end

  But "if we set the volume above 1.0, raise an error" do
    expect {
      Sound.new("./assets/test.wav", volume: 1.1)
    }.to_raise(ArgumentError, "Volume must be within (0.0..1.0)")
  end

  Or "if we set the volume below 0.0" do
    expect {
      Sound.new("./assets/test.wav", volume: -0.1)
    }.to_raise(ArgumentError, "Volume must be within (0.0..1.0)")
  end

  Or "if we try to load a file that doesn't exist" do
    Taylor::Raylib.mock_call("FileExists", "false")

    expect {
      Sound.new("./assets/fail.wav")
    }.to_raise(Sound::NotFoundError, "Unable to find './assets/fail.wav'")
  end
end

@unit.describe "Sound#to_h" do
  Given "we have a sound" do
    Taylor::Raylib.mock_call("LoadSound", Sound.mock_return(frame_count: 4))
    @sound = Sound.new("./assets/test.wav", volume: 0.25, pitch: 1.25)
  end

  Then "return a hash with all the attributes" do
    expect(@sound.to_h).to_equal(
      {
        frame_count: 4,
        volume: 0.25,
        pitch: 1.25
      }
    )
  end
end

@unit.describe "Sound#play" do
  Given "we have a sound" do
    Taylor::Raylib.mock_call("LoadSound", Sound.mock_return(frame_count: 5))
    @sound = Sound.new("./assets/test.wav")
    Taylor::Raylib.reset_calls
  end

  When "we call play" do
    @sound.play
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(PlaySound) { sound: { frameCount: 5 } }"
      ]
    )
  end
end

@unit.describe "Sound#stop" do
  Given "we have a sound" do
    Taylor::Raylib.mock_call("LoadSound", Sound.mock_return(frame_count: 6))
    @sound = Sound.new("./assets/test.wav")
    Taylor::Raylib.reset_calls
  end

  When "we call stop" do
    @sound.stop
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(StopSound) { sound: { frameCount: 6 } }"
      ]
    )
  end
end

@unit.describe "Sound#pause" do
  Given "we have a sound" do
    Taylor::Raylib.mock_call("LoadSound", Sound.mock_return(frame_count: 7))
    @sound = Sound.new("./assets/test.wav")
    Taylor::Raylib.reset_calls
  end

  When "we call pause" do
    @sound.pause
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(PauseSound) { sound: { frameCount: 7 } }"
      ]
    )
  end
end

@unit.describe "Sound#resume" do
  Given "we have a sound" do
    Taylor::Raylib.mock_call("LoadSound", Sound.mock_return(frame_count: 8))
    @sound = Sound.new("./assets/test.wav")
    Taylor::Raylib.reset_calls
  end

  When "we call resume" do
    @sound.resume
  end

  Then "Raylib receives the expected calls" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(ResumeSound) { sound: { frameCount: 8 } }"
      ]
    )
  end
end

@unit.describe "Sound#playing?" do
  Given "we have a sound" do
    Taylor::Raylib.mock_call("IsSoundPlaying", "false")
    @sound = Sound.new("./assets/test.wav")
  end

  Then "it starts off not playing" do
    expect(@sound.playing?).to_be_false
  end

  When "we play the sound" do
    Taylor::Raylib.mock_call("IsSoundPlaying", "true")
  end

  Then "it is playing" do
    expect(@sound.playing?).to_be_true
  end
end

@unit.describe "Sound#volume=" do
  Given "we have a sound" do
    @sound = Sound.new("./assets/test.wav")
  end

  Then "the volume starts at 1.0" do
    expect(@sound.volume).to_equal(1.0)
  end

  When "set the volume" do
    expect {
      @sound.volume = 0.3
    }.to_equal(0.3)
  end

  Then "the volume is updated" do
    expect(@sound.volume).to_equal(0.3)
  end

  But "if we set the volume above 1.0, raise an error" do
    expect {
      @sound.volume = 1.1
    }.to_raise(ArgumentError, "Volume must be within (0.0..1.0)")
  end

  Or "if we set the volume belove 0.0" do
    expect {
      @sound.volume = -0.1
    }.to_raise(ArgumentError, "Volume must be within (0.0..1.0)")
  end
end

@unit.describe "Sound#pitch=" do
  Given "we have a sound" do
    @sound = Sound.new("./assets/test.wav")
  end

  Then "the pitch starts at 1.0" do
    expect(@sound.pitch).to_equal(1.0)
  end

  When "set the pitch" do
    expect {
      @sound.pitch = 0.3
    }.to_equal(0.3)
  end

  Then "the pitch is updated" do
    expect(@sound.pitch).to_equal(0.3)
  end
end

@unit.describe "Sound#valid?" do
  Given "we have a valid sound" do
    Taylor::Raylib.mock_call("IsSoundValid", "true")
    @sound = Sound.new("./assets/test.wav")
  end

  Then "return true" do
    expect(@sound.valid?).to_be_true
  end

  But "if we have an invalid sound" do
    Taylor::Raylib.mock_call("IsSoundValid", "false")
  end

  Then "return false" do
    expect(@sound.valid?).to_be_false
  end
end
