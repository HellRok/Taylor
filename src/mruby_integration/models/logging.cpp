#include "mruby.h"
#include "mruby/class.h"
#include "mruby/variable.h"
#include "raylib.h"

#include "ruby/models/logging.hpp"

struct RClass* Logging_class;

auto
mrb_Logging_set_level(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int level;
  mrb_get_args(mrb, "i", &level);

  if (level < 0 || level > 7) {
    mrb_raise(mrb, E_ARGUMENT_ERROR, "Logging level must be within (0..7)");
  }

  mrb_mod_cv_set(mrb,
                 Logging_class,
                 mrb_intern_cstr(mrb, "@@level"),
                 mrb_int_value(mrb, level));

  SetTraceLogLevel(level);
  return mrb_nil_value();
}

auto
mrb_Logging_log(mrb_state* mrb, mrb_value) -> mrb_value
{
  // def self.log(level: Logging::INFO, message:)
  const mrb_int kw_num = 2;
  const mrb_int kw_required = 1;
  const mrb_sym kw_names[] = { mrb_intern_lit(mrb, "message"),
                               mrb_intern_lit(mrb, "level") };
  mrb_value kw_values[kw_num];
  mrb_kwargs kwargs = { kw_num, kw_required, kw_names, kw_values, nullptr };
  mrb_get_args(mrb, ":", &kwargs);

  const char* message;
  if (mrb_undef_p(kw_values[0])) {
    // clang-tidy doesn't know this path can't be hit because of how kwargs
    // works, so let's just return early just in case clang-tidy is right.
    return mrb_nil_value();
  } else {
    mrb_sym sym = mrb_obj_to_sym(mrb, kw_values[0]);
    message = mrb_sym_name(mrb, sym);
  }

  int level = 3;
  if (!mrb_undef_p(kw_values[1])) {
    level = mrb_as_int(mrb, kw_values[1]);
  }

  if (level < 0 || level > 7) {
    mrb_raise(mrb, E_ARGUMENT_ERROR, "Logging level must be within (0..7)");
  }

  TraceLog(level, message);
  return mrb_nil_value();
}

void
append_models_Logging(mrb_state* mrb)
{
  Logging_class = mrb_define_module(mrb, "Logging");
  mrb_define_class_method(
    mrb, Logging_class, "level=", mrb_Logging_set_level, MRB_ARGS_REQ(1));
  mrb_define_class_method(
    mrb, Logging_class, "log", mrb_Logging_log, MRB_ARGS_REQ(1));

  load_ruby_models_logging(mrb);
}
