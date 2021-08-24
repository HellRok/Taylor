module Taylor
  module Command
    class Export
      def self.call(argv, options)
        self.new(argv, options)
      end

      attr_accessor :options

      def initialize(argv, options)
        setup_options(argv, options)

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
            taylor export [options]

          Options:
            --help\t\t\tDisplays this message
            --dry-run\t\t\tJust display the export command and don't run it
            --name name\t\t\tWhat to name your game (defaults to taylor_game)
            --input input\t\t\tWhat is the name of the entrypoint file (defaults to game.rb)
            --export_directory directory\tWhat directory do you want your exports (defaults to ./exports)
            --load_paths directories\tWhat directories do you want in your load path (defaults to ./,./vendor)
            --copy_paths directories\tWhat directories do you want copied into your exports (defaults to ./assets)
        STR
      end

      def call
        check_in_taylor_project!

        create_export_folder
        docker_build
      end

      private
      def setup_options(argv, options)
        parser = OptParser.new do |opts|
          opts.on(:help,             :bool,   false)
          opts.on(:dry_run,          :bool,   false)
          opts.on(:name,             :string, options.fetch(:name,             'taylor_game'))
          opts.on(:input,            :string, options.fetch(:input,            'game.rb'))
          opts.on(:export_directory, :string, options.fetch(:export_directory, './exports'))
          opts.on(:load_paths,       :string, options.fetch(:load_paths,       './,./vendor'))
          opts.on(:copy_paths,       :string, options.fetch(:copy_paths,       './assets'))
        end
        parser.parse(argv, true)

        @options = parser.opts
        @options[:load_paths] = @options[:load_paths].split(',')
        @options[:copy_paths] = @options[:copy_paths].split(',')
      end

      def check_in_taylor_project!
        unless File.exists?(File.join(Dir.pwd, 'taylor-config.json'))
          raise 'This command must be run from a Taylor project'
        end
      end

      def create_export_folder
        unless File.exists?(options[:export_directory]) &&
            File.directory?(options[:export_directory])
          Dir.mkdir(options[:export_directory])
        end
      end

      def docker_build
        command = 'docker run -u $(id -u ${USER}):$(id -g ${USER})'
        command << " --mount type=bind,source=#{Dir.pwd},target=/app/game/"
        command << " hellrok/taylor:v#{TAYLOR_VERSION}"

        if options[:dry_run]
          puts command
        else
          `#{command}`
        end
      end
    end
  end
end
