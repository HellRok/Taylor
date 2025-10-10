@unit.describe "Music#initialize" do
  Given "we initialize a music object" do
    Taylor::Raylib.mock_call(
      "LoadMusicStream",
      Music.mock_return(sample_rate: 1, sample_size: 2, channels: 3, frame_count: 4, looping: true, ctx_type: 5)
    )

    @music = Music.new("./assets/test.ogg")
  end

  Then "it has the correct attributes" do
    expect(@music.volume).to_equal(1)
    expect(@music.pitch).to_equal(1)
    expect(@music.length).to_equal(1)
    expect(@music.frame_count).to_equal(4)
    expect(@music.context_type).to_equal(5)
    expect(@music.looping).to_equal(true)
  end

  Given "we initialize a music object with arguments" do
    Taylor::Raylib.mock_call(
      "LoadMusicStream",
      Music.mock_return(sample_rate: 2, sample_size: 3, channels: 4, frame_count: 5, looping: true, ctx_type: 6)
    )
    @music = Music.new("./assets/test.ogg", looping: false, volume: 0.75, pitch: 0.9)
  end

  Then "it has the correct attributes" do
    expect(@music.volume).to_equal(0.75)
    expect(@music.pitch).to_equal(0.9)
    expect(@music.length).to_equal(1)
    expect(@music.frame_count).to_equal(5)
    expect(@music.context_type).to_equal(6)
    expect(@music.looping).to_equal(false)
  end

  But "if we try to load a file that doesn't exist" do
    Taylor::Raylib.mock_call("FileExists", "false")
  end

  Then "raise an error" do
    expect {
      Music.new("./assets/fail.ogg")
    }.to_raise(
      Music::NotFoundError,
      "Unable to find './assets/fail.ogg'"
    )
  end

  But "if the volume is too high, raise an error" do
    expect {
      Music.new("./assets/test.ogg", volume: 1.1)
    }.to_raise(
      ArgumentError,
      "Volume must be within (0.0..1.0)"
    )
  end

  Or "if the volume is too low" do
    expect {
      Music.new("./assets/test.ogg", volume: -0.1)
    }.to_raise(
      ArgumentError,
      "Volume must be within (0.0..1.0)"
    )
  end
end

@unit.describe "Music#unload" do
  Given "we have a music object" do
    Taylor::Raylib.mock_call(
      "LoadMusicStream",
      Music.mock_return(sample_rate: 3, sample_size: 4, channels: 5, frame_count: 6, looping: true, ctx_type: 7)
    )
    @music = Music.new("./assets/test.ogg")
    Taylor::Raylib.reset_calls
  end

  When "we unload it" do
    @music.unload
  end

  Then "Raylib receives the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(UnloadMusicStream) { music: { frameCount: 6 looping: 1 ctxType: 7 } }"
      ]
    )
  end
end

@unit.describe "Music#looping=" do
  Given "we have a music object" do
    @music = Music.new("./assets/test.ogg", looping: true)
    Taylor::Raylib.reset_calls
  end

  When "we haven't set looping specifically" do
  end

  Then "it is true" do
    expect(@music.looping).to_be_true
  end

  When "we set looping to `false`" do
    @music.looping = false
  end

  Then "it is false" do
    expect(@music.looping).to_be_false
  end
end

@unit.describe "Music#to_h" do
  Given "we have a music object" do
    Taylor::Raylib.mock_call(
      "LoadMusicStream",
      Music.mock_return(sample_rate: 4, sample_size: 5, channels: 6, frame_count: 7, looping: true, ctx_type: 8)
    )
    @music = Music.new("./assets/test.ogg", looping: true)
    Taylor::Raylib.reset_calls
  end

  Then "it returns a hash with the correct attributes" do
    expect(@music.to_h).to_equal(
      {
        context_type: 8,
        looping: true,
        frame_count: 7,
        volume: 1.0,
        pitch: 1.0
      }
    )
  end
end

@unit.describe "Music#play" do
  Given "we have a music object" do
    Taylor::Raylib.mock_call(
      "LoadMusicStream",
      Music.mock_return(sample_rate: 5, sample_size: 6, channels: 7, frame_count: 8, looping: true, ctx_type: 9)
    )
    @music = Music.new("./assets/test.ogg")
    Taylor::Raylib.reset_calls
  end

  When "we call play" do
    @music.play
  end

  Then "Raylib receives the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(IsAudioDeviceReady) { }",
        "(PlayMusicStream) { music: { frameCount: 8 looping: 1 ctxType: 9 } }"
      ]
    )
  end

  But "if the audio is not open" do
    Taylor::Raylib.mock_call("IsAudioDeviceReady", "false")
  end

  Then "raise an error when we try to play" do
    expect {
      @music.play
    }.to_raise(
      Audio::NotOpenError,
      "You must use Audio.open before calling Music#play."
    )
  end
end

@unit.describe "Music#played" do
  Given "we have a music object" do
    Taylor::Raylib.mock_call("GetMusicTimePlayed", "0")
    @music = Music.new("./assets/test.ogg")
    Taylor::Raylib.reset_calls
  end

  Then "we call played and it returns zero" do
    expect(@music.played).to_equal(0)
  end

  Given "we have played some music" do
    Taylor::Raylib.mock_call("GetMusicTimePlayed", "30")
  end

  Then "we return how long it's been playing for" do
    expect(@music.played).to_equal(30)
  end
end

@unit.describe "Music#pause" do
  Given "we have a music object" do
    Taylor::Raylib.mock_call(
      "LoadMusicStream",
      Music.mock_return(sample_rate: 7, sample_size: 8, channels: 9, frame_count: 10, looping: true, ctx_type: 11)
    )

    @music = Music.new("./assets/test.ogg")
    Taylor::Raylib.reset_calls
  end

  When "we call pause" do
    @music.pause
  end

  Then "Raylib receives the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(PauseMusicStream) { music: { frameCount: 10 looping: 1 ctxType: 11 } }"
      ]
    )
  end
end

@unit.describe "Music#resume" do
  Given "we have a music object" do
    Taylor::Raylib.mock_call(
      "LoadMusicStream",
      Music.mock_return(sample_rate: 8, sample_size: 9, channels: 10, frame_count: 11, looping: true, ctx_type: 12)
    )

    @music = Music.new("./assets/test.ogg")
    Taylor::Raylib.reset_calls
  end

  When "we call resume" do
    @music.resume
  end

  Then "Raylib receives the expected methods" do
    expect(Taylor::Raylib.calls).to_equal(
      [
        "(ResumeMusicStream) { music: { frameCount: 11 looping: 1 ctxType: 12 } }"
      ]
    )
  end
end

@unit.describe "Music#length" do
  Given "we have a music object" do
    Taylor::Raylib.mock_call("GetMusicTimeLength", "123")
    @music = Music.new("./assets/test.ogg")
  end

  Then "return its length" do
    expect(@music.length).to_equal(123)
  end
end

@unit.describe "Music#volume=" do
  Given "we have a music object" do
    @music = Music.new("./assets/test.ogg")
  end

  Then "the volume defaults to 1.0" do
    expect(@music.volume).to_equal(1.0)
  end

  When "we set the volume" do
    expect { @music.volume = 0.5 }.to_equal(0.5)
  end

  Then "the volume is updated" do
    expect(@music.volume).to_equal(0.5)
  end

  But "if we set the volume above 1.0, raise an error" do
    expect {
      @music.volume = 1.1
    }.to_raise(
      ArgumentError,
      "Volume must be within (0.0..1.0)"
    )
  end

  Or "if we set the volume belove 0.0" do
    expect {
      @music.volume = -0.1
    }.to_raise(
      ArgumentError,
      "Volume must be within (0.0..1.0)"
    )
  end
end

@unit.describe "Music#pitch=" do
  Given "we have a music object" do
    @music = Music.new("./assets/test.ogg")
  end

  Then "the pitch defaults to 1.0" do
    expect(@music.pitch).to_equal(1.0)
  end

  When "we set the pitch" do
    expect { @music.pitch = 0.5 }.to_equal(0.5)
  end

  Then "the pitch is updated" do
    expect(@music.pitch).to_equal(0.5)
  end
end

@unit.describe "Music#valid?" do
  Given "we have a valid music object" do
    Taylor::Raylib.mock_call("IsMusicValid", "true")
    @music = Music.new("./assets/test.ogg")
  end

  Then "return true" do
    expect(@music.valid?).to_be_true
  end

  Given "we have an invalid music object" do
    Taylor::Raylib.mock_call("IsMusicValid", "false")
  end

  Then "return false" do
    expect(@music.valid?).to_be_false
  end
end
