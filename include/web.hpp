#pragma once
#ifdef __EMSCRIPTEN__
#include "mruby.h"
#include <emscripten/emscripten.h>

void append_web(mrb_state*);
#endif
