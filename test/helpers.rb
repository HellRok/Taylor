def flush_frame
  begin_drawing
  end_drawing
end

def flush_frames(count)
  count.times { flush_frame }
end

def print_screen_data
  get_screen_data.data.each_slice(10) { |row|
    puts row.map { |colour|
      case colour
      when RAYWHITE
        :w
      when RED
        :r
      when GREEN
        :g
      when BLUE
        :b
      when PURPLE
        :p
      else
        :_
      end
    }
  }
end
