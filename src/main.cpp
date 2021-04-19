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
