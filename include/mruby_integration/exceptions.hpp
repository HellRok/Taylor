#pragma once

#include <string>

#include "mruby.h"

void
raise_error(mrb_state*, RClass*, std::string, std::string);

void
raise_not_found_error(mrb_state*, RClass*, std::string);

#define EXIT_UNLESS_WINDOW_READY(message)                                      \
  if (!IsWindowReady()) {                                                      \
    raise_error(mrb, Window_class, "NotReadyError", message);                  \
    return mrb_nil_value();                                                    \
  }
