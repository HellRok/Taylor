#include "raylib.h"
#include "mruby.h"

mrb_value mrb_set_config_flags(mrb_state *mrb, mrb_value) {
  mrb_int flags;
  mrb_get_args(mrb, "i", &flags);

  SetConfigFlags(flags);
  return mrb_nil_value();
}

mrb_value mrb_set_trace_log_level(mrb_state *mrb, mrb_value) {
  mrb_int level;
  mrb_get_args(mrb, "i", &level);

  SetTraceLogLevel(level);
  return mrb_nil_value();
}

void append_core_misc(mrb_state *mrb) {
  mrb_define_method(mrb, mrb->kernel_module, "set_config_flags", mrb_set_config_flags, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "set_trace_log_level", mrb_set_trace_log_level, MRB_ARGS_REQ(1));
}
