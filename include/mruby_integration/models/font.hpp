#pragma once

#include "mruby.h"
#include "raylib.h"

extern RClass* Font_class;

void setup_Font(mrb_state*, mrb_value, Font*, int, int, int, Texture2D*);
void append_models_Font(mrb_state*);
