# The Sound class holds shorter sounds, these are usually used for sound effects.
class Sound
  # @return [Integer]
  attr_reader :frame_count

  # @return [Float]
  attr_reader :volume, :pitch

  # Return the object represented by a Hash
  # @return [Hash]
  def to_h
    {
      frame_count: frame_count
    }
  end

  # Loads a sound file from the specified path
  # @param path [String]
  # @raise [Sound::NotFound] If the file specified by path doesn't exist
  # @return [Sound]
  def self.load(path)
    raise Sound::NotFound.new("Could not find file at path \"#{path}\"") unless File.exist?(path)
    load_sound(path).tap { |sound|
      sound.volume = 1
      sound.pitch = 1
    }
  end

  # Unloads the sound from memory
  # @return [nil]
  def unload
    unload_sound(self)
  end

  # Starts playing the sound
  # @return [nil]
  def play
    play_sound(self)
  end

  # Stops the sound, you will need to call Sound#play to start it again.
  # @return [nil]
  def stop
    stop_sound(self)
  end

  # Pauses the sound, you will need to call Sound#resume to start it again
  # @return [nil]
  def pause
    pause_sound(self)
  end

  # Resumes the sound
  # @return [nil]
  def resume
    resume_sound(self)
  end

  # Is the sound currently playing?
  # @return [Boolean]
  def playing?
    sound_playing?(self)
  end

  # Set the volume
  # @param value [Float] a value between 0 and 1
  # @raise [ArgumentError] If the value is out of bounds
  # @return [nil]
  def volume=(value)
    unless (0..1).cover?(value)
      raise ArgumentError, "Value must fall between 0 and 1, you gave me #{value}"
    end
    @volume = value

    set_sound_volume(self, value)
  end

  # Set the pitch
  # @param value [Float]
  # @return [nil]
  def pitch=(value)
    @pitch = value
    set_sound_pitch(self, value)
  end

  # Used for alerting the user the sound file was not found at the specified path
  class NotFound < StandardError; end
end
