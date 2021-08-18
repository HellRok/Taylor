module Taylor
  module Command
    class Run
      def self.call(command, parser)
        self.new(command, parser)
      end

      def initialize(command, parser)
        @command = command
        @from_config = parser.opts[:input]

        if parser.opts[:help]
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
            taylor\t\t# If the current folder is a taylor game, launch it
            taylor ./game.rb\t# Launch ./game.rb
            taylor [action] [options]

          Options:
            --help\tShow this message

          Actions:
            new\tCreate a new Taylor game
        STR
      end

      private
      def unload_taylor_cli
        Taylor.send(:remove_const, :Command)
      end

      def run_command
        if File.exists?(@command) && File.file?(@command)
          ARGV.shift
          require @command

        elsif File.exists?(@from_config) && File.file?(@from_config)
          require @from_config

        else
          raise "Did not know how to handle #{command}"
        end
      end
    end
  end
end
