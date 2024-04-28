# Plays a sound object.
# @param sound [Sound]
# @return [nil]
def play_sound(sound)
  # mrb_play_sound
  # src/mruby_integration/audio/sound.cpp
  nil
end

# Stops a sound object.
# @param sound [Sound]
# @return [nil]
def stop_sound(sound)
  # mrb_stop_sound
  # src/mruby_integration/audio/sound.cpp
  nil
end

# Pauses a sound object so it can be resumed.
# @param sound [Sound]
# @return [nil]
def pause_sound(sound)
  # mrb_pause_sound
  # src/mruby_integration/audio/sound.cpp
  nil
end

# Resumes a paused sound object.
# @param sound [Sound]
# @return [nil]
def resume_sound(sound)
  # mrb_resume_sound
  # src/mruby_integration/audio/sound.cpp
  nil
end

# Checks whether or not a sound object is currently playing.
# @param sound [Sound]
# @return [Boolean]
def sound_playing?(sound)
  # mrb_sound_playing
  # src/mruby_integration/audio/sound.cpp
  true
end

# Sets the volume of the sound object.
# @param sound [Sound]
# @param volume [Float] A value between 0.0 and 1.0.
# @return [nil]
def set_sound_volume(sound, volume)
  # mrb_set_sound_volume
  # src/mruby_integration/audio/sound.cpp
  1
end

# Sets the pitch of the sound object.
# @param sound [Sound]
# @param pitch [Float]
# @return [nil]
def set_sound_pitch(sound, pitch)
  # mrb_set_sound_pitch
  # src/mruby_integration/audio/sound.cpp
  1
end
