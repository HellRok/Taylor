#include "version.hpp"

#include "raylib.h"

#include "mruby.h"
#include "mruby/class.h"
#include "mruby/compile.h"
#include "mruby/data.h"
#include "mruby/irep.h"

#include "argv.hpp"
#include "mruby_integration/core.hpp"
#include "mruby_integration/images.hpp"
#include "mruby_integration/models.hpp"
#include "mruby_integration/shaders.hpp"
#include "mruby_integration/shapes.hpp"
#include "mruby_integration/text.hpp"
#include "mruby_integration/textures.hpp"
#include "platform.hpp"
#include "platform_specific/web.hpp"
#include "web.hpp"
#include "workarounds/mingw.hpp"

#ifdef EXPORT
#include "game.h"
#endif

auto
main(int argc, char** argv) -> int
{
#ifdef _WIN32
  workarounds_mingw_attach_console();
#endif

  const char* path;
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

  mrb_state* mrb = mrb_open();

  mrb_define_const(
    mrb, mrb->kernel_module, "TAYLOR_VERSION", mrb_str_new_cstr(mrb, VERSION));
  mrb_define_const(mrb,
                   mrb->kernel_module,
                   "WORKING_DIRECTORY",
                   mrb_str_new_cstr(mrb, GetWorkingDirectory()));
  populate_argv(mrb, argc, argv);

  append_core(mrb);
  append_images(mrb);
  append_models(mrb);
  append_shaders(mrb);
  append_shapes(mrb);
  append_text(mrb);
  append_textures(mrb);

  append_platform(mrb);

  append_web(mrb);
  append_platform_specific_web(mrb);

#ifdef _WIN32
  workarounds_mingw_msg_dontwait(mrb);
#endif

#ifndef EXPORT
  FILE* game_file = fopen(path, "re");
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
