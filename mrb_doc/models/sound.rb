# The Sound class holds shorter sounds, these are usually used for sound effects.
class Sound
  # @return [Integer]
  attr_reader :sample_count

  # Creates a new instance of Sound
  # @param sample_count [Integer]
  # @return [Sound]
  def initialize(sample_count)
    # mrb_Sound_initialize
    # src/mruby_integration/models/sound.cpp
    Sound.new
  end

  def sample_count=(sample_count)
    # mrb_Sound_set_sample_count
    # src/mruby_integration/models/sound.cpp
    1
  end

  # Return the object represented by a Hash
  # @return [Hash]
  def to_h
    # src/mruby_integration/models/sound.cpp
    {
      sample_count: sample_count,
    }
  end
end
