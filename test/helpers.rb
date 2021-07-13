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
