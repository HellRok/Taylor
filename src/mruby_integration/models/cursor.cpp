#include "mruby.h"
#include "mruby/class.h"
#include "mruby/data.h"
#include "raylib.h"

#include "mruby_integration/struct_types.hpp"
#include "ruby/models/cursor.hpp"

struct RClass* Cursor_class;

bool cursor_currently_enabled = true;
int cursor_icon = 0;

auto mrb_Cursor_show(mrb_state*, mrb_value) -> mrb_value
{
  ShowCursor();
  return mrb_nil_value();
}

auto mrb_Cursor_hide(mrb_state*, mrb_value) -> mrb_value
{
  HideCursor();
  return mrb_nil_value();
}

auto mrb_Cursor_hidden(mrb_state*, mrb_value) -> mrb_value
{
  return mrb_bool_value(IsCursorHidden());
}

auto mrb_Cursor_enable(mrb_state*, mrb_value) -> mrb_value
{
  EnableCursor();
  cursor_currently_enabled = true;
  return mrb_nil_value();
}

auto mrb_Cursor_disable(mrb_state*, mrb_value) -> mrb_value
{
  DisableCursor();
  cursor_currently_enabled = false;
  return mrb_nil_value();
}

auto mrb_Cursor_disabled(mrb_state*, mrb_value) -> mrb_value
{
  return mrb_bool_value(!cursor_currently_enabled);
}

auto mrb_Cursor_on_screen(mrb_state*, mrb_value) -> mrb_value
{
  return mrb_bool_value(IsCursorOnScreen());
}

auto mrb_Cursor_icon(mrb_state* mrb, mrb_value) -> mrb_value
{
  return mrb_int_value(mrb, cursor_icon);
}
auto

mrb_Cursor_set_icon(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int icon;
  mrb_get_args(mrb, "i", &icon);

  if (icon < 0 || icon > 10) {
    mrb_raise(mrb, E_ARGUMENT_ERROR, "Must be within (0..10)");
  }

  SetMouseCursor(icon);
  cursor_icon = icon;

  return mrb_nil_value();
}

void append_models_Cursor(mrb_state* mrb)
{
  Cursor_class = mrb_define_class(mrb, "Cursor", mrb->object_class);
  MRB_SET_INSTANCE_TT(Cursor_class, MRB_TT_DATA);

  mrb_define_class_method(mrb, Cursor_class, "show", mrb_Cursor_show, MRB_ARGS_NONE());
  mrb_define_class_method(mrb, Cursor_class, "hide", mrb_Cursor_hide, MRB_ARGS_NONE());
  mrb_define_class_method(mrb, Cursor_class, "hidden?", mrb_Cursor_hidden, MRB_ARGS_NONE());
  mrb_define_class_method(mrb, Cursor_class, "enable", mrb_Cursor_enable, MRB_ARGS_NONE());
  mrb_define_class_method(mrb, Cursor_class, "disable", mrb_Cursor_disable, MRB_ARGS_NONE());
  mrb_define_class_method(mrb, Cursor_class, "disabled?", mrb_Cursor_disabled, MRB_ARGS_NONE());
  mrb_define_class_method(mrb, Cursor_class, "on_screen?", mrb_Cursor_on_screen, MRB_ARGS_NONE());
  mrb_define_class_method(mrb, Cursor_class, "icon", mrb_Cursor_icon, MRB_ARGS_NONE());
  mrb_define_class_method(mrb, Cursor_class, "icon=", mrb_Cursor_set_icon, MRB_ARGS_REQ(1));

  load_ruby_models_cursor(mrb);
}
