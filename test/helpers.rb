def reset_window
  if windows?
    close_window
    init_window(10, 10, 'Taylor Test Suite')
    flush_frame
  else
    set_window_size 10, 10
    flush_frame
  end
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

def raw_colour_data(data)
  data.each_slice(10).each { |row|
    puts row.map { |colour|
      "Colour.new(#{colour.red}, #{colour.green}, #{colour.blue}, #{colour.alpha}), "
    }.join
  }
end

def print_colour_data(data)
  map = ''
  data.each_slice(10).each { |row|
    row.each { |colour|
      case colour
      when RAYWHITE
        map << 'w'
      when BLACK
        map << 'b'
      when RED
        map << 'r'
      when GREEN
        map << 'g'
      when BLUE
        map << 'b'
      when PURPLE
        map << 'p'
      when VIOLET
        map << 'v'
      else
        map << '?'
      end
      map << ' '
    }

    map << "\n"
  }

  map
end
