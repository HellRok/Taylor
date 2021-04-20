# Adapted from https://github.com/raysan5/raylib/blob/master/examples/core/core_input_mouse.c

# Initialization
screen_width = 800
screen_height = 450

init_window(screen_width, screen_height, "raylib [core] example - mouse input");

ball_position = Vector2.new(-100.0, -100.0)
ball_color = DARKBLUE

set_target_fps(60) # Set our game to run at 60 frames-per-second

# Main game loop
until window_should_close? # Detect window close button or ESC key
  # Update
  ball_position = get_mouse_position

  ball_color = MAROON if is_mouse_button_pressed(MOUSE_LEFT_BUTTON)
  ball_color = LIME if is_mouse_button_pressed(MOUSE_MIDDLE_BUTTON)
  ball_color = DARKBLUE if is_mouse_button_pressed(MOUSE_RIGHT_BUTTON)

    # Draw
    begin_drawing();

    clear_background(RAYWHITE);

    draw_circle_v(ball_position, 40, ball_color);

    draw_text("move ball with mouse and click mouse button to change color", 10, 10, 20, DARKGRAY);

    end_drawing
  end

  # De-Initialization
  close_window # Close window and OpenGL context
