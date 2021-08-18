module Taylor
  module Command
    class New
      def self.call(parser)
        self.new(parser)
      end

      attr_accessor :options

      def initialize(parser)
        @options = parser.opts.slice(
          :help, :name, :input, :export_directory, :load_paths, :copy_paths
        )

        @options[:load_paths] = @options[:load_paths].split(',')
        @options[:copy_paths] = @options[:copy_paths].split(',')

        if @options[:help]
          display_help
        else
          call
        end
      end

      def display_help
        puts <<~STR
          Taylor #{TAYLOR_VERSION}

          Usage:
            taylor run [options]

          Options:
            --help\t\t\tDisplays this message
            --name name\t\t\tWhat to name your new game (defaults to taylor_game)
            --input input\t\t\tWhat is the name of the entrypoint file (defaults to game.rb)
            --export_directory directory\tWhat directory do you want your exports (defaults to ./exports)
            --load_paths directories\tWhat directories do you want in your load path (defaults to ./,./vendor)
            --copy_paths directories\tWhat directories do you want copied into your exports (defaults to ./assets)
        STR
      end

      def call
        create_directory!
        create_config
        setup_game_structure

        puts "Successfully created #{options[:name]}"
      end

      private
      def create_directory!
        if File.exists?(options[:name])
          raise "#{options[:name]} directory already exists! Did you mean to run this again?"
        end

        Dir.mkdir(options[:name])
      end

      def setup_game_structure
        Dir.mkdir(path_for('vendor'))
        Dir.mkdir(path_for('assets'))

        game = File.open(path_for(options[:input]), 'w')
        game.write(
          game_template.
            gsub('$NAME', options[:name]).
            gsub('$LOAD_PATHS', load_paths_code)
        )
        game.close
      end

      def create_config
        config_options = options
        config_options.delete(:help)

        config = File.open(path_for('taylor-config.json'), 'w')
        config.write(JSON.generate(config_options, { pretty_print: true, indent_width: 2 }))
        config.close
      end

      def path_for(file)
        File.join(options[:name], file)
      end

      def load_paths_code
        output = ''

        options[:load_paths].each { |path|
          next if path == './' || path == '.'
          output << "$: << '#{path}'\n"
        }

        output.chomp
      end
    end
  end
end
