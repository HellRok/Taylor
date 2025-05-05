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

  # A method used to generate the mock data for Raylib.
  #
  # @example Basic usage
  #   Taylor::Raylib.mock_call(
  #     "LoadSound",
  #     Sound.mock_return(frame_count: 2240)
  #   )
  #
  # @param frame_count [Integer]
  # @return [String]
  def self.mock_return(frame_count: 1)
    frame_count.to_s
  end

  # Used for alerting the user if the sound file was not found at the specified path.
  class NotFound < StandardError; end
end
