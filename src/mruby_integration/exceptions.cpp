#include "mruby.h"
#include "mruby/class.h"
#include "mruby/variable.h"

auto
mrb_exc_get_module_id(mrb_state* mrb, RClass* klass) -> RClass*
{
  struct RClass *exc, *e;
  mrb_value c =
    mrb_const_get(mrb, mrb_obj_value(klass), mrb_intern_lit(mrb, "NotFound"));

  if (!mrb_class_p(c)) {
    mrb_raise(mrb, mrb->eException_class, "exception corrupted");
  }
  exc = e = mrb_class_ptr(c);

  while (e) {
    if (e == mrb->eException_class) {
      return exc;
    }
    e = e->super;
  }

  return mrb->eException_class;
}

void
raise_not_found_error(mrb_state* mrb, RClass* klass)
{
  mrb_raise(mrb, mrb_exc_get_module_id(mrb, klass), "File not found");
}
