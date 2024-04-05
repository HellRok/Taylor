class Music
  # Creates a new instance of {Music}. If the file does not exist it will raise
  # {Music::NotFound}.
  #
  # @example Basic usage
  #   music = Music.new("./assets/background_music.ogg")
  #
  # @example Basic usage with lower volume
  #   music = Music.new("./assets/background_music.ogg", volume: 0.75)
  #
  # @param looping [Boolean]
  # @param volume [Float] A value between 0.0 and 1.0.
  # @param pitch [Float] A value between 0.0 and 1.0.
  # @return [Music]
  # @raise [Music::NotFound] Raised when the file to load is not found.
  # @raise [ArgumentError] Raised when passing an invalid volume or pitch.
  def initialize(path, looping: true, volume: 1.0, pitch: 1.0)
    # mrb_Music_initialize
    # src/mruby_integration/models/music.cpp
    Music.new
  end

  # Unloads the {Music} from memory.
  #
  # @example Basic usage
  #   music = Music.new("./assets/background_music.ogg")
  #   # ...
  #   # The rest of the game
  #   # ...
  #   music.unload
  #
  # @return [nil]
  def unload
    # mrb_Music_unload
    # src/mruby_integration/models/music.cpp
    nil
  end

  # Sets the `looping` of the {Music} object.
  #
  # @example Basic usage
  #   music = Music.new("./assets/background_music.ogg", looping: false)
  #   # ...
  #   # Later on we want to actually loop it
  #   music.looping = true
  #
  # @return [Boolean]
  def looping=(looping)
    # mrb_Music_set_looping
    # src/mruby_integration/models/music.cpp
    true
  end

  # Gets the `looping` of the {Music} object.
  #
  # @example Basic usage
  #   music = Music.new("./assets/background_music.ogg", looping: true)
  #   puts music.looping #=> true
  #
  # @return [Boolean]
  def looping
    # mrb_Music_get_looping
    # src/mruby_integration/models/music.cpp
    true
  end

  # Starts playing the {Music} from the beginning.
  #
  # @example Basic usage
  #   music = Music.new("./assets/background_music.ogg")
  #   music.play
  #
  # @return [nil]
  # @raise [Audio::NotOpen] Raised when trying to set the volume before opening the {Audio} system.
  def play
    # mrb_Music_play
    # src/mruby_integration/models/music.cpp
    nil
  end

  # Is the {Music} currently playing?
  #
  # @example Basic usage
  #   music = Music.new("./assets/background_music.ogg")
  #   puts music.playing #=> false
  #   music.play
  #   puts music.playing #=> true
  #
  # @return [Boolean]
  def playing?
    # mrb_Music_playing
    # src/mruby_integration/models/music.cpp
    true
  end

  # Stops the {Music}, you will need to call {Music#play} to start it again.
  #
  # @example Basic usage
  #   music = Music.new("./assets/background_music.ogg")
  #   music.play
  #   music.stop
  #
  # @return [nil]
  def stop
    # mrb_Music_stop
    # src/mruby_integration/models/music.cpp
    nil
  end

  # Returns how long the {Music} has been played for in seconds this loop.
  #
  # @example Basic usage
  #   music = Music.new("./assets/background_music.ogg")
  #   puts music.played #=> 0.0
  #   music.play
  #   # ...
  #   # Some time has passed
  #   puts music.played #=> 87.45
  #
  # @return [Float]
  def played
    # mrb_Music_played
    # src/mruby_integration/models/music.cpp
    16.76
  end

  # This method must be called every update to keep the {Music} playing
  # smoothly.
  #
  # @example Basic usage
  #   Audio.open
  #   music = Music.new("./assets/background_music.ogg")
  #   music.play
  #
  #   until window_should_close?
  #     music.update
  #
  #     draw do
  #       # Render all the things
  #     end
  #   end
  #
  #   Audio.close
  #
  # @return [nil]
  def update
    # mrb_Music_played
    # src/mruby_integration/models/music.cpp
    nil
  end

  # Pauses the {Music}, you will need to call {Music#resume} to start it again.
  #
  # @example Basic usage
  #   Audio.open
  #   music = Music.new("./assets/background_music.ogg")
  #   music.play
  #   music.pause
  #   # ...
  #   music.resume
  #
  #   Audio.close
  #
  # @return [nil]
  def pause
    # mrb_Music_pause
    # src/mruby_integration/models/music.cpp
    nil
  end

  # Resumes the {Music} playing.
  #
  # @example Basic usage
  #   Audio.open
  #   music = Music.new("./assets/background_music.ogg")
  #   music.play
  #   music.pause
  #   # ...
  #   music.resume
  #
  #   Audio.close
  #
  # @return [nil]
  def resume
    # mrb_Music_resume
    # src/mruby_integration/models/music.cpp
    nil
  end

  # Returns how long the {Music} goes for in seconds.
  #
  # @example Basic usage
  #   music = Music.new("./assets/background_music.ogg")
  #   puts music.length #=> 36.35
  #
  # @return [Float]
  def length
    # mrb_Music_length
    # src/mruby_integration/models/music.cpp
    36.35
  end
end
