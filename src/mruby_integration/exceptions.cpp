#include <string>

#include "mruby.h"
#include "mruby/class.h"
#include "mruby/variable.h"

auto
mrb_exc_get_module_id(mrb_state* mrb, mrb_value c) -> RClass*
{
  struct RClass *exc, *e;

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

auto
error_from_string(mrb_state* mrb, std::string error) -> mrb_sym
{
  // We have this kind of dodgy method because `mrb_intern_lit` is a macro that
  // can't expand with anything other than a quoted string.
  if (error == "NotFoundError") {
    return mrb_intern_lit(mrb, "NotFoundError");
  }
  if (error == "NotOpenError") {
    return mrb_intern_lit(mrb, "NotOpenError");
  }
  if (error == "NotReadyError") {
    return mrb_intern_lit(mrb, "NotReadyError");
  }

  return mrb_intern_lit(mrb, "ErrorNotFoundError");
}

void
raise_error(mrb_state* mrb,
            RClass* klass,
            std::string error,
            std::string message)
{
  mrb_raise(
    mrb,
    mrb_exc_get_module_id(
      mrb,
      mrb_const_get(mrb, mrb_obj_value(klass), error_from_string(mrb, error))),
    message.c_str());
}

void
raise_not_found_error(mrb_state* mrb, RClass* klass)
{
  raise_error(mrb, klass, "NotFoundError", "File not found");
}
