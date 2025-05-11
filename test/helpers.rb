def reset_window(&block)
  Window.close if Window.ready?
  block.call if block_given?
  Window.open(width: 10, height: 10, title: "Taylor Test Suite")
  clear_all_flags
  set_target_fps(10)
end

def clear_all_flags
  Window.clear_flag(Window::Flag::VSYNC_HINT)
  Window.clear_flag(Window::Flag::MSAA_4X_HINT)
  Window.clear_flag(Window::Flag::INTERLACED_HINT)

  Window.clear_flag(Window::Flag::FULLSCREEN)
  Window.clear_flag(Window::Flag::RESIZABLE)
  Window.clear_flag(Window::Flag::UNDECORATED)
  Window.clear_flag(Window::Flag::HIDDEN)
  Window.clear_flag(Window::Flag::MINIMISED)
  Window.clear_flag(Window::Flag::MAXIMISED)
  Window.clear_flag(Window::Flag::UNFOCUSED)
  Window.clear_flag(Window::Flag::ALWAYS_ON_TOP)
  Window.clear_flag(Window::Flag::ALWAYS_RUN)
  Window.clear_flag(Window::Flag::TRANSPARENT)
  Window.clear_flag(Window::Flag::HIGH_DPI)
end

def skip_unless_display_present
  skip unless Window.ready?
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
