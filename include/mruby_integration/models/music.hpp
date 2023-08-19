#pragma once

#include "mruby.h"
#include "raylib.h"

extern RClass* Music_class;

void
setup_Music(mrb_state*, mrb_value, Music*, int, bool, int);

void
append_models_Music(mrb_state*);
