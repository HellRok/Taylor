def game_template
  <<~STR
    # Add the path ./vendor so we can easily require third party libraries.
    $LOAD_PATHS

    # Open up a window
    Window.open(width: 800, height: 480, title: "$NAME")

    # Setup audio so we can play sounds
    Audio.open

    # Get the current monitor frame rate and set our target framerate to match.
    Window.target_frame_rate = Monitor.current.refresh_rate

    # Define your main method
    def main
      # Get the amount of time passed since the last frame was rendered
      delta = Window.frame_time

      # Your update logic goes here

      Window.draw do
        # Your drawing logic goes here

        Window.clear(colour: Colour::RAYWHITE)
        Font.default.draw(
          "Welcome to your first Taylor application!",
          x: 190, y: 200, size: 20, colour: Colour::DARKGRAY
        )
      end
    end

    if Taylor::Platform.browser?
      Browser.main_loop = "main"
    else
      # Detect window close button or ESC key
      main until Window.close?
    end

    Audio.close
    Window.close
  STR
end
