#include "raylib.h"
#include "mruby.h"

mrb_value mrb_files_dropped(mrb_state*, mrb_value) {
  return mrb_bool_value(IsFileDropped());
}

void append_core_files(mrb_state *mrb) {
  mrb_define_method(mrb, mrb->kernel_module, "files_dropped?", mrb_files_dropped, MRB_ARGS_NONE());
}
