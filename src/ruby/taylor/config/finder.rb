module Taylor
  class Config
    # Locates the most relevant `taylor-config.json`.
    class Finder
      # Searches from the passed in directory or file upward to find the
      # closest `taylor-config.json` file and returns a {Taylor::Config} based on that.
      #
      # If there is no `taylor-config.json` in any parent folder it'll return a
      # default {Taylor::Config}.
      #
      # @example Basic usage
      #   config = Taylor::Config::Finder.call("../my_game")
      #
      # @param argument [String] Either a file or directory
      # @return [Taylor::Config]
      def self.call(argument)
        new(argument).call
      end

      # Creates a new instance of {Taylor::Config::Finder}.
      #
      # @example Basic usage
      #   config = Taylor::Config::Finder.new("../my_game")
      #
      # @param argument [String] Either a file or directory
      # @return [Taylor::Config]
      def initialize(argument)
        @argument = argument
      end

      # See {.call}.
      #
      # @example Basic usage
      #   config = Taylor::Config::Finder.new("../my_game").call
      #
      # @return [Taylor::Config]
      def call
        return Taylor::Config.new unless @argument

        if File.file?(@argument)
          find_config_in(File.dirname(@argument))
        elsif File.directory?(@argument)
          find_config_in(@argument)
        else
          Taylor::Config.new
        end
      end

      # Searches from the passed in directory or file upward to find the
      # closest `taylor-config.json` file and returns its path. If there is no
      # `taylor-config.json` it returns `nil`.
      #
      # @example Basic usage
      #   puts Taylor::Config::Finder.new("../my_game").find_config_in("../my_game")
      #   # => "/home/sean/code/my_game/taylor-config.json"
      #
      # @param argument [String] Either a file or directory
      # @return [String,nil]
      def find_config_in(path)
        absolute_path = File.absolute_path(path)
        parent_path = File.absolute_path(File.join(absolute_path, ".."))

        until parent_path == absolute_path
          config_file = File.join(absolute_path, "taylor-config.json")

          return Taylor::Config.new(file: config_file) if File.exist?(config_file)

          absolute_path = parent_path
          parent_path = File.absolute_path(File.join(absolute_path, ".."))
        end
      end
    end
  end
end
