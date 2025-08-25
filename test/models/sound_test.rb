class Test
  class Models
    class Sound_Test < Test::Base
      def test_initialize
        Taylor::Raylib.mock_call("LoadSound", Sound.mock_return(frame_count: 2))
        sound = Sound.new("./assets/test.wav")

        assert_equal 1, sound.volume
        assert_equal 1, sound.pitch
        assert_equal 2, sound.frame_count

        assert_called [
          "(FileExists) { fileName: './assets/test.wav' }",
          "(LoadSound) { fileName: './assets/test.wav' }",
          "(SetSoundVolume) { sound: { frameCount: 2 } volume: 1.000000 }",
          "(SetSoundPitch) { sound: { frameCount: 2 } pitch: 1.000000 }"
        ]
      end

      def test_initialize_with_arguments
        Taylor::Raylib.mock_call("LoadSound", Sound.mock_return(frame_count: 3))
        Sound.new("./assets/test.wav", volume: 0.5, pitch: 1.3)

        assert_called [
          "(FileExists) { fileName: './assets/test.wav' }",
          "(LoadSound) { fileName: './assets/test.wav' }",
          "(SetSoundVolume) { sound: { frameCount: 3 } volume: 0.500000 }",
          "(SetSoundPitch) { sound: { frameCount: 3 } pitch: 1.300000 }"
        ]
      end

      def test_initialize_fail_not_found
        Taylor::Raylib.mock_call("FileExists", "false")

        assert_raise_with_message(Sound::NotFoundError, "Unable to find './assets/fail.wav'") {
          Sound.new("./assets/fail.wav")
        }

        assert_called [
          "(FileExists) { fileName: './assets/fail.wav' }"
        ]
      end

      def test_initialize_fail_volume_too_high
        assert_raise_with_message(ArgumentError, "Volume must be within (0.0..1.0)") {
          Sound.new("./assets/test.wav", volume: 1.1)
        }

        assert_called [
          "(FileExists) { fileName: './assets/test.wav' }"
        ]
      end

      def test_initialize_fail_volume_too_low
        assert_raise_with_message(ArgumentError, "Volume must be within (0.0..1.0)") {
          Sound.new("./assets/test.wav", volume: -0.1)
        }

        assert_called [
          "(FileExists) { fileName: './assets/test.wav' }"
        ]
      end

      def test_to_h
        Taylor::Raylib.mock_call("LoadSound", Sound.mock_return(frame_count: 4))
        sound = Sound.new("./assets/test.wav", volume: 0.25, pitch: 1.25)

        assert_equal(
          {
            frame_count: 4,
            volume: 0.25,
            pitch: 1.25
          },
          sound.to_h
        )

        assert_called [
          "(FileExists) { fileName: './assets/test.wav' }",
          "(LoadSound) { fileName: './assets/test.wav' }",
          "(SetSoundVolume) { sound: { frameCount: 4 } volume: 0.250000 }",
          "(SetSoundPitch) { sound: { frameCount: 4 } pitch: 1.250000 }"
        ]
      end

      def test_play
        Taylor::Raylib.mock_call("LoadSound", Sound.mock_return(frame_count: 5))
        sound = Sound.new("./assets/test.wav")
        Taylor::Raylib.reset_calls

        sound.play

        assert_called [
          "(PlaySound) { sound: { frameCount: 5 } }"
        ]
      end

      def test_stop
        Taylor::Raylib.mock_call("LoadSound", Sound.mock_return(frame_count: 6))
        sound = Sound.new("./assets/test.wav")
        Taylor::Raylib.reset_calls

        sound.stop

        assert_called [
          "(StopSound) { sound: { frameCount: 6 } }"
        ]
      end

      def test_pause
        Taylor::Raylib.mock_call("LoadSound", Sound.mock_return(frame_count: 7))
        sound = Sound.new("./assets/test.wav")
        Taylor::Raylib.reset_calls

        sound.pause

        assert_called [
          "(PauseSound) { sound: { frameCount: 7 } }"
        ]
      end

      def test_resume
        Taylor::Raylib.mock_call("LoadSound", Sound.mock_return(frame_count: 8))
        sound = Sound.new("./assets/test.wav")
        Taylor::Raylib.reset_calls

        sound.resume

        assert_called [
          "(ResumeSound) { sound: { frameCount: 8 } }"
        ]
      end

      def test_playing?
        Taylor::Raylib.mock_call("LoadSound", Sound.mock_return(frame_count: 9))
        Taylor::Raylib.mock_call("IsSoundPlaying", "false")
        Taylor::Raylib.mock_call("IsSoundPlaying", "true")

        sound = Sound.new("./assets/test.wav")
        Taylor::Raylib.reset_calls

        assert_false sound.playing?
        assert_true sound.playing?

        assert_called [
          "(IsSoundPlaying) { sound: { frameCount: 9 } }",
          "(IsSoundPlaying) { sound: { frameCount: 9 } }"
        ]
      end

      def test_volume=
        Taylor::Raylib.mock_call("LoadSound", Sound.mock_return(frame_count: 10))
        sound = Sound.new("./assets/test.wav")
        Taylor::Raylib.reset_calls

        assert_equal 1.0, sound.volume
        assert_equal 0.3, (sound.volume = 0.3)
        assert_equal 0.3, sound.volume

        assert_called [
          "(SetSoundVolume) { sound: { frameCount: 10 } volume: 0.300000 }"
        ]
      end

      def test_fail_volume=
        sound = Sound.new("./assets/test.wav")
        Taylor::Raylib.reset_calls

        assert_equal 1.0, sound.volume

        assert_raise_with_message(ArgumentError, "Volume must be within (0.0..1.0)") {
          sound.volume = 1.1
        }

        assert_equal 1.0, sound.volume
        assert_no_calls

        assert_raise_with_message(ArgumentError, "Volume must be within (0.0..1.0)") {
          sound.volume = -0.1
        }

        assert_equal 1.0, sound.volume
        assert_no_calls
      ensure
        sound&.unload
        Audio.close
      end

      def test_pitch=
        Taylor::Raylib.mock_call("LoadSound", Sound.mock_return(frame_count: 11))
        sound = Sound.new("./assets/test.wav")
        Taylor::Raylib.reset_calls

        assert_equal 1.0, sound.pitch
        assert_equal 0.2, sound.pitch = 0.2
        assert_equal 0.2, sound.pitch

        assert_called [
          "(SetSoundPitch) { sound: { frameCount: 11 } pitch: 0.200000 }"
        ]
      end

      def test_valid?
        Taylor::Raylib.mock_call("LoadSound", Sound.mock_return(frame_count: 12))
        Taylor::Raylib.mock_call("IsSoundValid", "false")
        Taylor::Raylib.mock_call("IsSoundValid", "true")
        sound = Sound.new("./assets/test.wav")
        Taylor::Raylib.reset_calls

        assert_false sound.valid?
        assert_true sound.valid?

        assert_called [
          "(IsSoundValid) { sound: { frameCount: 12 } }",
          "(IsSoundValid) { sound: { frameCount: 12 } }"
        ]
      end
    end
  end
end
