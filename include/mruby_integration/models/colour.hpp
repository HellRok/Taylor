#pragma once

#include "mruby.h"
#include "raylib.h"

extern RClass* Colour_class;

auto mrb_Color_value(mrb_state*, Color*) -> mrb_value;

void Color_init(Color*);

void append_models_Colour(mrb_state*);
