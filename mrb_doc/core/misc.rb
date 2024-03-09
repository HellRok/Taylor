# You'll want to call this function after you've called {end_drawing} or you'll
# find that you don't get everything that you think you've drawn.
# @param filename [String] The filename to save to. The extension will dictate how it is saved.
# @return [nil]
def take_screenshot(filename)
  # mrb_take_screenshot
  # src/mruby_integration/core/misc.cpp
  nil
end

# Enable specific config flags.
# @example Passing multiple flags.
#   set_config_flags(FLAG_WINDOW_TOPMOST | FLAG_WINDOW_RESIZABLE)
# @param flags [Integer]
# @return [nil]
def set_config_flags(flags)
  # mrb_set_config_flags
  # src/mruby_integration/core/misc.cpp
  nil
end

# Sets the logging level.
# @param level [Integer] A value between 0 and 5.
# @return [nil]
def set_trace_log_level(level)
  # mrb_set_trace_log_level
  # src/mruby_integration/core/misc.cpp
  nil
end

# Opens the URL in the user's browser.
# @param url [String]
# @return [nil]
def open_url(url)
  # mrb_open_url
  # src/mruby_integration/core/misc.cpp
  nil
end

# Sets the clipboard value.
# @param text [String]
# @return [nil]
def set_clipboard_text(text)
  # mrb_set_clipboard_text
  # src/mruby_integration/core/misc.cpp
  nil
end

# Gets the clipboard value.
# @return [String]
def get_clipboard_text
  # mrb_get_clipboard_text
  # src/mruby_integration/core/misc.cpp
  "Clipboard Text"
end
