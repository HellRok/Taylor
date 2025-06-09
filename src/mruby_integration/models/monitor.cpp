#include "mruby.h"
#include "raylib.h"

#include "mruby_integration/exceptions.hpp"
#include "mruby_integration/models/window.hpp"

#include "ruby/models/monitor.hpp"

struct RClass* Monitor_class;

auto
mrb_Monitor_count(mrb_state* mrb, mrb_value) -> mrb_value
{
  EXIT_UNLESS_WINDOW_READY("You must call Window.open before Monitor.count")

  return mrb_int_value(mrb, GetMonitorCount());
}

void
append_models_Monitor(mrb_state* mrb)
{
  Monitor_class = mrb_define_module(mrb, "Monitor");
  mrb_define_class_method(
    mrb, Monitor_class, "count", mrb_Monitor_count, MRB_ARGS_NONE());

  load_ruby_models_monitor(mrb);
}
