#include "mruby.h"

#include "mruby_integration/audio/sound.hpp"

void
append_audio(mrb_state* mrb)
{
  append_audio_sound(mrb);
}
