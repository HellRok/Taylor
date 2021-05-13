#include "raylib.h"
#include "raygui.hpp"
#include "mruby.h"
#include "mruby/data.h"
#include "mruby/class.h"
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
  mrb_load_file(mrb, game_file);

  if (mrb->exc) {
    mrb_print_backtrace(mrb);
    return 1;
  }

  mrb_close(mrb);

  return 0;
}
