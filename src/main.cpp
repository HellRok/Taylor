#include "version.hpp"

#include "raylib.h"
#include "raygui.hpp"
#include "mruby.h"
#include "mruby/data.h"
#include "mruby/class.h"
#include "mruby/compile.h"
#include "mruby/irep.h"

#include "argv.hpp"
#include "mruby_integration/audio.hpp"
#include "mruby_integration/core.hpp"
#include "mruby_integration/shapes.hpp"
#include "mruby_integration/structs.hpp"
#include "mruby_integration/text.hpp"
#include "mruby_integration/textures.hpp"

#ifdef EXPORT
#include "game.h"
#endif

int main(int argc, char **argv) {
#ifndef EXPORT
  const char *path;
  if (argv) {
    path = argv[1];
  } else {
    path = "./game.rb";
  }
#endif

  mrb_state *mrb = mrb_open();

  mrb_define_const(mrb, mrb->kernel_module, "TAYLOR_VERSION", mrb_str_new_cstr(mrb, VERSION));
  populate_argv(mrb, argc, argv);

  append_audio(mrb);
  append_core(mrb);
  append_shapes(mrb);
  append_structs(mrb);
  append_text(mrb);
  append_textures(mrb);

#ifndef EXPORT
  FILE *game_file = fopen(path, "r");

  ChangeDirectory(GetDirectoryPath(path));

  mrb_load_file(mrb, game_file);
#endif

#ifdef EXPORT
  mrb_load_irep(mrb, game);
#endif

  if (mrb->exc) {
    mrb_print_error(mrb);
    return 1;
  }

  mrb_close(mrb);

  return 0;
}
