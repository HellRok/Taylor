#pragma once

#include "mruby.h"
#include "raylib.h"

extern RClass* Texture2D_class;

auto
mrb_Texture2D_value(mrb_state*, Texture2D*) -> mrb_value;
void
setup_Texture2D(mrb_state*, mrb_value, Texture2D*, int, int, int, int, int);
void
append_models_Texture2D(mrb_state*);
