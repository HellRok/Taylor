class Music
  attr_reader :context_type, :looping, :frame_count, :volume, :pitch

  def to_h
    {
      context_type: context_type,
      looping: looping,
      frame_count: frame_count,
    }
  end

  def self.load(path)
    raise Music::NotFound.new("Could not find file at path \"#{path}\"") unless File.exist?(path)
    load_music_stream(path).tap { |music|
      music.volume = 1
      music.pitch = 1
    }
  end

  def unload
    unload_music_stream(self)
  end

  def play
    play_music_stream(self)
  end

  def update
    update_music_stream(self)
  end

  def playing?
    music_playing?(self)
  end

  def stop
    stop_music_stream(self)
  end

  def pause
    pause_music_stream(self)
  end

  def resume
    resume_music_stream(self)
  end

  def length
    get_music_time_length(self)
  end

  def played
    get_music_time_played(self)
  end

  def volume=(value)
    unless (0..1).include?(value)
      raise ArgumentError, "Value must fall between 0 and 1, you gave me #{value}"
    end
    @volume = value

    set_music_volume(self, value)
  end

  def pitch=(value)
    @pitch = value
    set_music_pitch(self, value)
  end

  class NotFound < StandardError; end
  class Type
    NONE = 0
    WAV  = 1
    OGG  = 2
    FLAC = 3
    MP3  = 4
    XM   = 5
    MO   = 6
  end
end
