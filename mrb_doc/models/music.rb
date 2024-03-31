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
end
