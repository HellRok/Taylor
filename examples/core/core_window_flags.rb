# Adapted from https://github.com/raysan5/raylib/blob/master/examples/core/core_window_flags.c
# Initialization
screen_width = 800;
screen_height = 450;

# Possible window flags
#
#FLAG_VSYNC_HINT
#FLAG_FULLSCREEN_MODE    -> not working properly -> wrong scaling!
#FLAG_WINDOW_RESIZABLE
#FLAG_WINDOW_UNDECORATED
#FLAG_WINDOW_TRANSPARENT
#FLAG_WINDOW_HIDDEN
#FLAG_WINDOW_MINIMISED   -> Not supported on window creation
#FLAG_WINDOW_MAXIMISED   -> Not supported on window creation
#FLAG_WINDOW_UNFOCUSED
#FLAG_WINDOW_TOPMOST
#FLAG_WINDOW_HIGHDPI     -> errors after minimize-resize, fb size is recalculated
#FLAG_WINDOW_ALWAYS_RUN
#FLAG_MSAA_4X_HINT

# Set configuration flags for window creation
#set_config_flags(FLAG_VSYNC_HINT | FLAG_MSAA_4X_HINT | FLAG_WINDOW_HIGHDPI)
#set_config_flags(FLAG_WINDOW_TRANSPARENT)
init_window(screen_width, screen_height, "raylib [core] example - window flags");

ball_position = Vector2.new(get_screen_width / 2.0, get_screen_height / 2.0)
ball_speed = Vector2.new(5.0, 4.0)
ball_radius = 20

frames_counter = 0;

set_target_fps(60) # Set our game to run at 60 frames-per-second

# Main game loop
until window_should_close? do # Detect window close button or ESC key
  # Update
  toggle_fullscreen if is_key_pressed(KEY_F)   # modifies window size when scaling!

  if is_key_pressed(KEY_R)
    if is_window_state?(FLAG_WINDOW_RESIZABLE)
      clear_window_state(FLAG_WINDOW_RESIZABLE)
    else
      set_window_state(FLAG_WINDOW_RESIZABLE)
    end
  end

  if is_key_pressed(KEY_D)
    if is_window_state?(FLAG_WINDOW_UNDECORATED)
      clear_window_state(FLAG_WINDOW_UNDECORATED)
    else
      set_window_state(FLAG_WINDOW_UNDECORATED)
    end
  end

  if is_key_pressed(KEY_H)
    set_window_state(FLAG_WINDOW_HIDDEN) unless is_window_state?(FLAG_WINDOW_HIDDEN)

    frames_counter = 0
  end

  if is_window_state?(FLAG_WINDOW_HIDDEN)
    frames_counter += 1
    clear_window_state(FLAG_WINDOW_HIDDEN) if frames_counter >= 240 # Show window after 3 seconds
  end

  if is_key_pressed(KEY_N)
    minimise_window unless is_window_state?(FLAG_WINDOW_MINIMISED)

    frames_counter = 0
  end

  if is_window_state?(FLAG_WINDOW_MINIMISED)
    frames_counter += 1
    restore_window if frames_counter >= 240 # Restore window after 3 seconds
  end

  if is_key_pressed(KEY_M)
    # NOTE: Requires FLAG_WINDOW_RESIZABLE enabled!
    if is_window_state?(FLAG_WINDOW_MAXIMISED)
      restore_window
    else
      maximise_window
    end
  end

  if is_key_pressed(KEY_U)
    if is_window_state?(FLAG_WINDOW_UNFOCUSED)
      clear_window_state(FLAG_WINDOW_UNFOCUSED)
    else
      set_window_state(FLAG_WINDOW_UNFOCUSED)
    end
  end

  if is_key_pressed(KEY_T)
    if is_window_state?(FLAG_WINDOW_TOPMOST)
      clear_window_state(FLAG_WINDOW_TOPMOST)
    else
      set_window_state(FLAG_WINDOW_TOPMOST)
    end
  end

  if is_key_pressed(KEY_A)
    if is_window_state?(FLAG_WINDOW_ALWAYS_RUN)
      clear_window_state(FLAG_WINDOW_ALWAYS_RUN)
    else
      set_window_state(FLAG_WINDOW_ALWAYS_RUN)
    end
  end

  if is_key_pressed(KEY_V)
    if is_window_state?(FLAG_VSYNC_HINT)
      clear_window_state(FLAG_VSYNC_HINT)
    else
      set_window_state(FLAG_VSYNC_HINT)
    end
  end

  # Bouncing ball logic
  ball_position.x += ball_speed.x
  ball_position.y += ball_speed.y
  ball_speed.x *= -1.0 if (ball_position.x >= (get_screen_width() - ball_radius)) || (ball_position.x <= ball_radius)
  ball_speed.y *= -1.0 if (ball_position.y >= (get_screen_height() - ball_radius)) || (ball_position.y <= ball_radius)

  # Draw
  begin_drawing

  if is_window_state?(FLAG_WINDOW_TRANSPARENT)
    clear_background(BLANK)
  else
    clear_background(RAYWHITE)
  end

  draw_circle_v(ball_position, ball_radius, MAROON);
  draw_rectangle_lines_ex(Rectangle.new(0, 0, get_screen_width, get_screen_height), 4, RAYWHITE)

  draw_circle_v(get_mouse_position, 10, DARKBLUE)

  draw_fps(10, 10)

  draw_text("Screen Size: [#{get_screen_width}, #{get_screen_height}]", 10, 40, 10, GREEN)

  # Draw window state info
  draw_text("Following flags can be set after window creation:", 10, 60, 10, GRAY)

  if is_window_state?(FLAG_FULLSCREEN_MODE)
    draw_text("[F] FLAG_FULLSCREEN_MODE: on", 10, 80, 10, LIME)
  else
    draw_text("[F] FLAG_FULLSCREEN_MODE: off", 10, 80, 10, MAROON)
  end

  if is_window_state?(FLAG_WINDOW_RESIZABLE)
    draw_text("[R] FLAG_WINDOW_RESIZABLE: on", 10, 100, 10, LIME)
  else
    draw_text("[R] FLAG_WINDOW_RESIZABLE: off", 10, 100, 10, MAROON)
  end

  if is_window_state?(FLAG_WINDOW_UNDECORATED)
    draw_text("[D] FLAG_WINDOW_UNDECORATED: on", 10, 120, 10, LIME)
  else
    draw_text("[D] FLAG_WINDOW_UNDECORATED: off", 10, 120, 10, MAROON)
  end

  if is_window_state?(FLAG_WINDOW_HIDDEN)
    draw_text("[H] FLAG_WINDOW_HIDDEN: on", 10, 140, 10, LIME)
  else
    draw_text("[H] FLAG_WINDOW_HIDDEN: off", 10, 140, 10, MAROON)
  end

  if is_window_state?(FLAG_WINDOW_MINIMISED)
    draw_text("[N] FLAG_WINDOW_MINIMISED: on", 10, 160, 10, LIME)
  else
    draw_text("[N] FLAG_WINDOW_MINIMISED: off", 10, 160, 10, MAROON)
  end

  if is_window_state?(FLAG_WINDOW_MAXIMISED)
    draw_text("[M] FLAG_WINDOW_MAXIMISED: on", 10, 180, 10, LIME)
  else
    draw_text("[M] FLAG_WINDOW_MAXIMISED: off", 10, 180, 10, MAROON)
  end

  if is_window_state?(FLAG_WINDOW_UNFOCUSED)
    draw_text("[U] FLAG_WINDOW_UNFOCUSED: on", 10, 200, 10, LIME)
  else
    draw_text("[U] FLAG_WINDOW_UNFOCUSED: off", 10, 200, 10, MAROON)
  end

  if is_window_state?(FLAG_WINDOW_TOPMOST)
    draw_text("[T] FLAG_WINDOW_TOPMOST: on", 10, 220, 10, LIME)
  else
    draw_text("[T] FLAG_WINDOW_TOPMOST: off", 10, 220, 10, MAROON)
  end

  if is_window_state?(FLAG_WINDOW_ALWAYS_RUN)
    draw_text("[A] FLAG_WINDOW_ALWAYS_RUN: on", 10, 240, 10, LIME)
  else
    draw_text("[A] FLAG_WINDOW_ALWAYS_RUN: off", 10, 240, 10, MAROON)
  end

  if is_window_state?(FLAG_VSYNC_HINT)
    draw_text("[V] FLAG_VSYNC_HINT: on", 10, 260, 10, LIME)
  else
    draw_text("[V] FLAG_VSYNC_HINT: off", 10, 260, 10, MAROON)
  end

  draw_text("Following flags can only be set before window creation:", 10, 300, 10, GRAY)
  if is_window_state?(FLAG_WINDOW_HIGHDPI)
    draw_text("FLAG_WINDOW_HIGHDPI: on", 10, 320, 10, LIME)
  else
    draw_text("FLAG_WINDOW_HIGHDPI: off", 10, 320, 10, MAROON)
  end

  if is_window_state?(FLAG_WINDOW_TRANSPARENT)
    draw_text("FLAG_WINDOW_TRANSPARENT: on", 10, 340, 10, LIME)
  else
    draw_text("FLAG_WINDOW_TRANSPARENT: off", 10, 340, 10, MAROON)
  end

  if is_window_state?(FLAG_MSAA_4X_HINT)
    draw_text("FLAG_MSAA_4X_HINT: on", 10, 360, 10, LIME)
  else
    draw_text("FLAG_MSAA_4X_HINT: off", 10, 360, 10, MAROON)
  end

  end_drawing
end

# De-Initialization
close_window # Close window and OpenGL context

