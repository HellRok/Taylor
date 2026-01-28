#include "mruby.h"

#include "taylor/platform.hpp"
#include "taylor/raylib.hpp"

auto mrb_taylor_released(mrb_state*, mrb_value) -> mrb_value
{
#ifdef EXPORT
  return mrb_true_value();
#else
  return mrb_false_value();
#endif
}

void append_taylor(mrb_state* mrb)
{
  struct RClass* Taylor_module = mrb_define_module(mrb, "Taylor");

  mrb_define_class_method(mrb, Taylor_module, "released?", mrb_taylor_released, MRB_ARGS_NONE());

  append_taylor_platform(mrb, Taylor_module);
  append_taylor_raylib(mrb, Taylor_module);
}
