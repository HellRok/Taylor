#include "mruby.h"
#include "mruby/array.h"

void populate_argv(mrb_state* mrb, int argc, char** argv)
{
  mrb_value ARGV;
  ARGV = mrb_ary_new_capa(mrb, argc);

  for (int i = 0; i < argc; i++) {
    mrb_ary_push(mrb, ARGV, mrb_str_new_cstr(mrb, argv[i]));
  }

  mrb_define_global_const(mrb, "ARGV", ARGV);
}
