#include "version.hpp"

#include "raylib.h"

#include "mruby.h"
#include "mruby/data.h"
#include "mruby/class.h"
#include "mruby/compile.h"
#include "mruby/irep.h"

#ifdef __EMSCRIPTEN__
#include "web.hpp"
#include "platform_specific/web.hpp"
#endif

#include "argv.hpp"
#include "platform.hpp"
#include "workarounds/mingw.hpp"
#include "workarounds/simplehttp.hpp"
#include "mruby_integration/audio.hpp"
#include "mruby_integration/core.hpp"
#include "mruby_integration/images.hpp"
#include "mruby_integration/shapes.hpp"
#include "mruby_integration/structs.hpp"
#include "mruby_integration/text.hpp"
#include "mruby_integration/textures.hpp"

#ifdef EXPORT
#include "game.h"
#endif


int main(int argc, char **argv) {
#ifdef _WIN32
  workarounds_mingw_attach_console();
#endif

  const char *path;
#ifndef EXPORT
  if (argv) {
    path = argv[1];
  } else {
    path = "./game.rb";
  }
#endif
#ifdef EXPORT
  path = argv[0];
#endif

  mrb_state *mrb = mrb_open();

  mrb_define_const(mrb, mrb->kernel_module, "TAYLOR_VERSION", mrb_str_new_cstr(mrb, VERSION));
  mrb_define_const(mrb, mrb->kernel_module, "WORKING_DIRECTORY", mrb_str_new_cstr(mrb, GetWorkingDirectory()));
  populate_argv(mrb, argc, argv);

  append_audio(mrb);
  append_core(mrb);
  append_images(mrb);
  append_shapes(mrb);
  append_structs(mrb);
  append_text(mrb);
  append_textures(mrb);

  append_platform(mrb);

#ifdef __EMSCRIPTEN__
  append_web(mrb);
  append_platform_specific_web(mrb);
#endif

#ifdef _WIN32
  workarounds_mingw_msg_dontwait(mrb);
#endif

  workarounds_simplehttp(mrb);

#ifndef EXPORT
  FILE *game_file = fopen(path, "r");
  ChangeDirectory(GetDirectoryPath(path));
  mrb_load_file(mrb, game_file);
#endif

#ifdef EXPORT
  ChangeDirectory(GetDirectoryPath(path));
  mrb_load_irep(mrb, game);
#endif

  if (mrb->exc) {
    mrb_print_error(mrb);
    return 1;
  }

  mrb_close(mrb);

  return 0;
}
