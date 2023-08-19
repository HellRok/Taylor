#include "mruby.h"
#include "raylib.h"
#include <cstdlib>

#include "mruby_integration/models/music.hpp"
#include "mruby_integration/struct_types.hpp"

auto
mrb_load_music_stream(mrb_state* mrb, mrb_value) -> mrb_value
{
  char* path;
  mrb_get_args(mrb, "z", &path);

  auto* new_music = static_cast<Music*>(malloc(sizeof(Music)));
  *new_music = LoadMusicStream(path);
  mrb_value obj =
    mrb_obj_value(Data_Wrap_Struct(mrb, Music_class, &Music_type, new_music));

  setup_Music(mrb,
              obj,
              new_music,
              new_music->ctxType,
              new_music->looping,
              new_music->frameCount);

  return obj;
}

auto
mrb_unload_music_stream(mrb_state* mrb, mrb_value) -> mrb_value
{
  Music* music;
  mrb_get_args(mrb, "d", &music, &Music_type);

  UnloadMusicStream(*music);

  return mrb_nil_value();
}

auto
mrb_play_music_stream(mrb_state* mrb, mrb_value) -> mrb_value
{
  Music* music;
  mrb_get_args(mrb, "d", &music, &Music_type);

  PlayMusicStream(*music);

  return mrb_nil_value();
}

auto
mrb_music_playing(mrb_state* mrb, mrb_value) -> mrb_value
{
  Music* music;
  mrb_get_args(mrb, "d", &music, &Music_type);

  return mrb_bool_value(IsMusicStreamPlaying(*music));
}

auto
mrb_update_music_stream(mrb_state* mrb, mrb_value) -> mrb_value
{
  Music* music;
  mrb_get_args(mrb, "d", &music, &Music_type);

  UpdateMusicStream(*music);

  return mrb_nil_value();
}

auto
mrb_stop_music_stream(mrb_state* mrb, mrb_value) -> mrb_value
{
  Music* music;
  mrb_get_args(mrb, "d", &music, &Music_type);

  StopMusicStream(*music);

  return mrb_nil_value();
}

auto
mrb_pause_music_stream(mrb_state* mrb, mrb_value) -> mrb_value
{
  Music* music;
  mrb_get_args(mrb, "d", &music, &Music_type);

  PauseMusicStream(*music);

  return mrb_nil_value();
}

auto
mrb_resume_music_stream(mrb_state* mrb, mrb_value) -> mrb_value
{
  Music* music;
  mrb_get_args(mrb, "d", &music, &Music_type);

  ResumeMusicStream(*music);

  return mrb_nil_value();
}

auto
mrb_set_music_volume(mrb_state* mrb, mrb_value) -> mrb_value
{
  Music* music;
  mrb_float volume;
  mrb_get_args(mrb, "df", &music, &Music_type, &volume);

  SetMusicVolume(*music, volume);

  return mrb_nil_value();
}

auto
mrb_set_music_pitch(mrb_state* mrb, mrb_value) -> mrb_value
{
  Music* music;
  mrb_float pitch;
  mrb_get_args(mrb, "df", &music, &Music_type, &pitch);

  SetMusicPitch(*music, pitch);

  return mrb_nil_value();
}

auto
mrb_get_music_time_length(mrb_state* mrb, mrb_value) -> mrb_value
{
  Music* music;
  mrb_get_args(mrb, "d", &music, &Music_type);

  return mrb_float_value(mrb, GetMusicTimeLength(*music));
}

auto
mrb_get_music_time_played(mrb_state* mrb, mrb_value) -> mrb_value
{
  Music* music;
  mrb_get_args(mrb, "d", &music, &Music_type);

  return mrb_float_value(mrb, GetMusicTimePlayed(*music));
}

void
append_audio_music(mrb_state* mrb)
{
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "load_music_stream",
                    mrb_load_music_stream,
                    MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "unload_music_stream",
                    mrb_unload_music_stream,
                    MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "play_music_stream",
                    mrb_play_music_stream,
                    MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "music_playing?",
                    mrb_music_playing,
                    MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "update_music_stream",
                    mrb_update_music_stream,
                    MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "stop_music_stream",
                    mrb_stop_music_stream,
                    MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "pause_music_stream",
                    mrb_pause_music_stream,
                    MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "resume_music_stream",
                    mrb_resume_music_stream,
                    MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "set_music_volume",
                    mrb_set_music_volume,
                    MRB_ARGS_REQ(2));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "set_music_pitch",
                    mrb_set_music_pitch,
                    MRB_ARGS_REQ(2));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "get_music_time_length",
                    mrb_get_music_time_length,
                    MRB_ARGS_REQ(1));
  mrb_define_method(mrb,
                    mrb->kernel_module,
                    "get_music_time_played",
                    mrb_get_music_time_played,
                    MRB_ARGS_REQ(1));
}
