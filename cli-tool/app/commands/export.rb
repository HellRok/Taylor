module Taylor
  module Commands
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
            --export_directory directory\tWhat directory do you want your exports (defaults to ./exports)
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
        end
        parser.parse(argv, true)

        @options = parser.opts
        @options[:export_directory] = options.fetch(:export_directory, './exports')
      end

      def check_in_taylor_project!
        unless File.exists?(File.join(Dir.pwd, 'taylor-config.json'))
          raise 'This command must be run from a Taylor project'
        end
      end

      def create_export_folder
        return if @options[:dry_run]

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
