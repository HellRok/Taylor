#pragma once

#include "mruby.h"

extern RClass *Vector2_class;

void setup_Vector2(mrb_state*, mrb_value, Vector2*, float, float);

void append_models_Vector2(mrb_state*);
