# Enables and shows the cursor.
# @return [nil]
def enable_cursor
  # mrb_enable_cursor
  # src/mruby_integration/core/cursor.cpp
  nil
end

# Disables the cursor and hides it.
# @return [nil]
def disable_cursor
  # mrb_disable_cursor
  # src/mruby_integration/core/cursor.cpp
  nil
end

# Checks if the cursor is in the window.
# @return [Boolean]
def cursor_on_screen?
  # mrb_cursor_on_screen
  # src/mruby_integration/core/cursor.cpp
  true
end
