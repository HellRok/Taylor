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
        begin
          Audio.volume = -1
          fail "Previous line should have raised"
        rescue ArgumentError => e
          assert_equal "Must be within (0..100)", e.message
        end

        assert_called ["(IsAudioDeviceReady) { }"]
      end

      def test_volume_equals_errors_too_high
        begin
          Audio.volume = 101
          fail "Previous line should have raised"
        rescue ArgumentError => e
          assert_equal "Must be within (0..100)", e.message
        end

        assert_called ["(IsAudioDeviceReady) { }"]
      end

      def test_volume_before_open
        skip "Waiting on Raylib 5.0"
        skip_unless_audio_enabled

        Taylor::Raylib.mock_call("IsAudioDeviceReady", "false")

        Audio.volume

        assert_called ["(IsAudioDeviceReady) { }"]

        fail "Audio.volume should have raised"
      rescue Audio::NotOpenError => e
        assert_equal "You must use Audio.open before calling Audio.volume.", e.message
      end

      def test_set_volume_before_open
        Taylor::Raylib.mock_call("IsAudioDeviceReady", "false")

        Audio.volume = 50

        assert_called ["(IsAudioDeviceReady) { }"]

        fail "Audio.volume= should have raised"
      rescue Audio::NotOpenError => e
        assert_equal "You must use Audio.open before calling Audio.volume=.", e.message
      end
    end
  end
end
