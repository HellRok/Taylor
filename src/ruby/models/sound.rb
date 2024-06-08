# The Sound class holds shorter sounds, these are usually used for sound effects.
class Sound
  # @return [Float]
  attr_reader :volume, :pitch

  # Return the object represented by a Hash.
  # @return [Hash]
  def to_h
    {
      frame_count: frame_count,
      volume: volume,
      pitch: pitch
    }
  end

  # Is the sound currently playing?
  # @return [Boolean]
  def playing?
    sound_playing?(self)
  end

  # Set the volume.
  # @param value [Float] A value between 0 and 1.
  # @raise [ArgumentError] If the value is out of bounds.
  # @return [nil]
  def volume=(value)
    unless (0..1).cover?(value)
      raise ArgumentError, "Value must fall between 0 and 1, you gave me #{value}"
    end
    @volume = value

    set_sound_volume(self, value)
  end

  # Set the pitch.
  # @param value [Float]
  # @return [nil]
  def pitch=(value)
    @pitch = value
    set_sound_pitch(self, value)
  end

  # Used for alerting the user if the sound file was not found at the specified path.
  class NotFound < StandardError; end
end
