# This class is used for managing your {Window} and retrieving any information
# about it.
class Window
  # Should the {Window} try to enable [V-Sync](https://en.wikipedia.org/wiki/Screen_tearing#Vertical_synchronization)?
  #
  # @example Basic usage
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   puts Window.vsync_hinted?
  #   # => false
  #
  #   Window.flags = Window::Flag::VSYNC_HINT
  #
  #   puts Window.vsync_hinted?
  #   # => true
  #
  # @return [Boolean]
  def self.vsync_hinted? = Window.flag?(Window::Flag::VSYNC_HINT)

  # Should the {Window} try to enable [MSAA 4x](https://en.wikipedia.org/wiki/Multisample_anti-aliasing)?
  #
  # @example Basic usage
  #   Window.config = Window::Flag::MSAA_4X_HINT
  #
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   puts Window.msaa_4x_hinted?
  #   # => true
  #
  # @return [Boolean]
  def self.msaa_4x_hinted? = Window.flag?(Window::Flag::MSAA_4X_HINT)

  # Should the {Window} try to enable interlacing?
  #
  # @example Basic usage
  #   Window.config = Window::Flag::INTERLACED_HINT
  #
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   puts Window.interlaced_hinted?
  #   # => true
  #
  # @return [Boolean]
  def self.interlaced_hinted? = Window.flag?(Window::Flag::INTERLACED_HINT)

  # Is the {Window} fullscreen?
  #
  # @example Basic usage
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   puts Window.fullscreen?
  #   # => false
  #
  #   Window.flags = Window::Flag::RESIZABLE | Window::Flag::FULLSCREEN
  #
  #   puts Window.fullscreen?
  #   # => true
  #
  # @return [Boolean]
  def self.fullscreen? = Window.flag?(Window::Flag::FULLSCREEN)

  # Is the {Window} resizable?
  #
  # @example Basic usage
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   puts Window.resizable?
  #   # => false
  #
  #   Window.flags = Window::Flag::RESIZABLE
  #
  #   puts Window.resizable?
  #   # => true
  #
  # @return [Boolean]
  def self.resizable? = Window.flag?(Window::Flag::RESIZABLE)

  # Is the {Window} undecorated?
  #
  # @example Basic usage
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   puts Window.undecorated?
  #   # => false
  #
  #   Window.flags = Window::Flag::UNDECORATED
  #
  #   puts Window.undecorated?
  #   # => true
  #
  # @return [Boolean]
  def self.undecorated? = Window.flag?(Window::Flag::UNDECORATED)

  # Is the {Window} hidden?
  #
  # @example Basic usage
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   puts Window.hidden?
  #   # => false
  #
  #   Window.flags = Window::Flag::HIDDEN
  #
  #   puts Window.hidden?
  #   # => true
  #
  # @return [Boolean]
  def self.hidden? = Window.flag?(Window::Flag::HIDDEN)

  # Is the {Window} minimised?
  #
  # @example Basic usage
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   puts Window.minimised?
  #   # => false
  #
  #   Window.flags = Window::Flag::MINIMISED
  #
  #   puts Window.minimised?
  #   # => true
  #
  # @return [Boolean]
  def self.minimised? = Window.flag?(Window::Flag::MINIMISED)

  # Is the {Window} maximised?
  #
  # @example Basic usage
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   puts Window.maximised?
  #   # => false
  #
  #   Window.flags = Window::Flag::MAXIMISED
  #
  #   puts Window.maximised?
  #   # => true
  #
  # @return [Boolean]
  def self.maximised? = Window.flag?(Window::Flag::MAXIMISED)

  # Is the {Window} unfocused?
  #
  # @example Basic usage
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   puts Window.unfocused?
  #   # => false
  #
  #   # The player clicks away to check Mastodon...
  #
  #   puts Window.unfocused?
  #   # => true
  #
  # @return [Boolean]
  def self.unfocused? = Window.flag?(Window::Flag::UNFOCUSED)

  # Is the {Window} focused?
  #
  # @example Basic usage
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   puts Window.focused?
  #   # => true
  #
  #   # The player clicks away to check Peertube...
  #
  #   puts Window.focused?
  #   # => false
  #
  # @return [Boolean]
  def self.focused? = !Window.unfocused?

  # Is the {Window} always going to be on top of other windows?
  #
  # @example Basic usage
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   puts Window.always_on_top?
  #   # => false
  #
  #   Window.flags = Window::Flag::ALWAYS_ON_TOP
  #
  #   puts Window.always_on_top?
  #   # => true
  #
  # @return [Boolean]
  def self.always_on_top? = Window.flag?(Window::Flag::ALWAYS_ON_TOP)

  # Should the {Window} run while minimised?
  #
  # @example Basic usage
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   puts Window.always_run?
  #   # => false
  #
  #   Window.flags = Window::Flag::ALWAYS_RUN
  #
  #   puts Window.always_run?
  #   # => true
  #
  # @return [Boolean]
  def self.always_run? = Window.flag?(Window::Flag::ALWAYS_RUN)

  # Should the {Window} allow transparency so you can see windows behind it?
  #
  # @example Basic usage
  #   Window.config = Window::Flag::TRANSPARENT
  #
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   puts Window.transparent?
  #   # => true
  #
  # @return [Boolean]
  def self.transparent? = Window.flag?(Window::Flag::TRANSPARENT)

  # Should the {Window} run in high DPI mode?
  #
  # @example Basic usage
  #   Window.config = Window::Flag::HIGH_DPI
  #
  #   Window.open(
  #     width: 1920,
  #     height: 1080,
  #     title: "My super cool game!"
  #   )
  #
  #   puts Window.high_dpi?
  #   # => true
  #
  # @return [Boolean]
  def self.high_dpi? = Window.flag?(Window::Flag::HIGH_DPI)

  # This class holds all the constants for {Window} flags.
  class Flag
    # @!group Window flags

    # Set to try enabling [V-Sync](https://en.wikipedia.org/wiki/Screen_tearing#Vertical_synchronization) on GPU.
    VSYNC_HINT = 0x00000040
    # @note Must be set with {Window.config=} before calling {Window.open}
    # Set to try enabling [MSAA 4x](https://en.wikipedia.org/wiki/Multisample_anti-aliasing).
    MSAA_4X_HINT = 0x00000020
    # @note Must be set with {Window.config=} before calling {Window.open}
    # Set to try enabling interlaced video format (for V3D).
    INTERLACED_HINT = 0x00010000

    # Set to run program in fullscreen.
    FULLSCREEN = 0x00000002
    # Set to allow resizable window.
    RESIZABLE = 0x00000004
    # Set to disable window decoration (frame and buttons).
    UNDECORATED = 0x00000008
    # Set to hide window.
    HIDDEN = 0x00000080
    # Set to minimize window (iconify).
    MINIMISED = 0x00000200
    # Set to maximize window (expanded to monitor).
    MAXIMISED = 0x00000400
    # Set to window non focused.
    UNFOCUSED = 0x00000800
    # Set to window always on top.
    ALWAYS_ON_TOP = 0x00001000
    # Set to allow windows running while minimized.
    ALWAYS_RUN = 0x00000100
    # @note Must be set with {Window.config=} before calling {Window.open}
    # Set to allow transparent framebuffer.
    TRANSPARENT = 0x00000010
    # @note Must be set with {Window.config=} before calling {Window.open}
    # Set to support HighDPI.
    HIGH_DPI = 0x00002000

    # @!endgroup
  end
end
