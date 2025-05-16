# The Music class holds longer format sound files, very useful for background music.
class Music
  # @return [Integer]
  attr_reader :context_type, :frame_count

  # @return [Float]
  attr_reader :volume, :pitch

  # Return the object represented by a Hash.
  # @return [Hash]
  def to_h
    {
      context_type: context_type,
      looping: looping,
      frame_count: frame_count,
      volume: volume,
      pitch: pitch
    }
  end

  # A method used to generate the mock data for Raylib.
  #
  # @example Basic usage
  #   Taylor::Raylib.mock_call(
  #     "LoadMusic",
  #     Music.mock_call(sample_rate: 1, sample_size: 2, channels: 3, frame_count: 4, looping: true, ctx_type: 5)
  #   )
  #
  # @param sample_rate [Integer]
  # @param sample_size [Integer]
  # @param channels [Integer]
  # @param frame_count [Integer]
  # @param looping [Boolean]
  # @param ctx_type [Integer]
  # @return [String]
  def self.mock_return(sample_rate: 0, sample_size: 0, channels: 0, frame_count: 0, looping: false, ctx_type: 0)
    [sample_rate, sample_size, channels, frame_count, looping, ctx_type].map(&:to_s).join(" ")
  end

  # Used for alerting the user if the music file was not found at the specified path.
  class NotFoundError < StandardError; end

  # Just a vanity class to make the types of music files read a little clearer.
  class Type
    # @!group Music formats

    # Music format none.
    NONE = 0
    # Music format WAV.
    WAV = 1
    # Music format OGG.
    OGG = 2
    # Music format FLAC.
    FLAC = 3
    # Music format MP3.
    MP3 = 4
    # Music format XM.
    XM = 5
    # Music format MO.
    MO = 6

    # @!endgroup
  end
end
