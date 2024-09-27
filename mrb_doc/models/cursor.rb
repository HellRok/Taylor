# The {Cursor} class is used for management of your mouse cursor. It's handy
# for when you want to either completely disable the cursor or implement your
# own.
class Cursor
  # This will show the {Cursor} after it's been hidden.
  #
  # @example Basic usage
  #   Cursor.hide
  #   puts Cursor.hidden? #=> true
  #   #...
  #   Cursor.show
  #   puts Cursor.hidden? #=> false
  #
  # @return [nil]
  def self.show
    # mrb_Cursor_show
    # src/mruby_integration/models/cursor.cpp
    nil
  end

  # This will hide the {Cursor}, it will still operate as normal but the player
  # won't be able to see it.
  #
  # @example Basic usage
  #   puts Cursor.hidden? #=> false
  #   Cursor.hide
  #   puts Cursor.hidden? #=> true
  #
  # @return [nil]
  def self.hide
    # mrb_Cursor_hide
    # src/mruby_integration/models/cursor.cpp
    nil
  end

  # Check whether or not the {Cursor} is being hidden.
  #
  # @example Basic usage
  #   puts Cursor.hidden? #=> false
  #   Cursor.hide
  #   puts Cursor.hidden? #=> true
  #   #...
  #   Cursor.show
  #   puts Cursor.hidden? #=> false
  #
  # @return [Boolean]
  def self.hidden?
    # mrb_Cursor_hidden
    # src/mruby_integration/models/cursor.cpp
    true
  end

  # This will enable the {Cursor} after it's been disabled.
  #
  # @example Basic usage
  #   Cursor.disable
  #   puts Cursor.disabled? #=> true
  #   #...
  #   Cursor.enable
  #   puts Cursor.disabled? #=> false
  #
  # @return [nil]
  def self.enable
    # mrb_Cursor_enable
    # src/mruby_integration/models/cursor.cpp
    nil
  end

  # This will disable the {Cursor}, it will NOT operate as normal and no clicks
  # or movement will be reported.
  #
  # @example Basic usage
  #   puts Cursor.disabled? #=> false
  #   Cursor.disable
  #   puts Cursor.disabled? #=> true
  #
  # @return [nil]
  def self.disable
    # mrb_Cursor_disable
    # src/mruby_integration/models/cursor.cpp
    nil
  end

  # Check whether or not the {Cursor} is disabled.
  #
  # @example Basic usage
  #   puts Cursor.disabled? #=> false
  #   Cursor.disable
  #   puts Cursor.disabled? #=> true
  #   #...
  #   Cursor.enable
  #   puts Cursor.disabled? #=> false
  #
  # @return [Boolean]
  def self.disabled?
    # mrb_Cursor_disabled
    # src/mruby_integration/models/cursor.cpp
    true
  end

  # Check whether or not the {Cursor} is within the bounds of the {Window}.
  #
  # @example Basic usage
  #   puts Cursor.on_screen? #=> false
  #   # Player moves the mouse within the window
  #   puts Cursor.on_screen? #=> true
  #
  # @return [Boolean]
  def self.on_screen?
    # mrb_Cursor_on_screen
    # src/mruby_integration/models/cursor.cpp
    true
  end

  # Returns the currently used {Cursor} icon.
  #
  # @example Basic usage
  #   puts Cursor.icon #=> Cursor::DEFAULT
  #   Cursor.icon = Cursor::IBEAM
  #   puts Cursor.icon #=> Cursor::IBEAM
  #
  # @return [Integer]
  def self.icon
    # mrb_Cursor_icon
    # src/mruby_integration/models/cursor.cpp
    Cursor::DEFAULT
  end

  # Sets the {Cursor} icon.
  #
  # @example Basic usage
  #   puts Cursor.icon #=> Cursor::DEFAULT
  #   Cursor.icon = Cursor::IBEAM
  #   puts Cursor.icon #=> Cursor::IBEAM
  #
  # @param icon [Cursor::DEFAULT, Cursor::ARROW, Cursor::IBEAM, Cursor::CROSSHAIR, Cursor::POINTING_HAND, Cursor::RESIZE_EAST_WEST, Cursor::RESIZE_NORTH_SOUTH, Cursor::RESIZE_NORTH_WEST_TO_SOUTH_EAST, Cursor::RESIZE_NORTH_EAST_TO_S_OUTH_WEST, Cursor::RESIZE_ALL, Cursor::NOT_ALLOWED]
  # @return [Boolean]
  def self.icon=(icon)
    # mrb_Cursor_icon
    # src/mruby_integration/models/cursor.cpp
    Cursor::DEFAULT
  end
end
