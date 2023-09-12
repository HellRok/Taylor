module Taylor
  module Commands
    class Run
      def self.call(command, argv, options)
        new(command, argv, options)
      end

      attr_accessor :options
      def initialize(command, argv, options)
        @argv = argv
        setup_options(@argv, options)

        @command = command || ""

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
            taylor --input ./game.rb\t# Launch ./game.rb
            taylor <action> [options]

          Options:
            --help\t\t\tShow this message
            --version\t\t\tDisplay the version and exit
            --input input\t\t\tWhat is the name of the entrypoint file (defaults to game.rb)

          Actions:
            new\t\tCreate a new Taylor game
            export\tCompile your game for release
            squash\tSquash all your source code into one file
        STR
      end

      private

      def entrypoint
        if !@command.empty?
          if File.directory?(@command) && File.exist?(File.join(@command, "taylor-config.json"))
            options = JSON.parse(File.read(File.join(@command, "taylor-config.json")))
            setup_options(@argv, options)
            Dir.chdir(@command)
            $:.unshift "."
            @options[:input]
          else
            @command
          end
        else
          @options[:input]
        end
      end

      def setup_options(argv, options)
        parser = OptParser.new do |opts|
          opts.on(:help, :bool, false)
          opts.on(:input, :string, options.fetch("input", "game.rb"))
        end
        parser.parse(argv, true)

        @options = parser.opts
      end

      def from_config
        @options["input"]
      end

      def unload_taylor_cli
        Taylor.send(:remove_const, :Commands)
      end

      def run_command
        if File.exist?(entrypoint)
          ARGV.shift
          require entrypoint

        else
          puts "Could not load \"#{entrypoint}\", are you sure it exists?"
          exit! 1
        end
      end
    end
  end
end
