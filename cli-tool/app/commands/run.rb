module Taylor
  module Commands
    class Run
      def self.call(command, argv, options)
        new(command, argv, options)
      end

      attr_accessor :options

      def initialize(command, argv, options)
        setup_argvs(argv)
        setup_options(options)

        # better name for command might be something like "game_directory_or_entrypoint"
        @command = if command.nil? || command.start_with?("--")
          ""
        else
          command
        end

        if @options[:help] || entrypoint.empty?
          display_help
        else
          call
        end
      end

      def call
        unload_taylor_cli

        run_command
      end

      def display_help
        puts <<~STR
          Taylor #{TAYLOR_VERSION}

          Usage:
            taylor\t\t\t# If the current folder is a taylor game, launch it
            taylor ./game.rb\t\t# Launch ./game.rb
            taylor --entrypoint ./game.rb\t# Launch ./game.rb
            taylor <action> [options]

          Options:
            -h, --help\t\t\tShow this message
            -v, --version\t\t\tDisplay the version and exit
            -e, --entrypoint entrypoint\tWhat is the name of the entrypoint file (defaults to game.rb)

          Actions:
            new\t\tCreate a new Taylor game
            export\tCompile your game for release
            squash\tSquash all your source code into one file
        STR
      end

      private

      def entrypoint
        if @command.empty?
          @options[:entrypoint]

        elsif File.directory?(@command) && File.exist?(File.join(@command, "taylor-config.json"))
          Dir.chdir(@command)
          setup_options(@argv, Taylor::Config.new)
          $:.unshift "."
          @options[:entrypoint]

        else
          @command
        end
      end

      def setup_argvs(argv)
        @argv = argv

        argument_separator_index = @argv.index("--")

        if argument_separator_index
          @argv_for_command = @argv[0...argument_separator_index]
          @argv_for_entrypoint = @argv[(argument_separator_index + 1)..]
        else
          @argv_for_command = @argv
        end
      end

      def setup_options(options)
        parser = OptParser.new do |opts|
          opts.on(:help, :bool, false, short: :h)
          opts.on(:entrypoint, :string, options.entrypoint, short: :e)
        end
        parser.parse(@argv_for_command)

        @options = parser.opts
      end

      def from_config
        @options["entrypoint"]
      end

      def unload_taylor_cli
        Taylor.send(:remove_const, :Commands)
      end

      def run_command
        if File.exist?(entrypoint)
          set_argv_for_entrypoint

          require entrypoint
        else
          puts "Could not load \"#{entrypoint}\", are you sure it exists?"
          exit! 1
        end
      end

      def set_argv_for_entrypoint
        if @argv_for_entrypoint
          ARGV.clear
          @argv_for_entrypoint.each.with_index do |arg, index|
            ARGV[index] = arg
          end
        else
          # This is the behavior before supporting "--" so just preserving it for now.
          ARGV.shift
        end
      end
    end
  end
end
