#include "mruby.h"
#include "raylib.h"

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
                    "get_clipboard_text",
                    mrb_get_clipboard_text,
                    MRB_ARGS_NONE());
}
