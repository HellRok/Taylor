# Adapted from https://github.com/raysan5/raylib/blob/master/examples/core/core_input_multitouch.c

MAX_TOUCH_POINTS = 10

# Initialization
screen_width = 800
screen_height = 450

init_window(screen_width, screen_height, "raylib [core] example - input multitouch")

ball_position = Vector2.new(-100, -100)
ball_colour = BEIGE

touch_counter = 0
touch_position = Vector2.new(0, 0)

set_target_fps(60) # Set our game to run at 60 frames-per-second

# Main game loop
until window_should_close?    # Detect window close button or ESC key
  # Update
  ball_position = get_mouse_position

  ball_colour = BEIGE

  ball_colour = MAROON if is_mouse_button_down(MOUSE_LEFT_BUTTON)
  ball_colour = LIME if is_mouse_button_down(MOUSE_MIDDLE_BUTTON)
  ball_colour = DARKBLUE if is_mouse_button_down(MOUSE_RIGHT_BUTTON)

  touch_counter = 10 if is_mouse_button_pressed(MOUSE_LEFT_BUTTON)
  touch_counter = 10 if is_mouse_button_pressed(MOUSE_MIDDLE_BUTTON)
  touch_counter = 10 if is_mouse_button_pressed(MOUSE_RIGHT_BUTTON)

  touch_counter -= 1 if touch_counter > 0

  # Draw
  begin_drawing

  clear_background(RAYWHITE)

  # Multitouch
  MAX_TOUCH_POINTS.times do |i|
    touch_position = get_touch_position(i) # Get the touch point

    if (touch_position.x >= 0) && (touch_position.y >= 0) # Make sure point is not (-1,-1) as this means there is no touch for it
      # Draw circle and touch index number
      draw_circle_v(touch_position, 34, ORANGE)
      draw_text(i.to_s, touch_position.x - 10, touch_position.y - 70, 40, BLACK)
    end
  end

  # Draw the normal mouse location
  draw_circle_v(ball_position, 30 + (touch_counter * 3.0), ball_colour)

  draw_text("move ball with mouse and click mouse button to change color", 10, 10, 20, DARKGRAY)
  draw_text("touch the screen at multiple locations to get multiple balls", 10, 30, 20, DARKGRAY)

  end_drawing
end

# De-Initialization
close_window # Close window and OpenGL context
