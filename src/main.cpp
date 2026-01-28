#include "version.hpp"

#include "mruby.h"
#include "mruby/class.h"
#include "mruby/compile.h"
#include "mruby/data.h"
#include "mruby/irep.h"

#include "argv.hpp"
#include "mruby_integration/models.hpp"
#include "mruby_integration/struct_types.hpp"
#include "taylor.hpp"
#include "workarounds/mingw.hpp"

#ifdef EXPORT
#include "game.h"
#endif

auto main(int argc, char** argv) -> int
{
#ifdef _WIN32
  workarounds_mingw_attach_console();
#endif

  mrb_state* mrb = mrb_open();

  mrb_define_const(mrb, mrb->kernel_module, "TAYLOR_VERSION", mrb_str_new_cstr(mrb, VERSION));
  populate_argv(mrb, argc, argv);

  append_models(mrb);
  append_module_ReferenceCounter(mrb);

  append_taylor(mrb);

#ifdef _WIN32
  workarounds_mingw_msg_dontwait(mrb);
#endif

#ifdef EXPORT
  mrb_load_string(mrb, "Dir.chdir(File.dirname(ARGV.shift))");
  mrb_load_irep(mrb, game);

#else
  if (argc < 1) {
    exit(1);
  }
  FILE* game_file = fopen(argv[1], "re");
  mrb_load_string(mrb, "ARGV.shift");
  mrb_load_file(mrb, game_file);
#endif

  if (mrb->exc) {
    mrb_print_error(mrb);
    return 1;
  }

  mrb_close(mrb);

  return 0;
}
