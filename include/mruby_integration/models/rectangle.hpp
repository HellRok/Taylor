#pragma once

#include "mruby.h"

extern RClass *Rectangle_class;

void setup_Rectangle(mrb_state*, mrb_value, Rectangle*, float, float, float, float);

void append_models_Rectangle(mrb_state*);
