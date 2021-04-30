#pragma once

#include "mruby.h"
#include "raylib.h"

extern RClass *Colour_class;

void setup_Colour(mrb_state*, mrb_value, Color*, int, int, int, int);

void append_models_Colour(mrb_state*);
