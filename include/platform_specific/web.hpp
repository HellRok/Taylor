#pragma once
#ifdef __EMSCRIPTEN__
#include "mruby.h"

void append_platform_specific_web(mrb_state*);
#endif
