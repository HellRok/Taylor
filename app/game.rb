init_window(640, 480, 'hello')
target_fps = 60
set_target_fps(target_fps)

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

wabbit = load_texture('resources/wabbit.png')

opaque = Colour.new(0, 0, 0, 128)

colours = 50.times.map {
  Colour.new(
    (rand * 255).to_i,
    (rand * 255).to_i,
    (rand * 255).to_i,
    (rand * 255).to_i,
  )
}

class Rabbit
  def initialize(texture, colour, x, y)
    @texture = texture
    @colour = colour
    @velocity_x = rand * 500 - 250
    @velocity_y = rand * 500 - 250
    @x = x
    @y = y
  end

  def tick(delta)
    @x += @velocity_x * delta
    @y += @velocity_y * delta

    @velocity_x = @velocity_x.abs  if @x < 0
    @velocity_x = -@velocity_x.abs if @x > 640 - @texture.width
    @velocity_y = @velocity_y.abs  if @y < 0
    @velocity_y = -@velocity_y.abs if @y > 480 - @texture.height
  end

  def draw
    draw_texture(@texture, @x, @y, @colour)
  end
end

rabbits = []

until window_should_close?
  delta = get_frame_time

  if get_fps >= target_fps
    100.times do
      rabbits << Rabbit.new(wabbit, colours.sample, 50, 50)
    end
  elsif get_fps <= target_fps - 5
    10.times do
      rabbits.pop
    end
  end

  begin_drawing

  clear_background(BLACK)
  rabbits.each { |rabbit|
    rabbit.tick(delta)
    rabbit.draw
  }

  draw_rectangle(0, 0, 150, 50, opaque)
  draw_fps(5, 10)
  draw_text("Rabbits: #{rabbits.size}", 5, 25, 20, DARKGREEN)

  end_drawing
end

unload_texture(wabbit)
