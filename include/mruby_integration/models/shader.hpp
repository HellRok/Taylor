#pragma once

#include "mruby.h"
#include "raylib.h"

extern RClass* Shader_class;

void
setup_Shader(mrb_state*, mrb_value, Shader*, int);
void
append_models_Shader(mrb_state*);
