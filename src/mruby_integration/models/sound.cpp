#include "mruby.h"
#include "mruby/class.h"
#include "mruby/data.h"
#include "raylib.h"
#include <cstdlib>

#include "mruby_integration/exceptions.hpp"
#include "mruby_integration/helpers.hpp"
#include "mruby_integration/struct_types.hpp"

#include "ruby/models/sound.hpp"

struct RClass* Sound_class;

auto
mrb_Sound_initialize(mrb_state* mrb, mrb_value self) -> mrb_value
{
  char* path;

  // Sound.new("./assets/beep.ogg", volume: 1, pitch: 1)
  const mrb_int kw_num = 2;
  const mrb_int kw_required = 0;
  const mrb_sym kw_names[] = { mrb_intern_lit(mrb, "volume"),
                               mrb_intern_lit(mrb, "pitch") };
  mrb_value kw_values[kw_num];
  mrb_kwargs kwargs = { kw_num, kw_required, kw_names, kw_values, nullptr };
  mrb_get_args(mrb, "z:", &path, &kwargs);

  if (!FileExists(path)) {
    raise_not_found_error(mrb, Sound_class, path);
  }

  double volume = 1.0;
  if (!mrb_undef_p(kw_values[0])) {
    volume = mrb_as_float(mrb, kw_values[0]);
  }
  if (volume < 0.0 || volume > 1.0) {
    mrb_raise(mrb, E_ARGUMENT_ERROR, "Volume must be within (0.0..1.0)");
  }

  double pitch = 1.0;
  if (!mrb_undef_p(kw_values[1])) {
    pitch = mrb_as_float(mrb, kw_values[1]);
  }

  Sound* sound;
  mrb_self_ptr(mrb, self, Sound, sound);
  *sound = LoadSound(path);

  SetSoundVolume(*sound, volume);
  SetSoundPitch(*sound, pitch);

  mrb_iv_set(
    mrb, self, mrb_intern_cstr(mrb, "@volume"), mrb_float_value(mrb, volume));
  mrb_iv_set(
    mrb, self, mrb_intern_cstr(mrb, "@pitch"), mrb_float_value(mrb, pitch));

  mrb_data_init(self, sound, &Sound_type);
  return self;
}

auto
mrb_Sound_unload(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Sound, sound);

  UnloadSound(*sound);

  return mrb_nil_value();
}

auto
mrb_Sound_valid(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Sound, sound);

  return mrb_bool_value(IsSoundValid(*sound));
}

auto
mrb_Sound_frame_count(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Sound, sound);

  return mrb_float_value(mrb, sound->frameCount);
}

auto
mrb_Sound_play(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Sound, sound);

  PlaySound(*sound);

  return mrb_nil_value();
}

auto
mrb_Sound_stop(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Sound, sound);

  StopSound(*sound);

  return mrb_nil_value();
}

auto
mrb_Sound_pause(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Sound, sound);

  PauseSound(*sound);

  return mrb_nil_value();
}

auto
mrb_Sound_resume(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Sound, sound);

  ResumeSound(*sound);

  return mrb_nil_value();
}

auto
mrb_Sound_playing(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Sound, sound);

  return mrb_bool_value(IsSoundPlaying(*sound));
}

auto
mrb_Sound_set_volume(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Sound, sound);

  mrb_float volume;
  mrb_get_args(mrb, "f", &volume);

  if (volume < 0 || volume > 1) {
    mrb_raise(mrb, E_ARGUMENT_ERROR, "Volume must be within (0.0..1.0)");
  }

  mrb_iv_set(
    mrb, self, mrb_intern_cstr(mrb, "@volume"), mrb_float_value(mrb, volume));
  SetSoundVolume(*sound, volume);

  return mrb_float_value(mrb, volume);
}

auto
mrb_Sound_set_pitch(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Sound, sound);

  mrb_float pitch;
  mrb_get_args(mrb, "f", &pitch);

  mrb_iv_set(
    mrb, self, mrb_intern_cstr(mrb, "@pitch"), mrb_float_value(mrb, pitch));
  SetSoundPitch(*sound, pitch);

  return mrb_float_value(mrb, pitch);
}

void
append_models_Sound(mrb_state* mrb)
{
  Sound_class = mrb_define_class(mrb, "Sound", mrb->object_class);
  MRB_SET_INSTANCE_TT(Sound_class, MRB_TT_DATA);
  mrb_define_method(
    mrb, Sound_class, "initialize", mrb_Sound_initialize, MRB_ARGS_REQ(1));
  mrb_define_method(
    mrb, Sound_class, "unload", mrb_Sound_unload, MRB_ARGS_NONE());
  mrb_define_method(
    mrb, Sound_class, "valid?", mrb_Sound_valid, MRB_ARGS_NONE());
  mrb_define_method(
    mrb, Sound_class, "frame_count", mrb_Sound_frame_count, MRB_ARGS_NONE());
  mrb_define_method(mrb, Sound_class, "play", mrb_Sound_play, MRB_ARGS_NONE());
  mrb_define_method(mrb, Sound_class, "stop", mrb_Sound_stop, MRB_ARGS_NONE());
  mrb_define_method(
    mrb, Sound_class, "pause", mrb_Sound_pause, MRB_ARGS_NONE());
  mrb_define_method(
    mrb, Sound_class, "resume", mrb_Sound_resume, MRB_ARGS_NONE());
  mrb_define_method(
    mrb, Sound_class, "playing?", mrb_Sound_playing, MRB_ARGS_NONE());
  mrb_define_method(
    mrb, Sound_class, "volume=", mrb_Sound_set_volume, MRB_ARGS_REQ(1));
  mrb_define_method(
    mrb, Sound_class, "pitch=", mrb_Sound_set_pitch, MRB_ARGS_REQ(1));

  load_ruby_models_sound(mrb);
}
