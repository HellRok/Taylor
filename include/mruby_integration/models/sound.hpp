#pragma once

#include "mruby.h"
#include "raylib.h"

extern RClass *Sound_class;

void setup_Sound(mrb_state*, mrb_value, Sound*, int);

void append_models_Sound(mrb_state*);
