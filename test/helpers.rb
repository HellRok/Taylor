def reset_window
  if windows?
    close_window
    init_window(10, 10, "Taylor Test Suite")
  else
    set_window_size 10, 10
  end
  flush_frame
end

def skip_unless_display_present
  skip unless window_ready?
end

def clear_and_draw(&block)
  begin_drawing
  clear(colour: RAYWHITE)
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

def print_raw_colour_data(data, width: 10)
  puts data.each_slice(width).each { |row|
    puts row.map { |colour|
      "Colour.new(#{colour.red}, #{colour.green}, #{colour.blue}, #{colour.alpha}), "
    }.join
  }
end

def print_colour_data(data, width: 10)
  map = ""
  data.each_slice(width).each { |row|
    row.each { |colour|
      map << case colour
      when BLANK
        "t"
      when RAYWHITE
        "w"
      when BLACK
        "B"
      when RED
        "r"
      when GREEN
        "g"
      when BLUE
        "b"
      when PURPLE
        "p"
      when VIOLET
        "v"
      else
        "?"
      end
      map << " "
    }

    map << "\n"
  }

  puts map
end

def print_image_data(image)
  puts print_colour_data(image.data, width: image.width)
end
