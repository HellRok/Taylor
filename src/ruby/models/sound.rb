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

  # Used for alerting the user if the sound file was not found at the specified path.
  class NotFound < StandardError; end
end
