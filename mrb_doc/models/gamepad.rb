class Gamepad
  # return [Integer]
  attr_reader :index

  # Do not use this method directly, instead use {Gamepad.[]} or {Gamepad.all}
  #
  # @param index [Integer]
  # @return [Gamepad]
  def initialize(index:)
    # mrb_Gamepad_initialize
    # src/mruby_integration/models/gamepad.cpp
    Gamepad[0]
  end

  # Used for checking if the {Gamepad} at this index is still available for use.
  #
  # @example Basic usage
  #   player_one = Gamepad[0]
  #   player_two = Gamepad[1]
  #
  #   puts player_one.available? #=> true
  #   puts player_two.available? #=> true
  #
  #   # After a heated argument, player two gets unplugged
  #
  #   puts player_one.available? #=> true
  #   puts player_two.available? #=> false
  #
  # @return [Boolean]
  def available?
    # mrb_Gamepad_available
    # src/mruby_integration/models/gamepad.cpp
    true
  end
end
