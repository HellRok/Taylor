# A module for interfacing with the clip board.
module Clipboard
  # Sets the text in the player's clip board so they can paste it somewhere else.
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
end
