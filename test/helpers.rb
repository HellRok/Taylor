def use_window?
  !ENV.fetch("DISPLAY", "").empty? || browser? || windows?
end

def skip_unless_audio_enabled
  skip "User skipped audio tests" if ENV["SKIP_AUDIO_TESTS"]
  skip "Can't open and close audio more than once in WINE" if windows?
  skip "No sound device found" unless File.exist? "/dev/snd"
end

def noop
  sleep 1
  flush_frame
end

def reset_window
  Window.close
  Window.open(width: 10, height: 10, title: "Taylor Test Suite")
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

def flush_frame(&block)
  begin_drawing
  block&.call
  end_drawing
end

def flush_frames(count, &block)
  count.times { flush_frame(&block) }
end

def raw_colour_data(data, width: 10)
  data.each_slice(width).each { |row|
    puts row.map { |colour|
      "Colour[#{colour.red}, #{colour.green}, #{colour.blue}, #{colour.alpha}], "
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
