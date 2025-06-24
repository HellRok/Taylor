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

  # Returns the name of the {Gamepad}
  #
  # @example Basic usage
  #   player_one = Gamepad[0]
  #   player_two = Gamepad[1]
  #
  #   puts player_one.name #=> "X-box controller"
  #   puts player_two.name #=> "Gamecube controller"
  #
  # @return [String]
  def name
    # mrb_Gamepad_name
    # src/mruby_integration/models/gamepad.cpp
    "Gamecube controller"
  end

  # Has the specified button on the {Gamepad} pressed since last frame?
  #
  # @example Basic usage
  #   gamepad = Gamepad[0]
  #
  #   puts gamepad.pressed?(Gamepad::Button::LEFT) #=> true
  #   puts gamepad.pressed?(Gamepad::Dpad::UP) #=> true
  #
  # @return [Boolean]
  def pressed?
    # mrb_Gamepad_pressed
    # src/mruby_integration/models/gamepad.cpp
    true
  end

  # Has the specified button on the {Gamepad} released since last frame?
  #
  # @example Basic usage
  #   gamepad = Gamepad[0]
  #
  #   puts gamepad.released?(Gamepad::Button::UP) #=> true
  #   puts gamepad.released?(Gamepad::Dpad::LEFT) #=> true
  #
  # @return [Boolean]
  def released?
    # mrb_Gamepad_released
    # src/mruby_integration/models/gamepad.cpp
    true
  end

  # Is the specified button on the {Gamepad} being held down?
  #
  # @example Basic usage
  #   gamepad = Gamepad[0]
  #
  #   puts gamepad.down?(Gamepad::Trigger::LEFT_1) #=> true
  #   puts gamepad.down?(Gamepad::Dpad::RIGHT) #=> true
  #
  # @return [Boolean]
  def down?
    # mrb_Gamepad_down
    # src/mruby_integration/models/gamepad.cpp
    true
  end

  # Is the specified button on the {Gamepad} not being held down?
  #
  # @example Basic usage
  #   gamepad = Gamepad[0]
  #
  #   puts gamepad.up?(Gamepad::Trigger::LEFT_1) #=> true
  #   puts gamepad.up?(Gamepad::Dpad::RIGHT) #=> true
  #
  # @return [Boolean]
  def up?
    # mrb_Gamepad_up
    # src/mruby_integration/models/gamepad.cpp
    true
  end

  # How many axis are there on this {Gamepad}? There will be two per joystick
  # (vertical and horizontal) and one for each shoulder button with pressure
  # sensitivity.
  #
  # @example Basic usage
  #   gamepad = Gamepad[0]
  #
  #   puts gamepad.axis_count #=> 6
  #
  # @return [Integer]
  def axis_count
    # mrb_Gamepad_axis_count
    # src/mruby_integration/models/gamepad.cpp
    6
  end

  # Returns a float between -1.0 and 1.0 for how far this axis has moved, for a
  # joystick this will be how far left/right or up/down it has been tilted with
  # 0 being the centre.
  #
  # @example Basic usage
  #   gamepad = Gamepad[0]
  #
  #   puts gamepad.axis(0) #=> 0.98
  #   puts gamepad.axis(1) #=> -0.023
  #
  # @param axis [Integer]
  # @return [Float] -1.0 to 1.0
  # @raise [ArgumentError] If you try to access an axis that doesn't exist
  def axis(index)
    # mrb_Gamepad_axis
    # src/mruby_integration/models/gamepad.cpp
    0.98
  end
end
