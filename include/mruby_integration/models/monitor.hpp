#pragma once

#include "mruby.h"

struct Monitor
{
  int id;
};

auto
mrb_Monitor_value(mrb_state*, Monitor*) -> mrb_value;

void
Monitor_init(Monitor*, int);

void
append_models_Monitor(mrb_state*);
