class Test
  class Models
    class RenderTexture_Test < MTest::Unit::TestCaseWithAnalytics
      def test_initialize
        skip_unless_display_present
        set_window_title(__method__.to_s)

        render_texture = RenderTexture.new(64, 32)

        assert_kind_of RenderTexture, render_texture
        assert_equal 64, render_texture.width
        assert_equal 32, render_texture.height
        assert_equal 64, render_texture.texture.width
        assert_equal 32, render_texture.texture.height
      end

      def test_to_h
        skip_unless_display_present
        set_window_title(__method__.to_s)

        render_texture = RenderTexture.new(64, 32)

        assert_equal(
          {
            width: 64,
            height: 32,
            texture: {
              id: render_texture.texture.id,
              width: 64,
              height: 32,
              mipmaps: 1,
              format: 7,
            }
          },
          render_texture.to_h
        )
      end
    end
  end
end
