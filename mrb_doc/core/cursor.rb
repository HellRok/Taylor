# Shows the cursor
# @return [nil]
def show_cursor
  # mrb_show_cursor
  # src/mruby_integration/core/cursor.cpp
  nil
end

# Hides the cursor
# @return [nil]
def hide_cursor
  # mrb_hide_cursor
  # src/mruby_integration/core/cursor.cpp
  nil
end

# Checks if the cursor is hidden
# @return [Boolean]
def cursor_hidden?
  # mrb_cursor_hidden
  # src/mruby_integration/core/cursor.cpp
  true
end

# Enables and shows the cursor
# @return [nil]
def enable_cursor
  # mrb_enable_cursor
  # src/mruby_integration/core/cursor.cpp
  nil
end

# Disables the cursor and hides it
# @return [nil]
def disable_cursor
  # mrb_disable_cursor
  # src/mruby_integration/core/cursor.cpp
  nil
end

# Checks if the cursor is in the window
# @return [Boolean]
def cursor_on_screen?
  # mrb_cursor_on_screen
  # src/mruby_integration/core/cursor.cpp
  true
end
