#include "mruby.h"
#include "mruby/class.h"
#include "raylib.h"

#include "mruby_integration/exceptions.hpp"

#include "ruby/models/audio.hpp"

struct RClass* Audio_class;

auto
mrb_Audio_open(mrb_state*, mrb_value) -> mrb_value
{
  InitAudioDevice();
  return mrb_nil_value();
}

auto
mrb_Audio_close(mrb_state*, mrb_value) -> mrb_value
{
  CloseAudioDevice();
  return mrb_nil_value();
}

auto
mrb_Audio_ready(mrb_state*, mrb_value) -> mrb_value
{
  return mrb_bool_value(IsAudioDeviceReady());
}

auto
mrb_Audio_set_volume(mrb_state* mrb, mrb_value) -> mrb_value
{
  if (!IsAudioDeviceReady()) {
    const char* message =
      "You must use Audio.open before calling Audio.volume=.";
    raise_audio_not_open_error(mrb, message);
  }

  mrb_float volume;
  mrb_get_args(mrb, "f", &volume);

  if (volume < 0 || volume > 100) {
    mrb_raise(mrb, E_ARGUMENT_ERROR, "Must be within (0..100)");
  }

  SetMasterVolume(volume / 100.0);
  return mrb_nil_value();
}

/* Re-enable this once upgraded to Raylib 5.0
 *auto
 *mrb_Audio_volume(mrb_state* mrb, mrb_value) -> mrb_value
 *{
 *  return mrb_float_value(GetMasterVolume(volume));
 *}
 */

void
append_models_Audio(mrb_state* mrb)
{
  Audio_class = mrb_define_class(mrb, "Audio", mrb->object_class);
  MRB_SET_INSTANCE_TT(Audio_class, MRB_TT_DATA);
  mrb_define_class_method(
    mrb, Audio_class, "open", mrb_Audio_open, MRB_ARGS_NONE());
  mrb_define_class_method(
    mrb, Audio_class, "close", mrb_Audio_close, MRB_ARGS_NONE());
  mrb_define_class_method(
    mrb, Audio_class, "ready?", mrb_Audio_ready, MRB_ARGS_NONE());
  mrb_define_class_method(
    mrb, Audio_class, "volume=", mrb_Audio_set_volume, MRB_ARGS_REQ(1));
  /* mrb_define_class_method(mrb,
   *                Audio_class,
   *                "volume",
   *                mrb_Audio_volume,
   *                MRB_ARGS_NONE());
   */

  load_ruby_models_audio(mrb);
}
