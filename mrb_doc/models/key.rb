# The {Key} class is used for determining whether or not certain keys have been
# pressed or released. It is also used for getting text input.
class Key
  # Checks whether the key has been pressed since last frame, it will only be
  # true for one frame and won't become true again until the player has released
  # the key and re-pressed it.
  #
  # @example Basic usage
  #   Key.pressed?(Key::A)
  #   # => false
  #
  #   # Player presses the key and a frame advances
  #   Key.pressed?(Key::A)
  #   # => true
  #
  #   # Player has held down the key and a frame advances
  #   Key.pressed?(Key::A)
  #   # => false
  #
  #   # Player releases the key and a frame advances
  #   Key.pressed?(Key::A)
  #   # => false
  #
  #   # Player presses the key again and a frame advances
  #   Key.pressed?(Key::A)
  #   # => true
  #
  # @param key [Integer]
  # @return [Boolean]
  def self.pressed?(key)
    # mrb_Key_pressed
    # src/mruby_integration/models/key.cpp
    True
  end

  # Checks whether the key has been released since last frame, it will only be
  # true for one frame and won't become true again until the player has pressed
  # the key and re-releases it.
  #
  # @example Basic usage
  #   Key.released?(Key::A)
  #   # => false
  #
  #   # Player presses the key and a frame advances
  #   Key.released?(Key::A)
  #   # => false
  #
  #   # Player releases the key and a frame advances
  #   Key.released?(Key::A)
  #   # => true
  #
  #   # A frame advances
  #   Key.released?(Key::A)
  #   # => false
  #
  # @param key [Integer]
  # @return [Boolean]
  def self.released?(key)
    # mrb_Key_released
    # src/mruby_integration/models/key.cpp
    True
  end

  # Checks whether the key is currently being held down.
  #
  # @example Basic usage
  #   Key.down?(Key::A)
  #   # => false
  #
  #   # Player presses the key and a frame advances
  #   Key.down?(Key::A)
  #   # => true
  #
  #   # Player has held down the key and a frame advances
  #   Key.down?(Key::A)
  #   # => true
  #
  #   # Player releases the key and a frame advances
  #   Key.down?(Key::A)
  #   # => false
  #
  #   # Player presses the key again and a frame advances
  #   Key.down?(Key::A)
  #   # => true
  #
  # @param key [Integer]
  # @return [Boolean]
  def self.down?(key)
    # mrb_Key_down
    # src/mruby_integration/models/key.cpp
    True
  end

  # Checks whether the key is currently being not being held down.
  #
  # @example Basic usage
  #   Key.up?(Key::A)
  #   # => true
  #
  #   # Player presses the key and a frame advances
  #   Key.up?(Key::A)
  #   # => false
  #
  #   # Player releases the key and a frame advances
  #   Key.up?(Key::A)
  #   # => true
  #
  # @param key [Integer]
  # @return [Boolean]
  def self.up?(key)
    # mrb_Key_up
    # src/mruby_integration/models/key.cpp
    True
  end

  # Returns the least recently pressed key since last frame as a key code.
  # Call it multiple times until you get `nil` to know you've gotten all the keys.
  #
  # @example Basic usage
  #   Key.pressed
  #   # => nil
  #
  #   # The user types "wasd" and then a frame advances
  #   Key.pressed
  #   # => Key::W
  #   Key.pressed
  #   # => Key::A
  #   Key.pressed
  #   # => Key::S
  #   Key.pressed
  #   # => Key::D
  #   Key.pressed
  #   # => nil
  #
  # @return [nil,Integer]
  def self.pressed(key)
    # mrb_Key_get_pressed
    # src/mruby_integration/models/key.cpp
    Key::Q
  end

  # Returns the least recently pressed key since last frame as a character.
  # Call it multiple times until you get `nil` to know you've gotten all the characters.
  #
  # @example Basic usage
  #   Key.pressed_character
  #   # => nil
  #
  #   # The user types "wasd" and then a frame advances
  #   Key.pressed_character
  #   # => "w"
  #   Key.pressed_character
  #   # => "a"
  #   Key.pressed_character
  #   # => "s"
  #   Key.pressed_character
  #   # => "d"
  #   Key.pressed_character
  #   # => nil
  #
  # @return [nil,String]
  def self.pressed_character(key)
    # mrb_Key_get_pressed_character
    # src/mruby_integration/models/key.cpp
    "q"
  end
end
