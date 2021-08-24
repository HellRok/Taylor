module Taylor
  module Command
    class Run
      def self.call(command, argv, options)
        self.new(command, argv, options)
      end

      attr_accessor :options
      def initialize(command, argv, options)
        setup_options(argv, options)

        @command = command || '.'

        if @options[:help]
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
            taylor [action] [options]

          Options:
            --help\tShow this message
            --input input\t\t\tWhat is the name of the entrypoint file (defaults to game.rb)

          Actions:
            new\tCreate a new Taylor game
        STR
      end

      private
      def setup_options(argv, options)
        parser = OptParser.new do |opts|
          opts.on(:help,             :bool,   false)
          opts.on(:input,            :string, options.fetch(:input,            'game.rb'))
        end
        parser.parse(argv, true)

        @options = parser.opts
      end

      def from_config
        @options[:input]
      end

      def unload_taylor_cli
        Taylor.send(:remove_const, :Command)
      end

      def run_command
        if File.exists?(@command) && File.file?(@command)
          ARGV.shift
          require @command

        elsif File.exists?(from_config) && File.file?(from_config)
          require from_config

        else
          raise "Did not know how to handle #{@command}"
        end
      end
    end
  end
end
