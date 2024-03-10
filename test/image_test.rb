class Test
  class Image_Test < MTest::Unit::TestCaseWithAnalytics
    def test_image_colour_replace!
      image = Image.new("assets/test.png")

      image_colour_replace!(image, Colour::WHITE, Colour::BLUE)
      assert_equal fixture_image_colour_replace!, image.data
    ensure
      image.unload
    end

    def test_image_draw!
      image = Image.generate(width: 3, height: 3, colour: Colour::RAYWHITE)
      to_copy = Image.new("assets/test.png")

      image_draw!(
        image,
        to_copy,
        Rectangle.new(0, 0, 2, 2),
        Rectangle.new(1, 1, 2, 2),
        Colour::WHITE
      )
      assert_equal fixture_image_draw!, image.data
    ensure
      image.unload
      to_copy.unload
    end
  end
end
