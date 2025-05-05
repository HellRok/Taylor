class Test
  class Models
    class Music_Test < Test::Base
      def test_initialize
        Taylor::Raylib.mock_call(
          "LoadMusicStream",
          Music.mock_return(sample_rate: 1, sample_size: 2, channels: 3, frame_count: 4, looping: true, ctx_type: 5)
        )

        music = Music.new("./assets/test.ogg")

        assert_equal 1, music.volume
        assert_equal 1, music.pitch
        assert_equal 1, music.length
        assert_equal 4, music.frame_count
        assert_equal 5, music.context_type
        assert_equal true, music.looping
      end

      def test_initialize_with_arguments
        Taylor::Raylib.mock_call(
          "LoadMusicStream",
          Music.mock_return(sample_rate: 2, sample_size: 3, channels: 4, frame_count: 5, looping: true, ctx_type: 6)
        )
        music = Music.new("./assets/test.ogg", looping: false, volume: 0.75, pitch: 0.9)

        assert_equal 0.75, music.volume
        assert_equal 0.9, music.pitch
        assert_equal 1, music.length
        assert_equal 5, music.frame_count
        assert_equal 6, music.context_type
        assert_equal false, music.looping
      end

      def test_unload
        Taylor::Raylib.mock_call(
          "LoadMusicStream",
          Music.mock_return(sample_rate: 3, sample_size: 4, channels: 5, frame_count: 6, looping: true, ctx_type: 7)
        )
        music = Music.new("./assets/test.ogg")
        Taylor::Raylib.reset_calls

        music.unload

        assert_called [
          "(UnloadMusicStream) { music: { frameCount: 6 looping: 1 ctxType: 7 } }"
        ]
      end

      def test_initialize_fail_not_found
        Taylor::Raylib.mock_call("FileExists", "false")

        assert_raise(Music::NotFound) {
          Music.new("./assets/fail.ogg")
        }

        assert_called [
          "(FileExists) { fileName: './assets/fail.ogg' }"
        ]
      end

      def test_initialize_fail_volume_too_high
        begin
          Music.new("./assets/test.ogg", volume: 1.1)
          fail "Previous line should have raised"
        rescue ArgumentError => e
          assert_equal "Volume must be within (0.0..1.0)", e.message
        end

        assert_called [
          "(FileExists) { fileName: './assets/test.ogg' }"
        ]
      end

      def test_initialize_fail_volume_too_low
        begin
          Music.new("./assets/test.ogg", volume: -0.1)
          fail "Previous line should have raised"
        rescue ArgumentError => e
          assert_equal "Volume must be within (0.0..1.0)", e.message
        end

        assert_called [
          "(FileExists) { fileName: './assets/test.ogg' }"
        ]
      end

      def test_looping=
        music = Music.new("./assets/test.ogg", looping: true)

        assert_true music.looping

        music.looping = false
        assert_false music.looping

        music.looping = true
        assert_true music.looping
      end

      def test_to_h
        Taylor::Raylib.mock_call(
          "LoadMusicStream",
          Music.mock_return(sample_rate: 4, sample_size: 5, channels: 6, frame_count: 7, looping: true, ctx_type: 8)
        )

        music = Music.new("./assets/test.ogg")

        assert_equal(
          {
            context_type: 8,
            looping: true,
            frame_count: 7,
            volume: 1.0,
            pitch: 1.0
          },
          music.to_h
        )
      end

      def test_play
        Taylor::Raylib.mock_call(
          "LoadMusicStream",
          Music.mock_return(sample_rate: 5, sample_size: 6, channels: 7, frame_count: 8, looping: true, ctx_type: 9)
        )

        music = Music.new("./assets/test.ogg")

        Taylor::Raylib.reset_calls

        music.play

        assert_called [
          "(IsAudioDeviceReady) { }",
          "(PlayMusicStream) { music: { frameCount: 8 looping: 1 ctxType: 9 } }"
        ]
      end

      def test_play_without_audio
        Taylor::Raylib.mock_call("IsAudioDeviceReady", "false")

        music = Music.new("./assets/test.ogg")
        Taylor::Raylib.reset_calls

        begin
          music.play
          fail "Previous line should have raised"
        rescue Audio::NotOpen => e
          assert_equal "You must use Audio.open before calling Music#play.", e.message
        end

        assert_called [
          "(IsAudioDeviceReady) { }"
        ]
      end

      def test_played
        Taylor::Raylib.mock_call(
          "LoadMusicStream",
          Music.mock_return(sample_rate: 6, sample_size: 7, channels: 8, frame_count: 9, looping: true, ctx_type: 10)
        )

        music = Music.new("./assets/test.ogg")
        Taylor::Raylib.reset_calls

        music.played.zero?

        assert_called [
          "(GetMusicTimePlayed) { music: { frameCount: 9 looping: 1 ctxType: 10 } }"
        ]
      end

      def test_pause
        Taylor::Raylib.mock_call(
          "LoadMusicStream",
          Music.mock_return(sample_rate: 7, sample_size: 8, channels: 9, frame_count: 10, looping: true, ctx_type: 11)
        )

        music = Music.new("./assets/test.ogg")
        Taylor::Raylib.reset_calls

        music.pause

        assert_called [
          "(PauseMusicStream) { music: { frameCount: 10 looping: 1 ctxType: 11 } }"
        ]
      end

      def test_resume
        Taylor::Raylib.mock_call(
          "LoadMusicStream",
          Music.mock_return(sample_rate: 8, sample_size: 9, channels: 10, frame_count: 11, looping: true, ctx_type: 12)
        )

        music = Music.new("./assets/test.ogg")
        Taylor::Raylib.reset_calls

        music.resume

        assert_called [
          "(ResumeMusicStream) { music: { frameCount: 11 looping: 1 ctxType: 12 } }"
        ]
      end

      def test_length
        Taylor::Raylib.mock_call(
          "LoadMusicStream",
          Music.mock_return(sample_rate: 9, sample_size: 10, channels: 11, frame_count: 12, looping: true, ctx_type: 13)
        )
        Taylor::Raylib.mock_call("GetMusicTimeLength", "123")

        music = Music.new("./assets/test.ogg")
        Taylor::Raylib.reset_calls

        assert_equal 123.0, music.length

        assert_called [
          "(GetMusicTimeLength) { music: { frameCount: 12 looping: 1 ctxType: 13 } }"
        ]
      end

      def test_set_volume
        Taylor::Raylib.mock_call(
          "LoadMusicStream",
          Music.mock_return(sample_rate: 10, sample_size: 11, channels: 12, frame_count: 13, looping: true, ctx_type: 14)
        )

        music = Music.new("./assets/test.ogg")
        Taylor::Raylib.reset_calls

        assert_equal 1.0, music.volume

        assert_equal 0.5, (music.volume = 0.5)
        assert_equal 0.5, music.volume

        assert_called [
          "(SetMusicVolume) { music: { frameCount: 13 looping: 1 ctxType: 14 } volume: 0.500000 }"
        ]
      end

      def test_set_volume_fail_too_high
        music = Music.new("./assets/test.ogg")
        Taylor::Raylib.reset_calls

        begin
          music.volume = 1.1
          fail "Previous line should have raised"
        rescue ArgumentError => e
          assert_equal "Volume must be within (0.0..1.0)", e.message
        end

        assert_no_calls
      end

      def test_set_volume_fail_too_low
        music = Music.new("./assets/test.ogg")
        Taylor::Raylib.reset_calls

        begin
          music.volume = -0.1
          fail "Previous line should have raised"
        rescue ArgumentError => e
          assert_equal "Volume must be within (0.0..1.0)", e.message
        end

        assert_no_calls
      end

      def test_set_pitch
        Taylor::Raylib.mock_call(
          "LoadMusicStream",
          Music.mock_return(sample_rate: 11, sample_size: 12, channels: 13, frame_count: 14, looping: true, ctx_type: 15)
        )

        music = Music.new("./assets/test.ogg")
        Taylor::Raylib.reset_calls

        assert_equal 1.0, music.pitch

        assert_equal 0.5, (music.pitch = 0.5)
        assert_equal 0.5, music.pitch

        assert_equal 1.5, (music.pitch = 1.5)
        assert_equal 1.5, music.pitch

        assert_called [
          "(SetMusicPitch) { music: { frameCount: 14 looping: 1 ctxType: 15 } pitch: 0.500000 }",
          "(SetMusicPitch) { music: { frameCount: 14 looping: 1 ctxType: 15 } pitch: 1.500000 }"
        ]
      end
    end
  end
end
