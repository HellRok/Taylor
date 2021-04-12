init_window(100, 100, 'hello')
set_target_fps(144)

colour = Colour.new(0, 0, 0 ,255)
red = Colour.new(255, 0 ,0, 255)

until window_should_close?
  delta = get_frame_time
  begin_drawing
  clear_background(colour)
  draw_rectangle(50, 50, 25, 25, red)
  draw_fps(10, 10)
  end_drawing
end
