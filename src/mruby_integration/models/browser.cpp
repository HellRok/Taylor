#include "mruby.h"
#include "mruby/class.h"
#include "raylib.h"

struct RClass* Browser_class;

auto
mrb_Browser_open(mrb_state* mrb, mrb_value) -> mrb_value
{
  const char* url;
  mrb_get_args(mrb, "z", &url);

  OpenURL(url);
  return mrb_nil_value();
}

void
append_models_Browser(mrb_state* mrb)
{
  Browser_class = mrb_define_module(mrb, "Browser");
  mrb_define_class_method(
    mrb, Browser_class, "open", mrb_Browser_open, MRB_ARGS_REQ(1));
}
