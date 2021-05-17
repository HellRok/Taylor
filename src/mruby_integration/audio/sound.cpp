#include <cstdlib>
#include "raylib.h"
#include "mruby.h"

#include "mruby_integration/models/sound.hpp"
#include "mruby_integration/struct_types.hpp"

mrb_value mrb_load_sound(mrb_state *mrb, mrb_value) {
  char* path;
  mrb_get_args(mrb, "z", &path);

  Sound *new_sound = (Sound *)malloc(sizeof(Sound));
  *new_sound = LoadSound(path);
  mrb_value obj = mrb_obj_value(Data_Wrap_Struct(mrb, Sound_class, &Sound_type, new_sound));

  setup_Sound(mrb, obj, new_sound, new_sound->sampleCount);

  return obj;
}

mrb_value mrb_unload_sound(mrb_state *mrb, mrb_value) {
  Sound *sound;
  mrb_get_args(mrb, "d", &sound, &Sound_type);

  UnloadSound(*sound);

  return mrb_nil_value();
}

mrb_value mrb_play_sound(mrb_state *mrb, mrb_value) {
  Sound *sound;
  mrb_get_args(mrb, "d", &sound, &Sound_type);

  PlaySound(*sound);

  return mrb_nil_value();
}

mrb_value mrb_stop_sound(mrb_state *mrb, mrb_value) {
  Sound *sound;
  mrb_get_args(mrb, "d", &sound, &Sound_type);

  StopSound(*sound);

  return mrb_nil_value();
}

mrb_value mrb_pause_sound(mrb_state *mrb, mrb_value) {
  Sound *sound;
  mrb_get_args(mrb, "d", &sound, &Sound_type);

  PauseSound(*sound);

  return mrb_nil_value();
}

mrb_value mrb_resume_sound(mrb_state *mrb, mrb_value) {
  Sound *sound;
  mrb_get_args(mrb, "d", &sound, &Sound_type);

  ResumeSound(*sound);

  return mrb_nil_value();
}

mrb_value mrb_play_sound_multi(mrb_state *mrb, mrb_value) {
  Sound *sound;
  mrb_get_args(mrb, "d", &sound, &Sound_type);

  PlaySoundMulti(*sound);

  return mrb_nil_value();
}

mrb_value mrb_stop_sound_multi(mrb_state*, mrb_value) {
  StopSoundMulti();

  return mrb_nil_value();
}

mrb_value mrb_get_sounds_playing(mrb_state *mrb, mrb_value) {
  return mrb_int_value(mrb, GetSoundsPlaying());
}

mrb_value mrb_is_sound_playing(mrb_state *mrb, mrb_value) {
  Sound *sound;
  mrb_get_args(mrb, "d", &sound, &Sound_type);

  return mrb_bool_value(IsSoundPlaying(*sound));
}

mrb_value mrb_set_sound_volume(mrb_state *mrb, mrb_value) {
  Sound *sound;
  mrb_float volume;
  mrb_get_args(mrb, "df", &sound, &Sound_type, &volume);

  SetSoundVolume(*sound, volume);

  return mrb_nil_value();
}

mrb_value mrb_set_sound_pitch(mrb_state *mrb, mrb_value) {
  Sound *sound;
  mrb_float pitch;
  mrb_get_args(mrb, "df", &sound, &Sound_type, &pitch);

  SetSoundPitch(*sound, pitch);

  return mrb_nil_value();
}

void append_audio_sound(mrb_state *mrb) {
  mrb_define_method(mrb, mrb->kernel_module, "load_sound", mrb_load_sound, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "unload_sound", mrb_unload_sound, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "play_sound", mrb_play_sound, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "stop_sound", mrb_stop_sound, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "pause_sound", mrb_pause_sound, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "resume_sound", mrb_resume_sound, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "play_sound_multi", mrb_play_sound_multi, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "stop_sound_multi", mrb_stop_sound_multi, MRB_ARGS_NONE());
  mrb_define_method(mrb, mrb->kernel_module, "get_sounds_playing", mrb_get_sounds_playing, MRB_ARGS_NONE());
  mrb_define_method(mrb, mrb->kernel_module, "is_sound_playing?", mrb_get_sounds_playing, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb->kernel_module, "set_sound_volume", mrb_set_sound_volume, MRB_ARGS_REQ(2));
  mrb_define_method(mrb, mrb->kernel_module, "set_sound_pitch", mrb_set_sound_pitch, MRB_ARGS_REQ(2));
}
