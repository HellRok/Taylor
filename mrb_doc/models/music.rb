# Music format none
MUSIC_AUDIO_NONE = 0
# Music format wav
MUSIC_AUDIO_WAV  = 1
# Music format ogg
MUSIC_AUDIO_OGG  = 2
# Music format flac
MUSIC_AUDIO_FLAC = 3
# Music format mp3
MUSIC_AUDIO_MP3  = 4
# Music format xm
MUSIC_MODULE_XM  = 5
# Music format mo
MUSIC_MODULE_MO  = 6

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
end
