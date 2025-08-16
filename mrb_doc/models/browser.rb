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
    # mrb_Browser_main_loop
    # src/mruby_integration/models/browser.cpp
    nil
  end

  # Cancels the main loop for web exports.
  #
  # @return [nil]
  # @raise [Taylor::Platform::MethodCalledOnInvalidPlatformError] If run on the wrong platform.
  def self.cancel_main_loop
    # mrb_Browser_main_loop
    # src/mruby_integration/models/browser.cpp
    nil
  end

  # Gets the attribute from the specified element. If it's a data attribute you
  # can just pass 'data-blah'.
  #
  # @example Basic usage
  #   # Given an element <div class="save-data" data-save-json="{...}"></div>
  #
  #   puts Browser.attribute_from_element(".save-data", "data-save-json")
  #   #=> "{...}"
  #
  #
  # @param selector [String]
  # @param attribute [String]
  # @return [String]
  # @raise [Taylor::Platform::MethodCalledOnInvalidPlatformError] If run on non-web platforms.
  def self.attribute_from_element(selector, attribute)
    # mrb_Browser_main_loop
    # src/mruby_integration/models/browser.cpp
    "data"
  end
end
