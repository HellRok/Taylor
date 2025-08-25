#include "mruby.h"
#include "mruby/class.h"
#include "mruby/data.h"
#include "raylib.h"

#include "mruby_integration/exceptions.hpp"
#include "mruby_integration/helpers.hpp"
#include "mruby_integration/models/audio.hpp"
#include "mruby_integration/struct_types.hpp"

#include "ruby/models/music.hpp"

struct RClass* Music_class;

void
setup_Music(mrb_state* mrb,
            mrb_value object,
            Music* music,
            int context_type,
            bool looping,
            int frame_count)
{
  ivar_attr_int(mrb, object, music->ctxType, context_type);
  ivar_attr_bool(mrb, object, music->looping, looping);
  ivar_attr_int(mrb, object, music->frameCount, frame_count);
}

auto
mrb_Music_initialize(mrb_state* mrb, mrb_value self) -> mrb_value
{
  char* path;

  // Music.new("./assets/test.ogg", looping: true, volume: 1, pitch: 1)
  const mrb_int kw_num = 3;
  const mrb_int kw_required = 0;
  const mrb_sym kw_names[] = { mrb_intern_lit(mrb, "looping"),
                               mrb_intern_lit(mrb, "volume"),
                               mrb_intern_lit(mrb, "pitch") };
  mrb_value kw_values[kw_num];
  mrb_kwargs kwargs = { kw_num, kw_required, kw_names, kw_values, nullptr };
  mrb_get_args(mrb, "z:", &path, &kwargs);

  if (!FileExists(path)) {
    raise_not_found_error(mrb, Music_class, path);
  }

  bool looping = true;
  if (!mrb_undef_p(kw_values[0])) {
    looping = mrb_equal(mrb, kw_values[0], mrb_true_value());
  }

  double volume = 1.0;
  if (!mrb_undef_p(kw_values[1])) {
    volume = mrb_as_float(mrb, kw_values[1]);
  }
  if (volume < 0.0 || volume > 1.0) {
    mrb_raise(mrb, E_ARGUMENT_ERROR, "Volume must be within (0.0..1.0)");
  }

  double pitch = 1.0;
  if (!mrb_undef_p(kw_values[2])) {
    pitch = mrb_as_float(mrb, kw_values[2]);
  }

  Music* music;
  mrb_self_ptr(mrb, self, Music, music);

  *music = LoadMusicStream(path);

  setup_Music(mrb, self, music, music->ctxType, looping, music->frameCount);
  SetMusicVolume(*music, volume);
  SetMusicPitch(*music, pitch);
  music->looping = looping;

  mrb_iv_set(
    mrb, self, mrb_intern_cstr(mrb, "@volume"), mrb_float_value(mrb, volume));
  mrb_iv_set(
    mrb, self, mrb_intern_cstr(mrb, "@pitch"), mrb_float_value(mrb, pitch));

  mrb_data_init(self, music, &Music_type);
  return self;
}

auto
mrb_Music_unload(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Music, music);

  UnloadMusicStream(*music);

  return mrb_nil_value();
}

auto
mrb_Music_valid(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Music, music);

  return mrb_bool_value(IsMusicValid(*music));
}

auto
mrb_Music_get_looping(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Music, music);

  return mrb_bool_value(music->looping);
}

auto
mrb_Music_set_looping(mrb_state* mrb, mrb_value self) -> mrb_value
{
  attr_setter_bool(mrb, self, Music_type, Music, looping, looping);
}

auto
mrb_Music_play(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Music, music);

  if (!IsAudioDeviceReady()) {
    raise_error(mrb,
                Audio_class,
                "NotOpenError",
                "You must use Audio.open before calling Music#play.");
  }

  PlayMusicStream(*music);

  return mrb_nil_value();
}

auto
mrb_Music_playing(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Music, music);

  return mrb_bool_value(IsMusicStreamPlaying(*music));
}

auto
mrb_Music_stop(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Music, music);

  StopMusicStream(*music);

  return mrb_nil_value();
}

auto
mrb_Music_played(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Music, music);

  return mrb_float_value(mrb, GetMusicTimePlayed(*music));
}

auto
mrb_Music_update(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Music, music);

  UpdateMusicStream(*music);

  return mrb_nil_value();
}

auto
mrb_Music_pause(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Music, music);

  PauseMusicStream(*music);

  return mrb_nil_value();
}

auto
mrb_Music_resume(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Music, music);

  ResumeMusicStream(*music);

  return mrb_nil_value();
}

auto
mrb_Music_length(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Music, music);

  return mrb_float_value(mrb, GetMusicTimeLength(*music));
}

auto
mrb_Music_set_volume(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Music, music);

  mrb_float volume;
  mrb_get_args(mrb, "f", &volume);

  if (volume < 0 || volume > 1) {
    mrb_raise(mrb, E_ARGUMENT_ERROR, "Volume must be within (0.0..1.0)");
  }

  mrb_iv_set(
    mrb, self, mrb_intern_cstr(mrb, "@volume"), mrb_float_value(mrb, volume));
  SetMusicVolume(*music, volume);

  return mrb_float_value(mrb, volume);
}

auto
mrb_Music_set_pitch(mrb_state* mrb, mrb_value self) -> mrb_value
{
  mrb_get_self(mrb, self, Music, music);

  mrb_float pitch;
  mrb_get_args(mrb, "f", &pitch);

  mrb_iv_set(
    mrb, self, mrb_intern_cstr(mrb, "@pitch"), mrb_float_value(mrb, pitch));
  SetMusicPitch(*music, pitch);

  return mrb_float_value(mrb, pitch);
}

void
append_models_Music(mrb_state* mrb)
{
  Music_class = mrb_define_class(mrb, "Music", mrb->object_class);
  MRB_SET_INSTANCE_TT(Music_class, MRB_TT_DATA);
  mrb_define_method(
    mrb, Music_class, "initialize", mrb_Music_initialize, MRB_ARGS_REQ(1));
  mrb_define_method(
    mrb, Music_class, "unload", mrb_Music_unload, MRB_ARGS_NONE());
  mrb_define_method(
    mrb, Music_class, "valid?", mrb_Music_valid, MRB_ARGS_NONE());
  mrb_define_method(
    mrb, Music_class, "looping", mrb_Music_get_looping, MRB_ARGS_NONE());
  mrb_define_method(
    mrb, Music_class, "looping=", mrb_Music_set_looping, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, Music_class, "play", mrb_Music_play, MRB_ARGS_NONE());
  mrb_define_method(
    mrb, Music_class, "playing?", mrb_Music_playing, MRB_ARGS_NONE());
  mrb_define_method(mrb, Music_class, "stop", mrb_Music_stop, MRB_ARGS_NONE());
  mrb_define_method(
    mrb, Music_class, "played", mrb_Music_played, MRB_ARGS_NONE());
  mrb_define_method(
    mrb, Music_class, "update", mrb_Music_update, MRB_ARGS_NONE());
  mrb_define_method(
    mrb, Music_class, "pause", mrb_Music_pause, MRB_ARGS_NONE());
  mrb_define_method(
    mrb, Music_class, "resume", mrb_Music_resume, MRB_ARGS_NONE());
  mrb_define_method(
    mrb, Music_class, "length", mrb_Music_length, MRB_ARGS_NONE());
  mrb_define_method(
    mrb, Music_class, "volume=", mrb_Music_set_volume, MRB_ARGS_REQ(1));
  mrb_define_method(
    mrb, Music_class, "pitch=", mrb_Music_set_pitch, MRB_ARGS_REQ(1));

  load_ruby_models_music(mrb);
}
