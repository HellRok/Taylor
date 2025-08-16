#include "mruby.h"
#include "raylib.h"

auto
mrb_set_clipboard_text(mrb_state* mrb, mrb_value) -> mrb_value
{
  char* text;
  mrb_get_args(mrb, "z", &text);

  SetClipboardText(text);
  return mrb_nil_value();
}

auto
mrb_get_clipboard_text(mrb_state* mrb, mrb_value) -> mrb_value
{
  const char* name = GetClipboardText();
  return mrb_str_new_cstr(mrb, name);
}

void
append_core_misc(mrb_state* mrb)
{
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "set_clipboard_text",
                    mrb_set_clipboard_text,
                    MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "get_clipboard_text",
                    mrb_get_clipboard_text,
                    MRB_ARGS_NONE());
}
