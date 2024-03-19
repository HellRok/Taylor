class Test
  class Models
    class Audio_Test < MTest::Unit::TestCaseWithAnalytics
      def test_ready?
        assert_false Audio.ready?

        Audio.open
        flush_frame until Audio.ready?
        assert_true Audio.ready?

        Audio.close
        assert_false Audio.ready?
      ensure
        Audio.close
      end

      def test_volume
        Audio.open
        flush_frame until Audio.ready?

        skip "Waiting on Raylib 5.0"

        assert_equal 100, Audio.volume

        Audio.volume = 50
        assert_equal 50, Audio.volume

        Audio.volume += 10
        assert_equal 60, Audio.volume
      ensure
        Audio.close
      end

      def test_volume_equals_errors
        Audio.open
        flush_frame until Audio.ready?

        begin
          Audio.volume = -1
          fail "Previous line should have raised"
        rescue ArgumentError => e
          assert_equal "Must be within (0..100)", e.message
        end

        begin
          Audio.volume = 101
          fail "Previous line should have raised"
        rescue ArgumentError => e
          assert_equal "Must be within (0..100)", e.message
        end
      ensure
        Audio.close
      end

      def test_volume_before_open
        skip "Waiting on Raylib 5.0"

        Audio.volume
      rescue Audio::NotOpen => e
        assert_equal "You must use Audio.open before calling Audio.volume.", e.message
      end

      def test_set_volume_before_open
        Audio.volume = 50
      rescue Audio::NotOpen => e
        assert_equal "You must use Audio.open before calling Audio.volume=.", e.message
      end
    end
  end
end
