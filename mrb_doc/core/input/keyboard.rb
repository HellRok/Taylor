# Sets the key that {window_should_close?} should listen for.
# @param key [Integer]
# @return [nil]
def set_exit_key(key)
  # mrb_set_exit_key
  # src/mruby_integration/core/input/keyboard.cpp
  nil
end

# Returns the charcode for the pressed key, call it multiple times for queued keys.
# @return [Integer]
def get_char_pressed
  # mrb_getchar_pressed
  # src/mruby_integration/core/input/keyboard.cpp
  64
end
