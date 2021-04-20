# Adapted from https://github.com/raysan5/raylib/blob/master/examples/core/core_input_mouse_wheel.c

# Initialization
screen_width = 800
screen_height = 450

init_window(screen_width, screen_height, "raylib [core] example - input mouse wheel")

box_position_y = screen_height / 2 - 40
scroll_speed = 4 # Scrolling speed in pixels

set_target_fps(60) # Set our game to run at 60 frames-per-second

# Main game loop
until window_should_close? # Detect window close button or ESC key
  # Update
  box_position_y -= (get_mouse_wheel_move * scroll_speed)

  # Draw
  begin_drawing

  clear_background(RAYWHITE)

  draw_rectangle(screen_width / 2 - 40, box_position_y, 80, 80, MAROON)

  draw_text("Use mouse wheel to move the cube up and down!", 10, 10, 20, GRAY)
  draw_text("Box position Y: #{box_position_y}", 10, 40, 20, LIGHTGRAY)

  end_drawing
end

# De-Initialization
close_window # Close window and OpenGL context
