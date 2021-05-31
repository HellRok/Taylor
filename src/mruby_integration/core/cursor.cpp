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

mrb_value mrb_is_cursor_hidden(mrb_state*, mrb_value) {
  return mrb_bool_value(IsCursorHidden());
}

mrb_value mrb_enable_cursor(mrb_state*, mrb_value) {
  EnableCursor();
  return mrb_nil_value();
}

mrb_value mrb_disable_cursor(mrb_state*, mrb_value) {
  DisableCursor();
  return mrb_nil_value();
}

void append_core_cursor(mrb_state *mrb) {
  mrb_define_method(mrb, mrb->kernel_module, "show_cursor", mrb_show_cursor, MRB_ARGS_NONE());
  mrb_define_method(mrb, mrb->kernel_module, "hide_cursor", mrb_hide_cursor, MRB_ARGS_NONE());
  mrb_define_method(mrb, mrb->kernel_module, "is_cursor_hidden?", mrb_is_cursor_hidden, MRB_ARGS_NONE());
  mrb_define_method(mrb, mrb->kernel_module, "enable_cursor", mrb_enable_cursor, MRB_ARGS_NONE());
  mrb_define_method(mrb, mrb->kernel_module, "disable_cursor", mrb_disable_cursor, MRB_ARGS_NONE());
}
