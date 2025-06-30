#include "mruby.h"
#include "mruby/data.h"
#include <unordered_map>

struct RClass* ReferenceCounter_class;
std::unordered_map<void*, int> references{};

auto
reference_count(void* p) -> int
{
  if (references.count(p) == 0) {
    return 0;
  } else {
    return references[p];
  }
}

void
add_reference(void* p)
{
  references[p]++;
}

int last_size = 0;

void
free_klass(mrb_state* mrb, void* p)
{
  if (reference_count(p) > 0) {
    int count = --references[p];
    if (count == 0) {
      references.erase(p);
    }
  } else {
    mrb_free(mrb, p);
  }
};

#define add_type(object) mrb_data_type object##_type = { #object, free_klass };

add_type(Camera2D);
add_type(Circle);
add_type(Color);
add_type(Font);
add_type(Gamepad);
add_type(Image);
add_type(Line);
add_type(Monitor);
add_type(Music);
add_type(Rectangle);
add_type(Rektangle);
add_type(RenderTexture);
add_type(Shader);
add_type(Sound);
add_type(Texture2D);
add_type(Vector2);

auto
mrb_ReferenceCounter_reference_count(mrb_state* mrb, mrb_value self)
  -> mrb_value
{
  void* instance = DATA_PTR(self);
  return mrb_int_value(mrb, reference_count(instance));
}

auto
mrb_ReferenceCounter_tracked_objects_count(mrb_state* mrb, mrb_value)
  -> mrb_value
{
  return mrb_int_value(mrb, references.size());
}

void
append_module_ReferenceCounter(mrb_state* mrb)
{
  ReferenceCounter_class = mrb_define_module(mrb, "ReferenceCounter");
  mrb_define_class_method(mrb,
                          ReferenceCounter_class,
                          "tracked_objects_count",
                          mrb_ReferenceCounter_tracked_objects_count,
                          MRB_ARGS_NONE());
  mrb_define_method(mrb,
                    ReferenceCounter_class,
                    "reference_count",
                    mrb_ReferenceCounter_reference_count,
                    MRB_ARGS_NONE());
}
