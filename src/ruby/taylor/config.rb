module Taylor
  # The {Config} class is used for all the configuration about this Taylor
  # game. It is a reflection of your {file:taylor-config.json.md taylor-config.json}.
  class Config
    # @return [Taylor::Config::Web]
    attr_reader :web
    # @return [Taylor::Config::Debugging]
    attr_reader :debugging
    # @return [String]
    attr_writer :name, :version, :entrypoint, :export_directory
    # @return [Array<String>]
    attr_writer :export_targets, :load_paths, :copy_paths

    def initialize
      @config = {}
      @config = JSON.parse(File.read("./taylor-config.json")) if File.exist?("./taylor-config.json")

      @web = Web.new(@config.fetch("web", {}))
      @debugging = Debugging.new(@config.fetch("debugging", {}))
    end

    # Returns the name of the Taylor game.
    #
    # @example Basic usage
    #   puts Taylor::Config.new.name
    #   # => "Taylor Game"
    #
    # @return [String]
    def name
      @name ||= @config.fetch("name", "Taylor Game")
    end

    # Returns the version of the Taylor game.
    #
    # @example Basic usage
    #   puts Taylor::Config.new.version
    #   # => "v0.0.1"
    #
    # @return [String]
    def version
      @version ||= @config.fetch("version", "v0.0.1")
    end

    # Returns the entrypoint of the Taylor game.
    #
    # @example Basic usage
    #   puts Taylor::Config.new.entrypoint
    #   # => "game.rb"
    #
    # @return [String]
    def entrypoint
      @entrypoint ||= @config.fetch(
        "entrypoint",
        @config.fetch(
          "input",
          "game.rb"
        )
      )
    end

    # Returns the export directory of the Taylor game.
    #
    # @example Basic usage
    #   puts Taylor::Config.new.export_directory
    #   # => "./exports"
    #
    # @return [String]
    def export_directory
      @export_directory ||= @config.fetch("export_directory", "./exports")
    end

    # Returns the export targets of the Taylor game.
    #
    # @example Basic usage
    #   puts Taylor::Config.new.export_targets
    #   # => ["linux", "windows", "osx/apple", "osx/intel", "web"]
    #
    # @return [Array<String>]
    def export_targets
      @export_targets ||= @config.fetch("export_targets", ["linux", "windows", "osx/apple", "osx/intel", "web"])
    end

    # Returns the load paths of the Taylor game.
    #
    # @example Basic usage
    #   puts Taylor::Config.new.load_paths
    #   # => ["./", "./vendor"]
    #
    # @return [Array<String>]
    def load_paths
      @load_paths ||= @config.fetch("load_paths", ["./", "./vendor"])
    end

    # Returns the copy paths of the Taylor game.
    #
    # @example Basic usage
    #   puts Taylor::Config.new.copy_paths
    #   # => ["./assets"]
    #
    # @return [Array<String>]
    def copy_paths
      @copy_paths ||= @config.fetch("copy_paths", ["./assets"])
    end

    # The {Web} class is used for all the configuration about this Taylor game
    # relating to the web export. It is a reflection of your
    # {file:taylor-config.json.md taylor-config.json}.
    class Web
      # @return [String]
      attr_writer :shell_path
      # @return [Integer]
      attr_writer :total_memory

      def initialize(config)
        @config = config
      end

      # Returns the shell path of the Taylor game web export.
      #
      # @example Basic usage
      #   puts Taylor::Config.new.web.shell_path
      #   # => "./scripts/export/emscripten_shell.html"
      #
      # @return [String]
      def shell_path
        @shell_path ||= @config.fetch("shell_path", "./scripts/export/emscripten_shell.html")
      end

      # Returns the total allowed memory of the Taylor game web export.
      #
      # @example Basic usage
      #   puts Taylor::Config.new.web.total_memory
      #   # => 64
      #
      # @return [Integer]
      def total_memory
        @total_memory ||= @config.fetch("total_memory", 64)
      end
    end

    # The {Debugging} class is used for all the configuration about this Taylor
    # game relating to exporting. It is a reflection of your
    # {file:taylor-config.json.md taylor-config.json}.
    class Debugging
      attr_reader :raylib, :mruby

      def initialize(config)
        @raylib = Raylib.new(config.fetch("raylib", {}))
        @mruby = MRuby.new(config.fetch("mruby", {}))
      end

      # The {Raylib} class is used for all the configuration about this Taylor
      # game relating to exporting with Raylib. It is a reflection of your
      # {file:taylor-config.json.md taylor-config.json}.
      class Raylib
        # @return [Boolean]
        attr_writer :mock_implementation

        def initialize(config)
          @config = config
        end

        # Returns whether or not to compile the Taylor game against a mocked
        # out Raylib implementation.
        #
        # @example Basic usage
        #   puts Taylor::Config.new.raylib.mock_implementation
        #   # => false
        #
        # @return [Boolean]
        def mock_implementation
          if instance_variable_defined? :@mock_implementation
            @mock_implementation
          else
            @config.fetch("mock_implementation", false)
          end
        end
      end

      # The {Raylib} class is used for all the configuration about this Taylor
      # game relating to exporting with MRuby. It is a reflection of your
      # {file:taylor-config.json.md taylor-config.json}.
      class MRuby
        # @return [Boolean]
        attr_writer :debug_symbols

        def initialize(config)
          @config = config
        end

        # Returns whether or not to compile mruby debug symbols into the Taylor
        # game.
        #
        # @example Basic usage
        #   puts Taylor::Config.new.mruby.debug_symbols
        #   # => false
        #
        # @return [Boolean]
        def debug_symbols
          if instance_variable_defined? :@debug_symbols
            @debug_symbols
          else
            @config.fetch("debug_symbols", false)
          end
        end
      end
    end
  end
end
