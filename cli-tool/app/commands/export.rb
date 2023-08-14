module Taylor
  module Commands
    class Export
      def self.call(argv, options)
        new(argv, options)
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
            --export_targets targets\tWhat exports do you want (defaults to linux,windows,osx,web)
            --build_cache directory\tWhere do you want to store build cache (defaults to nil)
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
          opts.on(:help, :bool, false)
          opts.on(:dry_run, :bool, false)
          opts.on(:export_directory, :string, options.fetch("export_directory", "./exports"))
          opts.on(:export_targets, :string, options.fetch("export_targets", "linux,windows,osx,web"))
          opts.on(:build_cache, :string)
        end
        parser.parse(argv, true)

        @options = parser.opts
        @options[:export_targets] = @options[:export_targets].split(",") unless @options[:export_targets].is_a?(Array)
      end

      def check_in_taylor_project!
        unless File.exist?(File.join(Dir.pwd, "taylor-config.json"))
          raise "This command must be run from a Taylor project"
        end
      end

      def create_export_folder
        return if @options[:dry_run]

        unless File.exist?(options[:export_directory]) &&
            File.directory?(options[:export_directory])
          Dir.mkdir(options[:export_directory])
        end
      end

      def create_build_cache_folder
        return if @options[:dry_run]
        return if @options[:build_cache].nil?

        unless File.exist?(options[:build_cache]) &&
            File.directory?(options[:build_cache])
          Dir.mkdir(options[:build_cache])
        end
      end

      def docker_build
        base_command = "docker run -u $(id -u ${USER}):$(id -g ${USER})"
        base_command << " --mount type=bind,source=#{Dir.pwd},target=/app/game"
        base_command << " --mount type=bind,source=#{File.expand_path(@options[:export_directory])},target=/app/game/exports"

        unless @options[:build_cache].nil?
          base_command << " --mount type=bind,source=#{@options[:build_cache]},target=/app/taylor/build/"
        end

        @options[:export_targets].each do |target|
          command = base_command.dup

          command << " --env EXPORT=#{target}" if target.include?("/")
          command << " hellrok/taylor:#{target.split("/").first}-v#{TAYLOR_VERSION}"

          if options[:dry_run]
            puts command
          else
            `#{command}`
          end
        end
      end
    end
  end
end
