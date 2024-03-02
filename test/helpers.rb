def reset_window
  if windows?
    close_window
    init_window(10, 10, "Taylor Test Suite")
  else
    set_window_size 10, 10
  end
  flush_frame until get_screen_width == 10 && get_screen_height == 10
end

def skip_unless_display_present
  skip unless window_ready?
end

def clear_and_draw(&block)
  begin_drawing
  clear(colour: Colour::RAYWHITE)
  block.call
ensure
  end_drawing
end

def flush_frame
  begin_drawing
  end_drawing
end

def flush_frames(count)
  count.times { flush_frame }
end

def raw_colour_data(data, width: 10)
  data.each_slice(width).each { |row|
    puts row.map { |colour|
      "Colour.new(#{colour.red}, #{colour.green}, #{colour.blue}, #{colour.alpha}), "
    }.join
  }
end

def colour_data(data, width: 10)
  map = ""
  data.each_slice(width).each { |row|
    row.each { |colour|
      map << case colour
      when Colour::BLANK
        "t"
      when Colour::RAYWHITE
        "w"
      when Colour::BLACK
        "B"
      when Colour::RED
        "r"
      when Colour::GREEN
        "g"
      when Colour::BLUE
        "b"
      when Colour::PURPLE
        "p"
      when Colour::VIOLET
        "v"
      else
        "?"
      end
      map << " "
    }

    map << "\n"
  }

  map
end

def image_data(image)
  print_colour_data(image.data, width: image.width)
end
