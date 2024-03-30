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
  # @raise [Music::NotFound,ArgumentError]
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
end
