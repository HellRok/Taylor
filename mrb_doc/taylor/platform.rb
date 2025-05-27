module Taylor
  module Platform
    # Returns the current operating system or platform we're running on.
    # Possible values are ':android', ':browser', ':linux', ':osx', and ':windows'.
    #
    # @example Basic usage
    #   puts Taylor::Platform.os
    #   # => :linux
    #
    # @return [Symbol]
    def self.os
      # mrb_Taylor_Platform_os
      # src/taylor/platform.cpp
      :linux
    end

    # Returns the current CPU architecture we're running on.
    # Possible values are ':wasm32', ':amd64', and ':arm64'.
    #
    # @example Basic usage
    #   puts Taylor::Platform.arch
    #   # => :amd64
    #
    # @return [Symbol]
    def self.arch
      # mrb_Taylor_Platform_arch
      # src/taylor/platform.cpp
      :amd64
    end

    # Is the current platform Android?
    #
    # @example Basic usage
    #   puts Taylor::Platform.android?
    #   # => true
    #
    # @return [Boolean]
    def self.android?
      # mrb_Taylor_Platform_android
      # src/taylor/platform.cpp
      true
    end

    # Is the current platform Linux?
    #
    # @example Basic usage
    #   puts Taylor::Platform.linux?
    #   # => true
    #
    # @return [Boolean]
    def self.linux?
      # mrb_Taylor_Platform_linux
      # src/taylor/platform.cpp
      true
    end

    # Is the current platform Windows?
    #
    # @example Basic usage
    #   puts Taylor::Platform.windows?
    #   # => true
    #
    # @return [Boolean]
    def self.windows?
      # mrb_Taylor_Platform_windows
      # src/taylor/platform.cpp
      true
    end

    # Is the current platform OSX?
    #
    # @example Basic usage
    #   puts Taylor::Platform.osx?
    #   # => true
    #
    # @return [Boolean]
    def self.osx?
      # mrb_Taylor_Platform_osx
      # src/taylor/platform.cpp
      true
    end

    # Is the current platform a web browser?
    #
    # @example Basic usage
    #   puts Taylor::Platform.browser?
    #   # => true
    #
    # @return [Boolean]
    def self.browser?
      # mrb_Taylor_Platform_browser
      # src/taylor/platform.cpp
      true
    end
  end
end
