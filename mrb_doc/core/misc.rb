# Enable specific config flags.
# @example Passing multiple flags
#   set_config_flags(FLAG_WINDOW_TOPMOST | FLAG_WINDOW_RESIZABLE)
# @param flags [Integer]
# @return [nil]
def set_config_flags(flags)
  # mrb_set_config_flags
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
