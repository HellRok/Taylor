init_window(640, 480, 'hello')
set_target_fps(144)

colour = Colour.new(0, 0, 0 ,255)
red = Colour.new(255, 0 ,0, 255)
green = Colour.new(0, 255 ,0, 255)

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

t = load_texture('resources/wabbit.png')
#t = Texture2D.load('resources/wabbit.png')
puts t.to_h
b = Texture2D.new #1, 1, 1, 1, 1
puts b.to_h

until window_should_close?
  delta = get_frame_time
  begin_drawing
  clear_background(colour)
  draw_rectangle(50, 50, 25, 25, red)
  draw_texture(t, 50, 50, green)
  #draw_texture(b, 50, 50, green)
  draw_rectangle(75, 75, 25, 25, green)
  draw_fps(10, 10)
  end_drawing

  #Debug
  GC.start
end
