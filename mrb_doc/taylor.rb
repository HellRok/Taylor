# The {Taylor} module is used for getting information about your game.
module Taylor
  # Is this a release build of your game?
  #
  # @example Basic usage
  #   puts "Debug information!" unless Taylor::Platform.released?
  #
  # @return [Boolean]
  def self.released?
    # mrb_Taylor_Platform_released
    # src/taylor/platform.cpp
    false
  end
end
