#pragma once

#include "mruby.h"
#include "raylib.h"

extern RClass* Vector2_class;

auto
mrb_Vector2_value(mrb_state*, Vector2*) -> mrb_value;

void
append_models_Vector2(mrb_state*);
