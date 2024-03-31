class Audio
  # Initialises the {Audio} system for playback. This needs to be done before
  # any {Music} or {Sound} can be played.
  #
  # @example Basic usage
  #   Audio.open
  #   Audio.close
  #
  # @return [nil]
  def self.open
    # mrb_Audio_open
    # src/mruby_integration/models/audio.cpp
    nil
  end

  # Closes the {Audio} system. This should be done before the end of your
  # application. You will not be able to play any {Sound} or {Music} after this
  # has been done.
  #
  # @example Basic usage
  #   Audio.open
  #   Audio.close
  #
  # @return [nil]
  def self.close
    # mrb_Audio_close
    # src/mruby_integration/models/audio.cpp
    nil
  end

  # Checks whether or not {Audio} has been initialised.
  #
  # @example Basic usage
  #   Audio.ready? # => false
  #   Audio.open
  #
  #   Audio.ready? # => true
  #
  #   Audio.close
  #   Audio.ready? # => false
  #
  # @return [Boolean]
  def self.ready?
    # mrb_Audio_ready
    # src/mruby_integration/models/audio.cpp
    true
  end

  # Sets the master volume for all {Music} and {Sound}.
  #
  # @example Basic usage
  #   Audio.open
  #   Audio.volume = 50
  #   Audio.close
  #
  # @param volume [Float] A number between 0 and 100.
  # @return [nil]
  # @raise [ArgumentError] Raised when passed an invalid volume.
  # @raise [Audio::NotOpen] Raised when trying to set the volume before opening the {Audio} system.
  def self.volume=(volume)
    # mrb_Audio_set_volume
    # src/mruby_integration/models/audio.cpp
    nil
  end
end
