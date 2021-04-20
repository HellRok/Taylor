# Adapted from https://github.com/raysan5/raylib/blob/master/examples/core/core_input_keys.c

# Initialization
screen_width = 800
screen_height = 450

init_window(screen_width, screen_height, "raylib [core] example - keyboard input")

ball_position = Vector2.new(screen_width / 2, screen_height / 2)

set_target_fps(60) # Set our game to run at 60 frames-per-second

# Main game loop
until window_should_close? # Detect window close button or ESC key
  # Update
  ball_position.x += 2 if is_key_down(KEY_RIGHT)
  ball_position.x -= 2 if is_key_down(KEY_LEFT)
  ball_position.y -= 2 if is_key_down(KEY_UP)
  ball_position.y += 2 if is_key_down(KEY_DOWN)

  # Draw
  begin_drawing

  clear_background(RAYWHITE);

  draw_text("move the ball with arrow keys", 10, 10, 20, DARKGRAY);

  draw_circle_v(ball_position, 50, MAROON);

  end_drawing
end

# De-Initialization
close_window # Close window and OpenGL context
