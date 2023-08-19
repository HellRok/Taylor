#pragma once

#include "mruby.h"
#include "raylib.h"

extern RClass* RenderTexture_class;

void
append_models_RenderTexture(mrb_state*);
