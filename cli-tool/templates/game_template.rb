def game_template
  <<-STR
# Add the path ./vendor so we can easily require third party libraries.
$LOAD_PATHS

# Open up a window
init_window(800, 480, "$NAME")

# Get the current monitor frame rate and set our target framerate to match.
set_target_fps(get_monitor_refresh_rate(get_current_monitor))

# Detect window close button or ESC key
until window_should_close?
  # Your update logic goes here

  begin_drawing
  # Your drawing logic goes here

  clear_background(RAYWHITE)
  draw_text(
    "Welcome to your first Taylor application!",
    190, 200, 20, DARKGRAY
  )

  end_drawing
end

close_window
  STR
end
