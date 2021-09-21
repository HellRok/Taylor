#include "version.hpp"

#include "raylib.h"

#include "raygui.hpp"
#include "mruby.h"
#include "mruby/data.h"
#include "mruby/class.h"
#include "mruby/compile.h"
#include "mruby/irep.h"

#ifdef __EMSCRIPTEN__
#include "web.hpp"
#endif

#include "argv.hpp"
#include "platform.hpp"
#include "mruby_integration/audio.hpp"
#include "mruby_integration/core.hpp"
#include "mruby_integration/shapes.hpp"
#include "mruby_integration/structs.hpp"
#include "mruby_integration/text.hpp"
#include "mruby_integration/textures.hpp"

#ifdef EXPORT
#include "game.h"
#endif

#ifdef _WIN32
#include <windef.h>
#include <winbase.h>
#include <wincon.h>
#endif

int main(int argc, char **argv) {
#ifdef _WIN32
  // This allows us to write to a cmd.exe or powershell if we were run from
  // one, but otherwise don't open another window.
  if (AttachConsole(ATTACH_PARENT_PROCESS)) {
    freopen("CONIN$", "r", stdin);
    freopen("CONOUT$", "w", stdout);
    freopen("CONOUT$", "w", stderr);
  }
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
  append_shapes(mrb);
  append_structs(mrb);
  append_text(mrb);
  append_textures(mrb);

  append_platform(mrb);

#ifdef __EMSCRIPTEN__
  append_web(mrb);
#endif

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
