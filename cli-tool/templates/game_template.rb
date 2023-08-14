def game_template
  <<~STR
    # Add the path ./vendor so we can easily require third party libraries.
    $LOAD_PATHS

    # Open up a window
    init_window(800, 480, "$NAME")

    # Setup audio so we can play sounds
    init_audio_device

    # Get the current monitor frame rate and set our target framerate to match.
    set_target_fps(get_monitor_refresh_rate(get_current_monitor))

    # Define your main method
    def main
      # Get the amount of time passed since the last frame was rendered
      delta = get_frame_time

      # Your update logic goes here

      drawing do
        # Your drawing logic goes here

        clear
        draw_text(
          "Welcome to your first Taylor application!",
          190, 200, 20, DARKGRAY
        )
      end
    end

    if browser?
      set_main_loop 'main'
    else
      # Detect window close button or ESC key
      main until window_should_close?
    end

    close_audio_device
    close_window
  STR
end
