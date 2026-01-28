#include <sstream>
#include <string>

#include "mruby.h"
#include "mruby/class.h"
#include "mruby/variable.h"

auto mrb_exc_get_module_id(mrb_state* mrb, mrb_value c) -> RClass*
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

#define RETURN_IF_ERROR(err)                                                                       \
  {                                                                                                \
    if (error == err) {                                                                            \
      return mrb_intern_lit(mrb, err);                                                             \
    }                                                                                              \
  }

auto error_from_string(mrb_state* mrb, std::string error) -> mrb_sym
{
  // We have this kind of dodgy method because `mrb_intern_lit` is a macro that
  // can't expand with anything other than a quoted string.
  RETURN_IF_ERROR("NotFoundError")
  RETURN_IF_ERROR("NotOpenError")
  RETURN_IF_ERROR("NotReadyError")
  RETURN_IF_ERROR("AlreadyOpenError")

  return mrb_intern_lit(mrb, "ErrorNotFoundError");
}

void raise_error(mrb_state* mrb, RClass* klass, std::string error, std::string message)
{
  mrb_raise(mrb,
            mrb_exc_get_module_id(
              mrb, mrb_const_get(mrb, mrb_obj_value(klass), error_from_string(mrb, error))),
            message.c_str());
}

void raise_not_found_error(mrb_state* mrb, RClass* klass, std::string path)
{
  std::stringstream message;
  message << "Unable to find '" << path << "'";

  raise_error(mrb, klass, "NotFoundError", message.str());
}
