#pragma once

#include "mruby.h"

struct Gamepad
{
  int index;
};

void
append_models_Gamepad(mrb_state*);
