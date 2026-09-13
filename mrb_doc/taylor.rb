# The {Taylor} module is used for getting information about your game.
module Taylor
  # The directory the game launched from
  WORKING_DIRECTORY = "/home/sean/my_cool_game"

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
