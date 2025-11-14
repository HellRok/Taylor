class Sound
  # Creates a new instance of {Sound}. If the file does not exist it will raise
  # {Sound::NotFoundError}.
  #
  # @example Basic usage
  #   beep = Sound.new("./assets/beep.wav")
  #
  # @example Basic usage with lower volume and higher pitch
  #   beep = Sound.new("./assets/beep.wav", volume: 0.75, pitch: 1.2)
  #
  # @param volume [Float] A value between 0.0 and 1.0.
  # @param pitch [Float]
  # @param path [String]
  # @return [Sound]
  # @raise [Sound::NotFoundError] Raised when the file to load is not found.
  # @raise [ArgumentError] Raised when passing an invalid volume.
  def initialize(path, volume: 1.0, pitch: 1.0)
    # mrb_Sound_initialize
    # src/mruby_integration/models/sound.cpp
  end

  # Unloads the {Sound} from memory.
  #
  # @example Basic usage
  #   beep = Sound.new("./assets/beep.wav")
  #   # Do some stuff...
  #   beep.unload
  #
  # @return [nil]
  def unload
    # mrb_Sound_unload
    # src/mruby_integration/models/sound.cpp
    nil
  end

  # Is the {Sound} loaded and valid?
  #
  # @example Basic usage
  #   beep = Sound.new("./assets/beep.wav")
  #   raise "Bad sound!" unless beep.valid?
  #   beep.unload
  #
  # @return [Boolean]
  def valid?
    # mrb_Sound_valid
    # src/mruby_integration/models/sound.cpp
    true
  end

  # Returns the frame_count for the {Sound}.
  #
  # @example Basic usage
  #   beep = Sound.new("./assets/beep.wav")
  #   puts beep.frame_count #=> 96000
  #
  # @return [Integer]
  def frame_count
    # mrb_Sound_frame_count
    # src/mruby_integration/models/sound.cpp
    96000
  end

  # Starts playing the {Sound}.
  #
  # @example Basic usage
  #   beep = Sound.new("./assets/beep.wav")
  #   puts beep.playing? #=> false
  #   beep.play
  #   puts beep.playing? #=> true
  #
  # @return [nil]
  def play
    # mrb_Sound_play
    # src/mruby_integration/models/sound.cpp
    nil
  end

  # Stops playing the {Sound}.
  #
  # @example Basic usage
  #   beep = Sound.new("./assets/beep.wav")
  #   beep.play
  #   #...
  #   puts beep.playing? #=> true
  #   beep.stop
  #   puts beep.playing? #=> false
  #
  # @return [nil]
  def stop
    # mrb_Sound_stop
    # src/mruby_integration/models/sound.cpp
    nil
  end

  # Pauses the {Sound} so it can be resumed later with {Sound#resume}.
  #
  # @example Basic usage
  #   beep = Sound.new("./assets/beep.wav")
  #   beep.play
  #   #...
  #   puts beep.playing? #=> true
  #   beep.pause
  #   puts beep.playing? #=> false
  #
  # @return [nil]
  def pause
    # mrb_Sound_pause
    # src/mruby_integration/models/sound.cpp
    nil
  end

  # Resumes a paused {Sound}.
  #
  # @example Basic usage
  #   beep = Sound.new("./assets/beep.wav")
  #   beep.play
  #   #...
  #   puts beep.playing? #=> true
  #   beep.pause
  #   puts beep.playing? #=> false
  #   #...
  #   beep.resume
  #   puts beep.playing? #=> true
  #
  # @return [nil]
  def resume
    # mrb_Sound_resume
    # src/mruby_integration/models/sound.cpp
    nil
  end

  # Is the {Sound} currently playing?
  #
  # @example Basic usage
  #   beep = Sound.new("./assets/beep.wav")
  #   puts beep.playing? #=> false
  #
  #   beep.play
  #   puts beep.playing? #=> true
  #
  #   #...
  #   beep.pause
  #   puts beep.playing? #=> false
  #
  #   #...
  #   beep.resume
  #   puts beep.playing? #=> true
  #
  # @return [Boolean]
  def playing?
    # mrb_Sound_playing
    # src/mruby_integration/models/sound.cpp
    true
  end

  # Set volume for the {Sound}.
  #
  # @example Basic usage
  #   beep = Sound.new("./assets/beep.wav")
  #   puts beep.volume #=> 1.0
  #   beep.volume = 0.9
  #   puts beep.volume #=> 0.9
  #
  # @param value [Float] A value between 0.0 and 1.0.
  # @return [Float]
  # @raise [ArgumentError] If the volume is out of bounds.
  def volume=(value)
    # mrb_Sound_set_volume
    # src/mruby_integration/models/sound.cpp
    0.5
  end

  # Set pitch for the {Sound}.
  #
  # @example Basic usage
  #   beep = Sound.new("./assets/beep.wav")
  #   puts beep.pitch #=> 1.0
  #   beep.pitch = 0.9
  #   puts beep.pitch #=> 0.9
  #   beep.pitch = 1.5
  #   puts beep.pitch #=> 1.5
  #
  # @param value [Float]
  # @return [Float]
  def pitch=(value)
    # mrb_Sound_set_pitch
    # src/mruby_integration/models/sound.cpp
    0.5
  end

  class NotFoundError < StandardError
  end
end
