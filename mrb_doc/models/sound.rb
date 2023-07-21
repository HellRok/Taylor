class Sound
  # Creates a new instance of Sound
  # @param frame_count [Integer]
  # @return [Sound]
  def initialize(frame_count)
    # mrb_Sound_initialize
    # src/mruby_integration/models/sound.cpp
    Sound.new
  end

  def frame_count=(frame_count)
    # mrb_Sound_set_frame_count
    # src/mruby_integration/models/sound.cpp
    1
  end
end
