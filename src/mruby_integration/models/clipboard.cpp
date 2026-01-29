#include "mruby.h"
#include "mruby/class.h"
#include "raylib.h"

struct RClass* Clipboard_class;

auto mrb_Clipboard_set_text(mrb_state* mrb, mrb_value) -> mrb_value
{
  const char* text;
  mrb_get_args(mrb, "z", &text);

  SetClipboardText(text);

  return mrb_nil_value();
}

auto mrb_Clipboard_text(mrb_state* mrb, mrb_value) -> mrb_value
{
  const char* name = GetClipboardText();
  return mrb_str_new_cstr(mrb, name);
}

void append_models_Clipboard(mrb_state* mrb)
{
  Clipboard_class = mrb_define_module(mrb, "Clipboard");
  mrb_define_class_method(mrb, Clipboard_class, "text=", mrb_Clipboard_set_text, MRB_ARGS_REQ(1));
  mrb_define_class_method(mrb, Clipboard_class, "text", mrb_Clipboard_text, MRB_ARGS_NONE());
}
