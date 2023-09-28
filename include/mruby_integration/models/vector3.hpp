#pragma once

#include "mruby.h"

extern RClass *Vector3_class;

void setup_Vector3(mrb_state*, mrb_value, Vector3*, float, float);

void append_models_Vector3(mrb_state*);
