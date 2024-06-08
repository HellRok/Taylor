#include "mruby.h"
#include "raylib.h"
#include <cstdlib>

#include "mruby_integration/models/sound.hpp"
#include "mruby_integration/struct_types.hpp"

auto
mrb_pause_sound(mrb_state* mrb, mrb_value) -> mrb_value
{
  Sound* sound;
  mrb_get_args(mrb, "d", &sound, &Sound_type);

  PauseSound(*sound);

  return mrb_nil_value();
}

auto
mrb_resume_sound(mrb_state* mrb, mrb_value) -> mrb_value
{
  Sound* sound;
  mrb_get_args(mrb, "d", &sound, &Sound_type);

  ResumeSound(*sound);

  return mrb_nil_value();
}

auto
mrb_sound_playing(mrb_state* mrb, mrb_value) -> mrb_value
{
  Sound* sound;
  mrb_get_args(mrb, "d", &sound, &Sound_type);

  return mrb_bool_value(IsSoundPlaying(*sound));
}

auto
mrb_set_sound_volume(mrb_state* mrb, mrb_value) -> mrb_value
{
  Sound* sound;
  mrb_float volume;
  mrb_get_args(mrb, "df", &sound, &Sound_type, &volume);

  SetSoundVolume(*sound, volume);

  return mrb_nil_value();
}

auto
mrb_set_sound_pitch(mrb_state* mrb, mrb_value) -> mrb_value
{
  Sound* sound;
  mrb_float pitch;
  mrb_get_args(mrb, "df", &sound, &Sound_type, &pitch);

  SetSoundPitch(*sound, pitch);

  return mrb_nil_value();
}

void
append_audio_sound(mrb_state* mrb)
{
  mrb_define_method(
    mrb, mrb->kernel_module, "pause_sound", mrb_pause_sound, MRB_ARGS_REQ(1));
  mrb_define_method(
    mrb, mrb->kernel_module, "resume_sound", mrb_resume_sound, MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "sound_playing?",
                    mrb_sound_playing,
                    MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "set_sound_volume",
                    mrb_set_sound_volume,
                    MRB_ARGS_REQ(2));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "set_sound_pitch",
                    mrb_set_sound_pitch,
                    MRB_ARGS_REQ(2));
}
