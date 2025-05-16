class Test
  class Models
    class Audio_Test < Test::Base
      def test_open
        Audio.open

        assert_called ["(InitAudioDevice) { }"]
      end

      def test_ready?
        Audio.ready?

        assert_called ["(IsAudioDeviceReady) { }"]
      end

      def test_volume
        skip "Waiting on Raylib 5.0"

        Audio.volume

        assert_called ["(GetMasterVolume) { }"]
      end

      def test_volume_equals_errors_too_low
        assert_raise_with_message(ArgumentError, "Must be within (0..100)") {
          Audio.volume = -1
        }

        assert_called ["(IsAudioDeviceReady) { }"]
      end

      def test_volume_equals_errors_too_high
        assert_raise_with_message(ArgumentError, "Must be within (0..100)") {
          Audio.volume = 101
        }

        assert_called ["(IsAudioDeviceReady) { }"]
      end

      def test_volume_before_open
        skip "Waiting on Raylib 5.0"
        skip_unless_audio_enabled

        Taylor::Raylib.mock_call("IsAudioDeviceReady", "false")

        assert_raise_with_message(Audio::NotOpenError, "You must use Audio.open before calling Audio.volume.") {
          Audio.volume
        }

        assert_called ["(IsAudioDeviceReady) { }"]
      end

      def test_set_volume_before_open
        Taylor::Raylib.mock_call("IsAudioDeviceReady", "false")

        assert_raise_with_message(Audio::NotOpenError, "You must use Audio.open before calling Audio.volume=.") {
          Audio.volume = 50
        }

        assert_called ["(IsAudioDeviceReady) { }"]
      end
    end
  end
end
