module Taylor
  module Commands
    class Run
      def self.call(argv, options)
        new(argv, options)
      end

      attr_accessor :options

      def initialize(argv, taylor_config)
        @argv = Array(argv)
        @taylor_config = taylor_config

        setup_argvs
        setup_entrypoint
        setup_options

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

      def setup_entrypoint
        first_arg = @argv_for_command[0]

        return unless first_arg
        return if first_arg[0] == "-"

        if File.directory?(first_arg)
          return unless File.exist?(File.join(first_arg, "taylor-config.json"))

          Dir.chdir(first_arg)
          @argv_for_command.shift
          @taylor_config = Taylor::Config.new

          $:.unshift "."
        else
          @argv_for_command.shift
          @entrypoint = first_arg
        end
      end

      def entrypoint
        @options[:entrypoint]
      end

      def setup_argvs
        argument_separator_index = @argv.index("--")

        if argument_separator_index
          @argv_for_command = @argv[0...argument_separator_index]
          @argv_for_entrypoint = @argv[(argument_separator_index + 1)..]
        else
          @argv_for_command = @argv
        end
      end

      def setup_options
        parser = OptParser.new do |opts|
          opts.on(:help, :bool, false, short: :h)
          opts.on(:entrypoint, :string, @entrypoint || @taylor_config.entrypoint, short: :e)
        end
        parser.parse(@argv_for_command)

        @options = parser.opts
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
        end
      end
    end
  end
end
