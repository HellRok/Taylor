#pragma once
#include "mruby.h"

void workarounds_mingw_attach_console();
void workarounds_mingw_msg_dontwait(mrb_state*);
