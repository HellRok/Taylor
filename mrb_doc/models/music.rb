class Music
  # Creates a new instance of Music
  # @param context_type [Integer] A value between 0 and 6
  # @param looping [Boolean]
  # @param frame_count [Integer]
  # @return [Music]
  def initialize(context_type, looping, frame_count)
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

  def frame_count=(frame_count)
    # mrb_Music_set_frame_count
    # src/mruby_integration/models/music.cpp
    1
  end
end
