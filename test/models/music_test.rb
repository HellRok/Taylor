class Test
  class Models
    class Music_Test < MTest::Unit::TestCaseWithAnalytics
      def test_initialize
        music = Music.new(1, true, 2)

        assert_kind_of Music, music
        assert_equal 1, music.context_type
        assert_equal true, music.looping
        assert_equal 2, music.frame_count
      end

      def test_assignment
        music = Music.new(0, false, 0)
        music.context_type = 4
        music.looping = true
        music.frame_count = 2

        assert_equal 4, music.context_type
        assert_equal true, music.looping
        assert_equal 2, music.frame_count
      end

      def test_to_h
        music = Music.new(1, false, 3)

        assert_equal(
          {
            context_type: 1,
            looping: false,
            frame_count: 3
          },
          music.to_h
        )
      end
    end
  end
end
