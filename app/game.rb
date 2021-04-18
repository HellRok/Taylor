init_window(640, 480, 'hello')
set_target_fps(60)

class Colour
  def to_h
    {
      red: red,
      green: green,
      blue: blue,
      alpha: alpha,
    }
  end
end

class Texture2D
  def to_h
    {
      id: id,
      width: width,
      height: height,
      mipmaps: mipmaps,
      format: format,
    }
  end
end

colour = Colour.new(0, 0, 0 ,255)
red = Colour.new(255, 0 ,0, 255)
green = Colour.new(0, 255 ,0, 255)

wabbit = load_texture('resources/wabbit.png')

until window_should_close?
  delta = get_frame_time
  begin_drawing
  clear_background(colour)
  draw_rectangle(50, 50, 25, 25, red)
  draw_texture(wabbit, 50, 50, green)
  draw_rectangle(75, 75, 25, 25, green)
  draw_fps(10, 10)
  end_drawing
end

unload_texture(wabbit)
