class Sound
  attr_reader :frame_count, :volume, :pitch

  def to_h
    {
      frame_count: frame_count,
    }
  end

  def self.load(path)
    raise Sound::NotFound.new("Could not find file at path \"#{path}\"") unless File.exist?(path)
    load_sound(path).tap { |sound|
      sound.volume = 1
      sound.pitch = 1
    }
  end

  def unload
    unload_sound(self)
  end

  def play
    play_sound(self)
  end

  def stop
    stop_sound(self)
  end

  def pause
    pause_sound(self)
  end

  def resume
    resume_sound(self)
  end

  def playing?
    sound_playing?(self)
  end

  def volume=(value)
    unless (0..1).include?(value)
      raise ArgumentError, "Value must fall between 0 and 1, you gave me #{value}"
    end
    @volume = value

    set_sound_volume(self, value)
  end

  def pitch=(value)
    @pitch = value
    set_sound_pitch(self, value)
  end

  class NotFound < StandardError; end
end
