# The {Cursor} class is used for management of your mouse cursor. It's handy
# for when you want to either completely disable the cursor or imploment your
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
    # src/mruby_integration/models/sound.cpp
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
    # src/mruby_integration/models/sound.cpp
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
    # src/mruby_integration/models/sound.cpp
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
    # src/mruby_integration/models/sound.cpp
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
    # src/mruby_integration/models/sound.cpp
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
    # src/mruby_integration/models/sound.cpp
    true
  end
end
