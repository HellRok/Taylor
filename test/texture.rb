class TestTexture < MTest::Unit::TestCase
  def test_draw_texture
    skip_unless_display_present

    init_window(10, 10, __method__.to_s)
    texture = load_texture('test/assets/test.png')
    draw_texture(texture, 3, 3, WHITE)
    flush_frame

    assert_equal fixture_draw_texture, get_screen_data.data
    close_window
  end

  def test_draw_texture_pro
    skip_unless_display_present

    init_window(10, 10, __method__.to_s)
    texture = load_texture('test/assets/test.png')
    draw_texture_pro(
      texture,
      Rectangle.new(0, 0, 3, 3),
      Rectangle.new(0, 0, 9, 9),
      Vector2.new(0 ,0),
      0,
      WHITE
    )
    flush_frame


    assert_equal fixture_draw_texture_pro, get_screen_data.data
    close_window
  end
end
