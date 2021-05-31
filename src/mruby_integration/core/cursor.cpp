#include "raylib.h"
#include "mruby.h"

#include "mruby_integration/struct_types.hpp"

mrb_value mrb_show_cursor(mrb_state*, mrb_value) {
  ShowCursor();
  return mrb_nil_value();
}

mrb_value mrb_hide_cursor(mrb_state*, mrb_value) {
  HideCursor();
  return mrb_nil_value();
}

void append_core_cursor(mrb_state *mrb) {
  mrb_define_method(mrb, mrb->kernel_module, "show_cursor", mrb_show_cursor, MRB_ARGS_NONE());
  mrb_define_method(mrb, mrb->kernel_module, "hide_cursor", mrb_hide_cursor, MRB_ARGS_NONE());
}