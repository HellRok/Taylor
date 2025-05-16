#pragma once

#include <string>

#include "mruby.h"

void
raise_error(mrb_state*, RClass*, std::string, std::string);

void
raise_not_found_error(mrb_state*, RClass*);
