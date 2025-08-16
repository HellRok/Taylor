#include "mruby.h"
#include "raylib.h"

auto
mrb_set_config_flags(mrb_state* mrb, mrb_value) -> mrb_value
{
  mrb_int flags;
  mrb_get_args(mrb, "i", &flags);

  SetConfigFlags(flags);
  return mrb_nil_value();
}

auto
mrb_open_url(mrb_state* mrb, mrb_value) -> mrb_value
{
  char* url;
  mrb_get_args(mrb, "z", &url);

  OpenURL(url);
  return mrb_nil_value();
}

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
                    "set_config_flags",
                    mrb_set_config_flags,
                    MRB_ARGS_REQ(1));
  mrb_define_method(
    mrb, mrb->kernel_module, "open_url", mrb_open_url, MRB_ARGS_REQ(1));
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
