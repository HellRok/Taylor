#pragma once
#include "mruby.h"
#ifdef __EMSCRIPTEN__
#include <emscripten/emscripten.h>
#endif

void append_web(mrb_state*);
