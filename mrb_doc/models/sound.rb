class Sound
  # Creates a new instance of {Sound}. If the file does not exist it will raise
  # {Sound::NotFound}.
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
  # @raise [Sound::NotFound] Raised when the file to load is not found.
  # @raise [ArgumentError] Raised when passing an invalid volume.
  def initialize(path, volume: 1.0, pitch: 1.0)
    # mrb_Sound_initialize
    # src/mruby_integration/models/sound.cpp
    Sound.new
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

  # Returns the frame_count for the {Sonud} object.
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

  class NotFound < StandardError
  end
end
