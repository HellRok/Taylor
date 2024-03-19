# The Music class holds longer format sound files, very useful for background music.
class Music
  # @return [Integer]
  attr_reader :context_type, :frame_count

  # @return [Float]
  attr_reader :volume, :pitch

  # @return [Boolean]
  attr_reader :looping

  # Return the object represented by a Hash.
  # @return [Hash]
  def to_h
    {
      context_type: context_type,
      looping: looping,
      frame_count: frame_count
    }
  end

  # Loads a music file from the specified path.
  # @param path [String]
  # @raise [Music::NotFound] If the file specified by path doesn't exist.
  # @return [Music]
  def self.load(path)
    raise Music::NotFound.new("Could not find file at path \"#{path}\"") unless File.exist?(path)
    load_music_stream(path).tap { |music|
      music.volume = 1
      music.pitch = 1
    }
  end

  # Unloads the music from memory.
  # @return [nil]
  def unload
    unload_music_stream(self)
  end

  # Starts playing the music.
  # @return [nil]
  def play
    play_music_stream(self)
  end

  # This method should be called every update to keep the music playing
  # smoothly.
  # @return [nil]
  def update
    update_music_stream(self)
  end

  # Is the music currently playing?
  # @return [Boolean]
  def playing?
    music_playing?(self)
  end

  # Stops the music, you will need to call {play} to start it again.
  # @return [nil]
  def stop
    stop_music_stream(self)
  end

  # Pauses the music, you will need to call {resume} to start it again.
  # @return [nil]
  def pause
    pause_music_stream(self)
  end

  # Resumes the music playing.
  # @return [nil]
  def resume
    resume_music_stream(self)
  end

  # How long does this music go for?
  # @return [Float]
  def length
    get_music_time_length(self)
  end

  # How long has the music been played for this loop?
  # @return [Float]
  def played
    get_music_time_played(self)
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
