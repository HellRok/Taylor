# Initialises the audio device for playback
# @return [nil]
def init_audio_device
  # mrb_init_audio_device
  # src/mruby_integration/audio/device.cpp
  nil
end

# Closes the audio device
# @return [nil]
def close_audio_device
  # mrb_close_audio_device
  # src/mruby_integration/audio/device.cpp
  nil
end

# Returns if the audio device has been setup
# @return [Boolean]
def audio_device_ready?
  # mrb_audio_device_ready
  # src/mruby_integration/audio/device.cpp
  true
end

# Sets the master volume
# @param volume [Float] a value between 0.0 and 1.0
# @return [nil]
def set_master_volume(volume)
  # mrb_set_master_volume
  # src/mruby_integration/audio/device.cpp
  nil
end
