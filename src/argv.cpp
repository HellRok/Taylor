#include "mruby.h"
#include "mruby/array.h"

void
populate_argv(mrb_state* mrb, int argc, char** argv)
{
  mrb_value ARGV;
  ARGV = mrb_ary_new_capa(mrb, argc);

  // So basically ARGV in ruby and ARGV in c++ are a bit different. In c++ it
  // includes the name of the executable (eg: taylor) and ruby does not, so we
  // drop the first argument when populating ruby (or second if we aren't
  // exporting since that's the name of the script running)
#ifndef EXPORT
  for (int i = 2; i < argc; i++) {
#endif
#ifdef EXPORT
    for (int i = 1; i < argc; i++) {
#endif
      mrb_ary_push(mrb, ARGV, mrb_str_new_cstr(mrb, argv[i]));
    }

    mrb_define_global_const(mrb, "ARGV", ARGV);
  }
