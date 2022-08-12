#include "raylib.h"
#include "mruby.h"
#include "mruby/array.h"

mrb_value mrb_files_dropped(mrb_state*, mrb_value) {
  return mrb_bool_value(IsFileDropped());
}

mrb_value mrb_get_dropped_files(mrb_state *mrb, mrb_value) {
  FilePathList droppedFiles;
  droppedFiles = LoadDroppedFiles();

  mrb_value return_array = mrb_ary_new(mrb);
  for (unsigned int i = 0; i < droppedFiles.count; i++) {
    mrb_ary_push(mrb, return_array, mrb_str_new_cstr(mrb, droppedFiles.paths[i]));
  }

  UnloadDroppedFiles(droppedFiles);

  return return_array;
}

void append_core_files(mrb_state *mrb) {
  mrb_define_method(mrb, mrb->kernel_module, "files_dropped?", mrb_files_dropped, MRB_ARGS_NONE());
  mrb_define_method(mrb, mrb->kernel_module, "get_dropped_files", mrb_get_dropped_files, MRB_ARGS_NONE());
}
