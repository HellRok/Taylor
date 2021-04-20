#include "raylib.h"
#include "raygui.hpp"
#include "mruby.h"
#include "mruby/data.h"
#include "mruby/class.h"
#include "mruby/irep.h"
#include "mruby/compile.h"

#include "mruby_integration/structs.hpp"
#include "mruby_integration/textures.hpp"
#include "mruby_integration/core.hpp"
#include "mruby_integration/text.hpp"
#include "mruby_integration/shapes.hpp"

int main(int, char **argv) {
  const char *path;
  if (argv) {
    path = argv[1];
  } else {
    path = "./game.rb";
  }

  mrb_state *mrb = mrb_open();

  append_core(mrb);
  append_shapes(mrb);
  append_structs(mrb);
  append_text(mrb);
  append_textures(mrb);

  FILE *game_file = fopen(path, "r");
  mrb_load_string(mrb, R"(
    FLAG_VSYNC_HINT         = 0x00000040   # Set to try enabling V-Sync on GPU
    FLAG_FULLSCREEN_MODE    = 0x00000002   # Set to run program in fullscreen
    FLAG_WINDOW_RESIZABLE   = 0x00000004   # Set to allow resizable window
    FLAG_WINDOW_UNDECORATED = 0x00000008   # Set to disable window decoration (frame and buttons)
    FLAG_WINDOW_HIDDEN      = 0x00000080   # Set to hide window
    FLAG_WINDOW_MINIMIZED   = 0x00000200   # Set to minimize window (iconify)
    FLAG_WINDOW_MAXIMIZED   = 0x00000400   # Set to maximize window (expanded to monitor)
    FLAG_WINDOW_UNFOCUSED   = 0x00000800   # Set to window non focused
    FLAG_WINDOW_TOPMOST     = 0x00001000   # Set to window always on top
    FLAG_WINDOW_ALWAYS_RUN  = 0x00000100   # Set to allow windows running while minimized
    FLAG_WINDOW_TRANSPARENT = 0x00000010   # Set to allow transparent framebuffer
    FLAG_WINDOW_HIGHDPI     = 0x00002000   # Set to support HighDPI
    FLAG_MSAA_4X_HINT       = 0x00000020   # Set to try enabling MSAA 4X
    FLAG_INTERLACED_HINT    = 0x00010000   # Set to try enabling interlaced video format (for V3D)

    LIGHTGRAY = Colour.new(200, 200, 200, 255)
    GRAY = Colour.new(130, 130, 130, 255)
    DARKGRAY = Colour.new(80, 80, 80, 255)
    YELLOW = Colour.new(253, 249, 0, 255)
    GOLD = Colour.new(255, 203, 0, 255)
    ORANGE = Colour.new(255, 161, 0, 255)
    PINK = Colour.new(255, 109, 194, 255)
    RED = Colour.new(230, 41, 55, 255)
    MAROON = Colour.new(190, 33, 55, 255)
    GREEN = Colour.new(0, 228, 48, 255)
    LIME = Colour.new(0, 158, 47, 255)
    DARKGREEN = Colour.new(0, 117, 44, 255)
    SKYBLUE = Colour.new(102, 191, 255, 255)
    BLUE = Colour.new(0, 121, 241, 255)
    DARKBLUE = Colour.new(0, 82, 172, 255)
    PURPLE = Colour.new(200, 122, 255, 255)
    VIOLET = Colour.new(135, 60, 190, 255)
    DARKPURPLE = Colour.new(112, 31, 126, 255)
    BEIGE = Colour.new(211, 176, 131, 255)
    BROWN = Colour.new(127, 106, 79, 255)
    DARKBROWN = Colour.new(76, 63, 47, 255)

    WHITE = Colour.new(255, 255, 255, 255)
    BLACK = Colour.new(0, 0, 0, 255)
    BLANK = Colour.new(0, 0, 0, 0)
    MAGENTA = Colour.new(255, 0, 255, 255)
    RAYWHITE = Colour.new(245, 245, 245, 255)

    GAMEPAD_BUTTON_UNKNOWN = 0

    # This is normally a DPAD
    GAMEPAD_BUTTON_LEFT_FACE_UP = 1
    GAMEPAD_BUTTON_LEFT_FACE_RIGHT = 2
    GAMEPAD_BUTTON_LEFT_FACE_DOWN = 3
    GAMEPAD_BUTTON_LEFT_FACE_LEFT = 4

    # This normally corresponds with PlayStation and Xbox controllers
    # XBOX: [Y,X,A,B]
    # PS3: [Triangle,Square,Cross,Circle]
    # No support for 6 button controllers though..
    GAMEPAD_BUTTON_RIGHT_FACE_UP = 5
    GAMEPAD_BUTTON_RIGHT_FACE_RIGHT = 6
    GAMEPAD_BUTTON_RIGHT_FACE_DOWN = 7
    GAMEPAD_BUTTON_RIGHT_FACE_LEFT = 8

    # Triggers
    GAMEPAD_BUTTON_LEFT_TRIGGER_1 = 9
    GAMEPAD_BUTTON_LEFT_TRIGGER_2 = 10
    GAMEPAD_BUTTON_RIGHT_TRIGGER_1 = 11
    GAMEPAD_BUTTON_RIGHT_TRIGGER_2 = 12

    # These are buttons in the center of the gamepad
    GAMEPAD_BUTTON_MIDDLE_LEFT = 13     # PS3 Select
    GAMEPAD_BUTTON_MIDDLE = 14          # PS Button/XBOX Button
    GAMEPAD_BUTTON_MIDDLE_RIGHT = 15    # PS3 Start

    # These are the joystick press in buttons
    GAMEPAD_BUTTON_LEFT_THUMB = 16
    GAMEPAD_BUTTON_RIGHT_THUM = 17

    # Left stick
    GAMEPAD_AXIS_LEFT_X = 0
    GAMEPAD_AXIS_LEFT_Y = 1

    # Right stick
    GAMEPAD_AXIS_RIGHT_X = 2
    GAMEPAD_AXIS_RIGHT_Y = 3

    # Pressure levels for the back triggers
    GAMEPAD_AXIS_LEFT_TRIGGER = 4       # [1..-1] (pressure-level)
    GAMEPAD_AXIS_RIGHT_TRIGGER = 5      # [1..-1] (pressure-level)

    KEY_RIGHT = 262
    KEY_LEFT = 263
    KEY_DOWN = 264
    KEY_UP = 265
    KEY_BACKSPACE = 259
    KEY_ENTER = 257

    MOUSE_LEFT_BUTTON = 0
    MOUSE_RIGHT_BUTTON = 1
    MOUSE_MIDDLE_BUTTON = 2
  )");
  mrb_load_file(mrb, game_file);
  /*
  mrb_load_string(mrb, R"(
      init_window(100, 100, 'hello')
      set_target_fps(144)

      colour = Colour.new(0, 0, 0 ,255)
      red = Colour.new(255, 0 ,0, 255)

      until window_should_close?
        delta = get_frame_time
        begin_drawing
        clear_background(colour)
        draw_rectangle(50, 50, 25, 25, red)
        draw_fps(10, 10)
        end_drawing
      end
    )");
    */
  //mrb_load_irep(mrb, game);

  if (mrb->exc) {
    mrb_print_backtrace(mrb);
    return 1;
  }

  mrb_close(mrb);

  return 0;
}
