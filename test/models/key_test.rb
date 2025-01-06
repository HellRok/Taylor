class Test
  class Models
    class Key_Test < MTest::Unit::TestCaseWithAnalytics
      def test_pressed?
        skip "xdotool not available" unless XDo.available?

        assert_false Key.pressed?(Key::A), "The a key starts unpressed"

        XDo::Key.down(:a)
        flush_frame
        assert_true Key.pressed?(Key::A), "The a key gets pressed"

        flush_frame
        assert_false Key.pressed?(Key::A), "The a key is no longer considered pressed since a frame has occured"

        XDo::Key.up(:a)
        flush_frame
        assert_false Key.pressed?(Key::A), "The a key has been released"
      ensure
        XDo::Key.up(:a) if XDo.available?
      end

      def test_down?
        skip "xdotool not available" unless XDo.available?

        assert_false Key.down?(Key::B), "The b key starts up"

        XDo::Key.down(:b)
        flush_frame
        assert_true Key.down?(Key::B), "The b key gets pressed"

        flush_frame
        assert_true Key.down?(Key::B), "The b key is still held down"

        XDo::Key.up(:b)
        flush_frame
        assert_false Key.down?(Key::B), "The b key has been released"
      ensure
        XDo::Key.up(:b) if XDo.available?
      end

      def test_released?
        skip "xdotool not available" unless XDo.available?

        assert_false Key.released?(Key::C), "The c key starts up"

        XDo::Key.down(:c)
        flush_frame
        assert_false Key.released?(Key::C), "The c key gets pressed"

        XDo::Key.up(:c)
        flush_frame
        assert_true Key.released?(Key::C), "The c key has been released"

        flush_frame
        assert_false Key.released?(Key::C), "A frame has passed since the c key was released"
      ensure
        XDo::Key.up(:c) if XDo.available?
      end

      def test_up?
        skip "xdotool not available" unless XDo.available?

        assert_true Key.up?(Key::D), "The d key starts up"

        XDo::Key.down(:d)
        flush_frame
        assert_false Key.up?(Key::D), "The d key gets pressed"

        XDo::Key.up(:d)
        flush_frame
        assert_true Key.up?(Key::D), "The d key has been released"

        flush_frame
        assert_true Key.up?(Key::D), "A frame has passed since the d key was released"
      ensure
        XDo::Key.up(:d) if XDo.available?
      end

      def test_pressed
        skip "xdotool not available" unless XDo.available?

        assert_equal nil, Key.pressed, "No frame has happened and no key has been pressed"

        XDo::Key.down(:a)
        XDo::Key.down(:b)
        flush_frame
        assert_equal Key::A, Key.pressed, "A was the first pressed key"
        assert_equal Key::B, Key.pressed, "B was the second pressed key"
        assert_equal nil, Key.pressed, "No other key was pressed"

        XDo::Key.down(:d)
        XDo::Key.down(:c)
        flush_frame
        assert_equal Key::D, Key.pressed, "d was the first pressed key"
        assert_equal Key::C, Key.pressed, "c was the second pressed key"
        assert_equal nil, Key.pressed, "No other key was pressed"
      ensure
        if XDo.available?
          XDo::Key.up(:a)
          XDo::Key.up(:b)
          XDo::Key.up(:c)
          XDo::Key.up(:d)
        end
      end
    end
  end
end
