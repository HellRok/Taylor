#pragma once

#include "mruby.h"

void
raise_not_found_error(mrb_state*, RClass*);

void
raise_audio_not_open_error(mrb_state*, const char*);
