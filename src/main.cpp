#include "raylib.h"
#include "raygui.hpp"
#include "mruby.h"
#include "mruby/data.h"
#include "mruby/class.h"
#include "mruby/irep.h"
#include "mruby/compile.h"

#include "mruby_integration/structs.hpp"
#include "mruby_integration/core.hpp"
#include "mruby_integration/text.hpp"
#include "mruby_integration/shapes.hpp"

int main(void)
{
  mrb_state *mrb = mrb_open();

  appendStructs(mrb);
  appendCore(mrb);
  appendText(mrb);
  appendShapes(mrb);

  FILE *game_file = fopen("app/game.rb", "r");
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
