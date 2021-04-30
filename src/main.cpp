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

    # Alphanumeric keys
    KEY_APOSTROPHE      = 39
    KEY_COMMA           = 44
    KEY_MINUS           = 45
    KEY_PERIOD          = 46
    KEY_SLASH           = 47
    KEY_ZERO            = 48
    KEY_ONE             = 49
    KEY_TWO             = 50
    KEY_THREE           = 51
    KEY_FOUR            = 52
    KEY_FIVE            = 53
    KEY_SIX             = 54
    KEY_SEVEN           = 55
    KEY_EIGHT           = 56
    KEY_NINE            = 57
    KEY_SEMICOLON       = 59
    KEY_EQUAL           = 61
    KEY_A               = 65
    KEY_B               = 66
    KEY_C               = 67
    KEY_D               = 68
    KEY_E               = 69
    KEY_F               = 70
    KEY_G               = 71
    KEY_H               = 72
    KEY_I               = 73
    KEY_J               = 74
    KEY_K               = 75
    KEY_L               = 76
    KEY_M               = 77
    KEY_N               = 78
    KEY_O               = 79
    KEY_P               = 80
    KEY_Q               = 81
    KEY_R               = 82
    KEY_S               = 83
    KEY_T               = 84
    KEY_U               = 85
    KEY_V               = 86
    KEY_W               = 87
    KEY_X               = 88
    KEY_Y               = 89
    KEY_Z               = 90

    # Function keys
    KEY_SPACE           = 32
    KEY_ESCAPE          = 256
    KEY_ENTER           = 257
    KEY_TAB             = 258
    KEY_BACKSPACE       = 259
    KEY_INSERT          = 260
    KEY_DELETE          = 261
    KEY_RIGHT           = 262
    KEY_LEFT            = 263
    KEY_DOWN            = 264
    KEY_UP              = 265
    KEY_PAGE_UP         = 266
    KEY_PAGE_DOWN       = 267
    KEY_HOME            = 268
    KEY_END             = 269
    KEY_CAPS_LOCK       = 280
    KEY_SCROLL_LOCK     = 281
    KEY_NUM_LOCK        = 282
    KEY_PRINT_SCREEN    = 283
    KEY_PAUSE           = 284
    KEY_F1              = 290
    KEY_F2              = 291
    KEY_F3              = 292
    KEY_F4              = 293
    KEY_F5              = 294
    KEY_F6              = 295
    KEY_F7              = 296
    KEY_F8              = 297
    KEY_F9              = 298
    KEY_F10             = 299
    KEY_F11             = 300
    KEY_F12             = 301
    KEY_LEFT_SHIFT      = 340
    KEY_LEFT_CONTROL    = 341
    KEY_LEFT_ALT        = 342
    KEY_LEFT_SUPER      = 343
    KEY_RIGHT_SHIFT     = 344
    KEY_RIGHT_CONTROL   = 345
    KEY_RIGHT_ALT       = 346
    KEY_RIGHT_SUPER     = 347
    KEY_KB_MENU         = 348
    KEY_LEFT_BRACKET    = 91
    KEY_BACKSLASH       = 92
    KEY_RIGHT_BRACKET   = 93
    KEY_GRAVE           = 96

    # Keypad keys
    KEY_KP_0            = 32
    KEY_KP_1            = 32
    KEY_KP_2            = 32
    KEY_KP_3            = 32
    KEY_KP_4            = 32
    KEY_KP_5            = 32
    KEY_KP_6            = 32
    KEY_KP_7            = 32
    KEY_KP_8            = 32
    KEY_KP_9            = 32
    KEY_KP_DECIMAL      = 33
    KEY_KP_DIVIDE       = 33
    KEY_KP_MULTIPLY     = 33
    KEY_KP_SUBTRACT     = 33
    KEY_KP_ADD          = 33
    KEY_KP_ENTER        = 33
    KEY_KP_EQUAL        = 336

    MOUSE_LEFT_BUTTON = 0
    MOUSE_RIGHT_BUTTON = 1
    MOUSE_MIDDLE_BUTTON = 2

    GESTURE_NONE        = 0
    GESTURE_TAP         = 1
    GESTURE_DOUBLETAP   = 2
    GESTURE_HOLD        = 4
    GESTURE_DRAG        = 8
    GESTURE_SWIPE_RIGHT = 16
    GESTURE_SWIPE_LEFT  = 32
    GESTURE_SWIPE_UP    = 64
    GESTURE_SWIPE_DOWN  = 128
    GESTURE_PINCH_IN    = 256
    GESTURE_PINCH_OUT   = 512
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
