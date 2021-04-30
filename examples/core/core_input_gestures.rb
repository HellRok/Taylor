# Adapted from https://github.com/raysan5/raylib/blob/master/examples/core/core_input_multitouch.c

MAX_GESTURE_STRINGS = 20

# Initialization
screen_width = 800
screen_height = 450

init_window(screen_width, screen_height, "raylib [core] example - input gestures")

touch_position = Vector2.new(0, 0)
touch_area = Rectangle.new(220, 10, screen_width - 230, screen_height - 20)

gestures = []

current_gesture = GESTURE_NONE
last_gesture = GESTURE_NONE

#set_gestures_enabled(0b0000000000001001) # Enable only some gestures to be detected

set_target_fps(60) # Set our game to run at 60 frames-per-second

# Main game loop
until window_should_close? # Detect window close button or ESC key
  # Update
  last_gesture = current_gesture;
  current_gesture = get_gesture_detected
  touch_position = get_touch_position(0)

  if check_collision_point_rec(touch_position, touch_area) && current_gesture != GESTURE_NONE
    if current_gesture != last_gesture
      # Store gesture string
      case current_gesture
      when GESTURE_TAP
        gestures.push("GESTURE TAP")
      when GESTURE_DOUBLETAP
        gestures.push("GESTURE DOUBLETAP")
      when GESTURE_HOLD
        gestures.push("GESTURE HOLD")
      when GESTURE_DRAG
        gestures.push("GESTURE DRAG")
      when GESTURE_SWIPE_RIGHT
        gestures.push("GESTURE SWIPE RIGHT")
      when GESTURE_SWIPE_LEFT
        gestures.push("GESTURE SWIPE LEFT")
      when GESTURE_SWIPE_UP
        gestures.push("GESTURE SWIPE UP")
      when GESTURE_SWIPE_DOWN
        gestures.push("GESTURE SWIPE DOWN")
      when GESTURE_PINCH_IN
        gestures.push("GESTURE PINCH IN")
      when GESTURE_PINCH_OUT
        gestures.push("GESTURE PINCH OUT")
      end

      # Reset gestures strings
      if gestures.size >= MAX_GESTURE_STRINGS
        gestures = []
      end
    end
  end

  # Draw
  begin_drawing

  clear_background(RAYWHITE)

  draw_rectangle_rec(touch_area, GRAY)
  draw_rectangle(225, 15, screen_width - 240, screen_height - 30, RAYWHITE)

  draw_text("GESTURES TEST AREA", screen_width - 270, screen_height - 40, 20, fade(GRAY, 0.5))

  gestures.each_with_index do |gesture, index|
    if index % 2 == 0
      draw_rectangle(10, 30 + 20 * index, 200, 20, fade(LIGHTGRAY, 0.5))
    else
      draw_rectangle(10, 30 + 20 * index, 200, 20, fade(LIGHTGRAY, 0.3))
    end

    if (index < gestures.size - 1)
      draw_text(gestures[index], 35, 36 + 20 * index, 10, DARKGRAY)
    else
      draw_text(gestures[index], 35, 36 + 20 * index, 10, MAROON)
    end
  end

  draw_rectangle_lines(10, 29, 200, screen_height - 50, GRAY);
  draw_text("DETECTED GESTURES", 50, 15, 10, GRAY);

  draw_circle_v(touch_position, 30, MAROON) if current_gesture != GESTURE_NONE

  end_drawing
end

# De-Initialization
close_window # Close window and OpenGL context
