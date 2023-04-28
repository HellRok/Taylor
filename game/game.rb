require "jump"
return

def jump_sound
  @jump_sound ||= load_sound("jump.wav")
end

def init
  set_window_size 800, 600
end

include Garak

def tick
  if key_pressed?(KEY_SPACE)
    jump_sound.play
  end

  drawing do
    clear_background Colour[
      Math.sin(Garak.frame_count / 77.0).+(1)./(2).*(120).round,
      Math.sin(Garak.frame_count.+(30) / 66.0).+(1)./(2).*(120).round,
      Math.sin(Garak.frame_count.-(70) / 55.0).+(1)./(2).*(120).round,
    ]

    if mouse_button_down?(MOUSE_LEFT_BUTTON) or mouse_button_pressed?(0)
      draw_rectangle 0, 0, get_screen_width, get_screen_height, Colour.new(0, 0, 0, 50)
    end

    draw_text "frame #{Garak.frame_count}", 20, get_screen_height - 40, 20, ORANGE

    # draw_center_text "Hello world #{Garak.frame_count}", 32, YELLOW, default_font, 10
    draw_center_text "#{get_mouse_position.x}, #{get_mouse_position.y}", 32, YELLOW, default_font, 10
  end
end

def draw_center_text(text, size, color, font=default_font, padding=0, hack=false)
  measured = measure_text_ex(font, hack ? "W" * text.size : text, size, padding)
  # position = Vector2.new(get_screen_width/2 - measured.x/2, get_screen_height/2 - measured.y/2)
  position = Vector2[get_screen_width/2 - measured.x/2, get_screen_height/2 - measured.y/2]
  draw_text_ex(font, text, position, size, padding, color)
end
