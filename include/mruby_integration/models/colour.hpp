#pragma once

#include "mruby.h"
#include "raylib.h"

extern RClass* Colour_class;

auto
mrb_Color_value(mrb_state*, Color*) -> mrb_value;

void
set_Colour_ivars(mrb_state*, mrb_value, Color*);

void
append_models_Colour(mrb_state*);
