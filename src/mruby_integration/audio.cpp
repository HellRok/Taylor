#include "mruby.h"

#include "mruby_integration/audio/device.hpp"
#include "mruby_integration/audio/music.hpp"
#include "mruby_integration/audio/sound.hpp"

void append_audio(mrb_state *mrb) {
  append_audio_device(mrb);
  append_audio_music(mrb);
  append_audio_sound(mrb);
}
