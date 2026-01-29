#pragma once

#include "mruby.h"
#include "raylib.h"

extern RClass* Image_class;

void setup_Image(mrb_state*, mrb_value, Image*, int, int, int, int);
void append_models_Image(mrb_state*);
