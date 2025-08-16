# A module for interfacing with the clipboard.
module Clipboard
  # Sets the text in the player's clipboard so they can paste it somewhere else.
  #
  # @example Basic usage
  #   Clipboard.text = "Emma scored 30 points!"
  #
  # @param text [String]
  # @return [nil]
  def self.text=(text)
    # mrb_Clipboard_set_text
    # src/mruby_integration/models/clipboard.cpp
    nil
  end

  # Gets the text from the player's clipboard. In the browser this always returns an empty string.
  #
  # @example Basic usage
  #   puts Clipboard.text
  #   #=> "Wow, Emma score so many points!"
  #
  # @return [nil]
  def self.text
    # mrb_Clipboard_text
    # src/mruby_integration/models/clipboard.cpp
    nil
  end
end
