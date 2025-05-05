class Test
  class Core
    class Drawing_Test < Test::Base
      def test_clear
        clear
        assert_called ["(ClearBackground) { color: { r: 245 g: 245 b: 245 a: 255 } }"]
      end

      def test_clear_with_colour
        clear(colour: Colour::GREEN)
        assert_called ["(ClearBackground) { color: { r: 0 g: 228 b: 48 a: 255 } }"]
      end

      # def test_drawing
      #  skip_unless_display_present

      #  set_window_title(__method__.to_s)
      #  clear_and_draw do
      #    clear_background(Colour::RAYWHITE)
      #  end
      #  assert_equal fixture_core_drawing_drawing, get_screen_data.data

      #  clear_and_draw do
      #    clear_background(Colour::RED)
      #  end
      #  assert_not_equal fixture_core_drawing_drawing, get_screen_data.data

      #  drawing do
      #    clear_background(Colour::RAYWHITE)
      #  end
      #  assert_equal fixture_core_drawing_drawing, get_screen_data.data
      # end

      # def test_scissor_mode
      #  skip_unless_display_present

      #  set_window_title(__method__.to_s)
      #  drawing do
      #    clear_background(Colour::RAYWHITE)
      #    scissor_mode(Rectangle.new(2, 2, 6, 6)) do
      #      clear_background(Colour::RED)
      #    end
      #  end
      #  assert_equal fixture_core_drawing_scissor_mode, get_screen_data.data
      # end

      # def test_blend_mode
      #  skip_unless_display_present

      #  set_window_title(__method__.to_s)

      #  clear

      #  red = Image.generate(width: 2, height: 2, colour: Colour::RED).to_texture
      #  green = Image.generate(width: 2, height: 2, colour: Colour::GREEN).to_texture
      #  green_transparent = Image.generate(width: 2, height: 2, colour: Colour[0, 228, 48, 127]).to_texture

      #  red.draw(destination: Rectangle.new(0, 0, 2, 2))
      #  blend_mode(BLEND_ADDITIVE) { green.draw(destination: Rectangle.new(0, 0, 2, 2)) }

      #  red.draw(destination: Rectangle.new(2, 0, 2, 2))
      #  blend_mode(BLEND_MULTIPLIED) { green.draw(destination: Rectangle.new(2, 0, 2, 2)) }

      #  red.draw(destination: Rectangle.new(4, 0, 2, 2))
      #  blend_mode(BLEND_ADD_COLORS) { green.draw(destination: Rectangle.new(4, 0, 2, 2)) }

      #  red.draw(destination: Rectangle.new(6, 0, 2, 2))
      #  blend_mode(BLEND_SUBTRACT_COLORS) { green.draw(destination: Rectangle.new(6, 0, 2, 2)) }

      #  red.draw(destination: Rectangle.new(8, 0, 2, 2))
      #  blend_mode(BLEND_ALPHA) { green_transparent.draw(destination: Rectangle.new(8, 0, 2, 2)) }

      #  red.draw(destination: Rectangle.new(0, 2, 2, 2))
      #  blend_mode(BLEND_ALPHA_PREMULTIPLY) { green_transparent.draw(destination: Rectangle.new(0, 2, 2, 2)) }

      #  flush_frame

      #  assert_equal fixture_core_drawing_blend_mode, get_screen_data.data
      # end
    end
  end
end
