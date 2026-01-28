#include "mruby.h"
#include "mruby/array.h"
#include "mruby/class.h"
#include "raylib.h"

struct RClass* DroppedFiles_class;

auto mrb_DroppedFiles_any(mrb_state*, mrb_value) -> mrb_value
{
  return mrb_bool_value(IsFileDropped());
}

auto mrb_DroppedFiles_all(mrb_state* mrb, mrb_value) -> mrb_value
{
  FilePathList droppedFiles;
  droppedFiles = LoadDroppedFiles();

  mrb_value return_array = mrb_ary_new(mrb);
  for (int i = 0; i < droppedFiles.count; i++) {
    mrb_ary_push(mrb, return_array, mrb_str_new_cstr(mrb, droppedFiles.paths[i]));
  }

  UnloadDroppedFiles(droppedFiles);

  return return_array;
}

void append_models_DroppedFiles(mrb_state* mrb)
{
  DroppedFiles_class = mrb_define_class(mrb, "DroppedFiles", mrb->object_class);
  MRB_SET_INSTANCE_TT(DroppedFiles_class, MRB_TT_DATA);

  mrb_define_class_method(mrb, DroppedFiles_class, "any?", mrb_DroppedFiles_any, MRB_ARGS_NONE());
  mrb_define_class_method(mrb, DroppedFiles_class, "all", mrb_DroppedFiles_all, MRB_ARGS_NONE());
}
