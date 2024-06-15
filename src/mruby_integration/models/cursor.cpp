#include "mruby.h"
#include "mruby/class.h"
#include "mruby/data.h"
#include "raylib.h"

#include "mruby_integration/struct_types.hpp"

struct RClass* Cursor_class;

bool cursor_currently_enabled = true;

auto
mrb_cursor_show(mrb_state*, mrb_value) -> mrb_value
{
  ShowCursor();
  return mrb_nil_value();
}

auto
mrb_cursor_hide(mrb_state*, mrb_value) -> mrb_value
{
  HideCursor();
  return mrb_nil_value();
}

auto
mrb_cursor_hidden(mrb_state*, mrb_value) -> mrb_value
{
  return mrb_bool_value(IsCursorHidden());
}

auto
mrb_cursor_enable(mrb_state*, mrb_value) -> mrb_value
{
  EnableCursor();
  cursor_currently_enabled = true;
  return mrb_nil_value();
}

auto
mrb_cursor_disable(mrb_state*, mrb_value) -> mrb_value
{
  DisableCursor();
  cursor_currently_enabled = false;
  return mrb_nil_value();
}

auto
mrb_cursor_disabled(mrb_state*, mrb_value) -> mrb_value
{
  return mrb_bool_value(!cursor_currently_enabled);
}

void
append_models_Cursor(mrb_state* mrb)
{
  Cursor_class = mrb_define_class(mrb, "Cursor", mrb->object_class);
  MRB_SET_INSTANCE_TT(Cursor_class, MRB_TT_DATA);

  mrb_define_class_method(
    mrb, Cursor_class, "show", mrb_cursor_show, MRB_ARGS_NONE());
  mrb_define_class_method(
    mrb, Cursor_class, "hide", mrb_cursor_hide, MRB_ARGS_NONE());
  mrb_define_class_method(
    mrb, Cursor_class, "hidden?", mrb_cursor_hidden, MRB_ARGS_NONE());
  mrb_define_class_method(
    mrb, Cursor_class, "enable", mrb_cursor_enable, MRB_ARGS_NONE());
  mrb_define_class_method(
    mrb, Cursor_class, "disable", mrb_cursor_disable, MRB_ARGS_NONE());
  mrb_define_class_method(
    mrb, Cursor_class, "disabled?", mrb_cursor_disabled, MRB_ARGS_NONE());
}
