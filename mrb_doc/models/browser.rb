# A module for interfacing with the web browser.
module Browser
  # Opens the URL in the player's default web browser.
  #
  # @example Basic usage
  #   Browser.open("https://taylormadetech.dev")
  #
  # @param url [String]
  # @return [nil]
  def self.open(url)
    # mrb_Browser_open
    # src/mruby_integration/models/browser.cpp
    nil
  end

  # Sets the main loop for web exports.
  #
  # @example Basic usage
  #   def main
  #     # Game logic goes here
  #   end
  #
  #   Browser.main_loop = "main"
  #
  # @param method [String]
  # @return [nil]
  # @raise [Taylor::Platform::MethodCalledOnInvalidPlatformError] If run on the wrong platform.
  def self.main_loop=(method)
    # mrb_set_main_loop
    # src/web.cpp
    nil
  end

  # Cancels the main loop for web exports.
  #
  # @return [nil]
  # @raise [Taylor::Platform::MethodCalledOnInvalidPlatformError] If run on the wrong platform.
  def self.cancel_main_loop
    # mrb_cancel_main_loop
    # src/web.cpp
    nil
  end
end
