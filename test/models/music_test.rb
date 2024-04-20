class Test
  class Models
    class Music_Test < MTest::Unit::TestCaseWithAnalytics
      def test_initialize
        music = Music.new("./assets/test.ogg")

        assert_equal Music::Type::OGG, music.context_type
        assert_equal 1, music.volume
        assert_equal 1, music.pitch
        assert_equal 88200, music.frame_count
        assert_equal 2, music.length
        assert_equal false, music.playing?
        assert_equal true, music.looping
      ensure
        music.unload
      end

      def test_initialize_with_arguments
        music = Music.new("./assets/test.ogg", looping: false, volume: 0.75, pitch: 0.9)

        assert_equal Music::Type::OGG, music.context_type
        assert_equal 0.75, music.volume
        assert_equal 0.9, music.pitch
        assert_equal 88200, music.frame_count
        assert_equal 2, music.length
        assert_equal false, music.playing?
        assert_equal false, music.looping
      ensure
        music.unload
      end

      def test_initialize_fail_not_found
        assert_raise(Music::NotFound) {
          Music.new("./assets/fail.ogg")
        }
      end

      def test_initialize_fail_volume
        begin
          Music.new("./assets/test.ogg", volume: 1.1)
          fail "Previous line should have raised"
        rescue ArgumentError => e
          assert_equal "Volume must be within (0.0..1.0)", e.message
        end

        begin
          Music.new("./assets/test.ogg", volume: -0.1)
          fail "Previous line should have raised"
        rescue ArgumentError => e
          assert_equal "Volume must be within (0.0..1.0)", e.message
        end
      end

      def test_looping=
        music = Music.new("./assets/test.ogg", looping: true)

        assert_true music.looping

        music.looping = false
        assert_false music.looping

        music.looping = true
        assert_true music.looping
      ensure
        music.unload
      end

      def test_to_h
        music = Music.new("./assets/test.ogg")

        assert_equal(
          {
            context_type: 2,
            looping: true,
            frame_count: 88200,
            volume: 1.0,
            pitch: 1.0
          },
          music.to_h
        )
      ensure
        music.unload
      end

      def test_play
        skip "Can't open and close audio more than once in WINE." if windows?
        Audio.open
        music = Music.new("./assets/test.ogg", looping: false)

        assert_false music.playing?
        music.play
        assert_true music.playing?
        music.stop
        assert_false music.playing?
      ensure
        if music
          music.stop
          music.unload
        end
        Audio.close
      end

      def test_play_without_audio
        music = Music.new("./assets/test.ogg", looping: false)

        assert_false music.playing?
        begin
          music.play
          fail "Previous line should have raised"
        rescue Audio::NotOpen => e
          assert_equal "You must use Audio.open before calling Music#play.", e.message
        end
      end

      def test_played
        skip "Can't open and close audio more than once in WINE." if windows?
        skip "Browsers disable audio unless human interaction is detected." if browser?
        Audio.open
        music = Music.new("./assets/test.ogg", looping: false)

        assert_equal 0, music.played

        music.play
        5.times do
          music.update
          flush_frame
        end

        assert_false music.played.zero?
      ensure
        if music
          music.stop
          music.unload
        end
        Audio.close
      end

      def test_pause_resume
        skip "Can't open and close audio more than once in WINE." if windows?
        skip "Browsers disable audio unless human interaction is detected." if browser?
        Audio.open
        music = Music.new("./assets/test.ogg", looping: false)

        assert_equal 0, music.played, "Is 0 before playing"

        music.play
        5.times do
          music.update
          flush_frame
        end

        current_state = music.played
        music.pause
        5.times do
          music.update
          flush_frame
        end

        assert_equal current_state, music.played, "Matches the amount of time passed before pausing"
        music.resume

        5.times do
          music.update
          flush_frame
        end
        assert_true music.played > current_state, "Is further along since resuming"
      ensure
        if music
          music.stop
          music.unload
        end
        Audio.close
      end

      def test_length
        music = Music.new("./assets/test.ogg", looping: false)
        assert_equal 2.0, music.length
      ensure
        music.unload
      end

      def test_set_volume
        music = Music.new("./assets/test.ogg", looping: false)
        assert_equal 1.0, music.volume

        assert_equal 0.5, (music.volume = 0.5)
        assert_equal 0.5, music.volume
      ensure
        music.unload
      end

      def test_set_volume_fail
        music = Music.new("./assets/test.ogg", looping: false)

        begin
          music.volume = 1.1
          fail "Previous line should have raised"
        rescue ArgumentError => e
          assert_equal "Volume must be within (0.0..1.0)", e.message
        end

        begin
          music.volume = -0.1
          fail "Previous line should have raised"
        rescue ArgumentError => e
          assert_equal "Volume must be within (0.0..1.0)", e.message
        end
      ensure
        music.unload
      end
    end
  end
end
