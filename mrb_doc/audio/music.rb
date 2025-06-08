# Updates the buffer for the specified music, you should call this every frame.
# @param music [Music]
# @return [nil]
def update_music_stream(music)
  # mrb_update_music_stream
  # src/mruby_integration/audio/music.cpp
  nil
end

# Pauses a music object so it can be resumed.
# @param music [Music]
# @return [nil]
def pause_music_stream(music)
  # mrb_pause_music_stream
  # src/mruby_integration/audio/music.cpp
  nil
end

# Resumes a paused music object.
# @param music [Music]
# @return [nil]
def resume_music_stream(music)
  # mrb_resume_music_stream
  # src/mruby_integration/audio/music.cpp
  nil
end

# Sets volume for a music object.
# @param music [Music]
# @param volume [Float] A value between 0.0 and 1.0.
# @return [nil]
def set_music_volume(music, volume)
  # mrb_set_music_volume
  # src/mruby_integration/audio/music.cpp
  nil
end

# Sets pitch for a music object.
# @param music [Music]
# @param pitch [Float]
# @return [nil]
def set_music_pitch(music, pitch)
  # mrb_set_music_pitch
  # src/mruby_integration/audio/music.cpp
  nil
end

# Gets the length of a music object in seconds.
# @param music [Music]
# @return [Float] The length of the music object in seconds.
def get_music_time_length(music)
  # mrb_get_music_time_length
  # src/mruby_integration/audio/music.cpp
  nil
end

# Gets the time played of a music object in seconds.
# @param music [Music]
# @return [Float] The length of the music object in seconds
def get_music_time_played(music)
  # mrb_get_music_time_played
  # src/mruby_integration/audio/music.cpp
  nil
end
