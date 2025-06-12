module Taylor
  # The {Platform} module is used for getting information about the environment we are
  # operating in. So things like operating system and CPU architecture are found here.
  module Platform
    # What version of GLSL does the current system support?
    GLSL_VERSION = (Taylor::Platform.browser? || Taylor::Platform.android?) ? 100 : 330

    # Returns the current platform and architecture.
    #
    # @example Basic usage
    #   puts Taylor::Platform.to_s
    #   # => "amd64-linux"
    #
    # @return [String]
    def self.to_s = "#{arch}-#{os}"

    # Used for simple comparisons against String or matching constants.
    #
    # @example Basic usage
    #   exit 1 unless Taylor::Platform == "amd64-linux"
    #
    # @return [Boolean]
    def self.==(other)
      super unless other === String
      to_s == other
    end

    # Used for when a platform specific method is called on the wrong platform.
    class MethodCalledOnInvalidPlatformError < StandardError
    end
  end
end
