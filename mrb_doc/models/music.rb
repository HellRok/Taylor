
# The Music class holds longer format sound files, very useful for background music.
class Music
  # @return [Integer]
  attr_reader :context_type, :sample_count

  # @return [Boolean]
  attr_reader :looping

  # Creates a new instance of Music
  # @param context_type [Integer] A value between 0 and 6
  # @param looping [Boolean]
  # @param sample_count [Integer]
  # @return [Music]
  def initialize(context_type, looping, sample_count)
    # mrb_Music_initialize
    # src/mruby_integration/models/music.cpp
    Music.new
  end

  def context_type=(context_type)
    # mrb_Music_set_context_type
    # src/mruby_integration/models/music.cpp
    MUSIC_AUDIO_OGG
  end

  def looping=(looping)
    # mrb_Music_set_looping
    # src/mruby_integration/models/music.cpp
    true
  end

  def sample_count=(sample_count)
    # mrb_Music_set_sample_count
    # src/mruby_integration/models/music.cpp
    1
  end

  # Return the object represented by a Hash
  # @return [Hash]
  def to_h
    # src/mruby_integration/models/music.cpp
    {
      context_type: context_type,
      looping: looping,
      sample_count: sample_count,
    }
  end

  # Loads a music file from the specified path
  # @param path [String]
  # @raise [Music::NotFound] If the file specified by path doesn't exist
  # @return [Music]
  def self.load(path)
    # src/mruby_integration/models/music.cpp
    Music.new
  end

  # Unloads the texture from memory
  # @return [nil]
  def unload
    # src/mruby_integration/models/music.cpp
    nil
  end

  # Starts playing the music
  # @return [nil]
  def play
    # src/mruby_integration/models/music.cpp
    nil
  end

  # This method should be called every update to keep the music playing
  # smoothly
  # @return [nil]
  def update
    # src/mruby_integration/models/music.cpp
    nil
  end

  # Is the music currently playing?
  # @return [Boolean]
  def playing?
    # src/mruby_integration/models/music.cpp
    true
  end

  # Stops the music, you will need to call Music#play to start it again
  # @return [nil]
  def stop
    # src/mruby_integration/models/music.cpp
    nil
  end

  # Pauses the music, you will need to call Music#resume to start it again
  # @return [nil]
  def pause
    # src/mruby_integration/models/music.cpp
    nil
  end

  # Resumes the music playing
  # @return [nil]
  def resume
    # src/mruby_integration/models/music.cpp
    nil
  end

  # How long does this music go for?
  # @return [Float]
  def length
    # src/mruby_integration/models/music.cpp
    3.14
  end

  # How long has the music been played for this loop?
  # @return [Float]
  def played
    # src/mruby_integration/models/music.cpp
    2.17
  end

  # Set the volume
  # @param value [Float] a value between 0 and 1
  # @raise [ArgumentError] If the value is out of bounds
  # @return [nil]
  def volume=(value)
    # src/mruby_integration/models/music.cpp
    nil
  end

  # Set the pitch
  # @param value [Float]
  # @return [nil]
  def pitch=(value)
    # src/mruby_integration/models/music.cpp
    nil
  end

  # Used for alerting the user the music file was not found at the specified path
  class NotFound < StandardError; end

  # Just a vanity class to make the types of music files read a little clearer.
  class Type
    # Music format none
    NONE = 0
    # Music format wav
    WAV  = 1
    # Music format ogg
    OGG  = 2
    # Music format flac
    FLAC = 3
    # Music format mp3
    MP3  = 4
    # Music format xm
    XM   = 5
    # Music format mo
    MO   = 6
  end
end
