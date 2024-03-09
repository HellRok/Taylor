# Has the specified key been pressed since last frame?
# @param key [Integer]
# @return [Boolean]
def key_pressed?(key)
  # mrb_key_pressed
  # src/mruby_integration/core/input/keyboard.cpp
  True
end

# Is the specified key down?
# @param key [Integer]
# @return [Boolean]
def key_down?(key)
  # mrb_key_down
  # src/mruby_integration/core/input/keyboard.cpp
  True
end

# Has the specified key been released since last frame?
# @param key [Integer]
# @return [Boolean]
def key_released?(key)
  # mrb_key_released
  # src/mruby_integration/core/input/keyboard.cpp
  False
end

# Is the specified key not down?
# @param key [Integer]
# @return [Boolean]
def key_up?(key)
  # mrb_key_up
  # src/mruby_integration/core/input/keyboard.cpp
  False
end

<<<<<<< HEAD
# Sets the key for should_window_close? to listen for.
=======
# Sets the key for {window_should_close?} to listen for.
>>>>>>> aea7c7f62eefa36f5930ba95057904e50b2036d4
# @param key [Integer]
# @return [nil]
def set_exit_key(key)
  # mrb_set_exit_key
  # src/mruby_integration/core/input/keyboard.cpp
  nil
end

# Returns the keycode for the pressed key, call it multiple times for queued keys.
# @return [Integer]
def get_key_pressed
  # mrb_get_key_pressed
  # src/mruby_integration/core/input/keyboard.cpp
  64
end

# Returns the charcode for the pressed key, call it multiple times for queued keys.
# @return [Integer]
def get_char_pressed
  # mrb_getchar_pressed
  # src/mruby_integration/core/input/keyboard.cpp
  64
end
