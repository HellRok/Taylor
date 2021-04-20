# Adapted from https://github.com/raysan5/raylib/blob/master/examples/core/core_basic_window.c
# Initialization
screen_width = 800
screen_height = 450

init_window(screen_width, screen_height, "raylib [core] example - basic window")

set_target_fps(60) # Set our game to run at 60 frames-per-second

# Main game loop
until window_should_close? # Detect window close button or ESC key
  # Update
  # TODO: Update your variables here

  # Draw
  begin_drawing

  clear_background(RAYWHITE)

  draw_text("Congrats! You created your first window!", 190, 200, 20, LIGHTGRAY)

  end_drawing
end

# De-Initialization
close_window # Close window and OpenGL context
