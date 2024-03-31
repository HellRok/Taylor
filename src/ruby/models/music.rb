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

  # How long does this music go for?
  # @return [Float]
  def length
    get_music_time_length(self)
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

    set_music_volume(self, value)
  end

  # Set the pitch.
  # @param value [Float]
  # @return [nil]
  def pitch=(value)
    @pitch = value
    set_music_pitch(self, value)
  end

  # Used for alerting the user if the music file was not found at the specified path.
  class NotFound < StandardError; end

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
