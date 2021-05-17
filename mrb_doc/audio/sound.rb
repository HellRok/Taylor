# Loads a sound object from a file
# @param path [String]
# @return [Sound]
def load_sound(path)
  # mrb_load_sound
  # src/mruby_integration/audio/sound.cpp
  Sound.new
end

# Unloads a sound object
# @param sound [Sound]
# @return [nil]
def unload_sound(sound)
  # mrb_load_sound
  # src/mruby_integration/audio/sound.cpp
  nil
end

# Plays a sound object
# @param sound [Sound]
# @return [nil]
def play_sound(sound)
  # mrb_play_sound
  # src/mruby_integration/audio/sound.cpp
  nil
end

# Stops a sound object
# @param sound [Sound]
# @return [nil]
def stop_sound(sound)
  # mrb_stop_sound
  # src/mruby_integration/audio/sound.cpp
  nil
end

# Pauses a sound object so it can be resumed
# @param sound [Sound]
# @return [nil]
def pause_sound(sound)
  # mrb_pause_sound
  # src/mruby_integration/audio/sound.cpp
  nil
end

# Resumes a paused sound object
# @param sound [Sound]
# @return [nil]
def resume_sound(sound)
  # mrb_resume_sound
  # src/mruby_integration/audio/sound.cpp
  nil
end

# Plays a sound in the sound playback pool. This allows for multiple of the
# same sound to be played simultaneously.
# @param sound [Sound]
# @return [nil]
def play_sound_multi(sound)
  # mrb_play_sound_multi
  # src/mruby_integration/audio/sound.cpp
  nil
end

# Stops all sounds in the sound playback pool
# @return [nil]
def stop_sound_multi(sound)
  # mrb_stop_sound_multi
  # src/mruby_integration/audio/sound.cpp
  nil
end

# Returns the count of sounds playing currently
# @return [Integer]
def get_sounds_playing()
  # mrb_get_sounds_playing
  # src/mruby_integration/audio/sound.cpp
  1
end

# Sets the volume of the sound object
# @param sound [Sound]
# @param volume [Float] a value between 0.0 and 1.0
# @return [nil]
def set_sound_volume(sound, volume)
  # mrb_set_sound_volume
  # src/mruby_integration/audio/sound.cpp
  1
end

# Sets the pitch of the sound object
# @param sound [Sound]
# @param pitch [Float] a value between 0.0 and 1.0
# @return [nil]
def set_sound_pitch(sound, pitch)
  # mrb_set_sound_pitch
  # src/mruby_integration/audio/sound.cpp
  1
end
