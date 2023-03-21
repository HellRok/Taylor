# The Sound class holds shorter sounds, these are usually used for sound effects.
class Sound
  # @return [Integer]
  attr_reader :frame_count

  # @return [Float]
  attr_reader :volume, :pitch

  # Creates a new instance of Sound
  # @param frame_count [Integer]
  # @return [Sound]
  def initialize(frame_count)
    # mrb_Sound_initialize
    # src/mruby_integration/models/sound.cpp
    Sound.new
  end

  def frame_count=(frame_count)
    # mrb_Sound_set_frame_count
    # src/mruby_integration/models/sound.cpp
    1
  end

  # Return the object represented by a Hash
  # @return [Hash]
  def to_h
    # src/mruby_integration/models/sound.cpp
    {
      frame_count: frame_count,
    }
  end

  # Loads a sound file from the specified path
  # @param path [String]
  # @raise [Sound::NotFound] If the file specified by path doesn't exist
  # @return [Sound]
  def self.load(path)
    # src/mruby_integration/models/sound.cpp
    Sound.new
  end

  # Unloads the sound from memory
  # @return [nil]
  def unload
    # src/mruby_integration/models/sound.cpp
    nil
  end

  # Starts playing the sound
  # @return [nil]
  def play
    # src/mruby_integration/models/music.cpp
    nil
  end

  # Is the sound currently playing?
  # @return [Boolean]
  def playing?
    # src/mruby_integration/models/sound.cpp
    true
  end

  # Stops the sound, you will need to call Sound#play to start it again.
  # @return [nil]
  def stop
    # src/mruby_integration/models/sound.cpp
    nil
  end

  # Pauses the sound, you will need to call Sound#resume to start it again
  # @return [nil]
  def pause
    # src/mruby_integration/models/sound.cpp
    nil
  end

  # Resumes the sound
  # @return [nil]
  def resume
    # src/mruby_integration/models/sound.cpp
    nil
  end

  # Set the volume
  # @param value [Float] a value between 0 and 1
  # @raise [ArgumentError] If the value is out of bounds
  # @return [nil]
  def volume=(value)
    # src/mruby_integration/models/sound.cpp
    nil
  end

  # Set the pitch
  # @param value [Float]
  # @return [nil]
  def pitch=(value)
    # src/mruby_integration/models/sound.cpp
    nil
  end

  # Used for alerting the user the sound file was not found at the specified path
  class NotFound < StandardError; end
end
