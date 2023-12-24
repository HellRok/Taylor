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
            -h, --help\t\t\tDisplays this message
            -r, --dry-run\t\t\tJust display the export command and don't run it
            -d, --export-directory directory\tWhat directory do you want your exports (defaults to ./exports)
            -t, --export-targets targets\tWhat exports do you want (defaults to linux,windows,osx,web)
            -b, --build-cache directory\tWhere do you want to store build cache (defaults to nil)
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
          opts.on(:help, :bool, default: false, short: :h)
          opts.on("dry-run", :bool, default: false, short: :r)
          opts.on("export-directory", :string, default: options.fetch("export_directory", "./exports"), short: :d)
          opts.on("export-targets", :string, default: options.fetch("export_targets", "linux,windows,osx/intel,osx/apple,web"), short: :t)
          opts.on("build-cache", :string, short: :b)
        end
        parser.parse(argv)

        @options = parser.opts
        @options[:"export-targets"] = @options[:"export-targets"].split(",") unless @options[:"export-targets"].is_a?(Array)
      end

      def check_in_taylor_project!
        unless File.exist?(File.join(Dir.pwd, "taylor-config.json"))
          raise "This command must be run from a Taylor project"
        end
      end

      def create_export_folder
        return if @options[:"dry-run"]

        unless File.exist?(options[:"export-directory"]) &&
            File.directory?(options[:"export-directory"])
          Dir.mkdir(options[:"export-directory"])
        end
      end

      def create_build_cache_folder
        return if @options[:"dry-run"]
        return if @options[:"build-cache"].nil?
        return if File.directory?(options[:"build-cache"])

        Dir.mkdir(options[:"build-cache"])
      end

      def docker_build
        base_command = "docker run -u $(id -u ${USER}):$(id -g ${USER})"
        base_command << " --mount type=bind,source=#{Dir.pwd},target=/app/game"
        base_command << " --mount type=bind,source=#{File.expand_path(@options[:"export-directory"])},target=/app/game/exports"

        if @options[:"build-cache"]
          create_build_cache_folder
          base_command << " --mount type=bind,source=#{File.expand_path(@options[:"build-cache"])},target=/app/taylor/build/"
        end

        @options[:"export-targets"].each do |target|
          command = base_command.dup

          command << " --env EXPORT=#{target}" if target.include?("/")
          command << " hellrok/taylor:#{target.split("/").first}-v#{TAYLOR_VERSION}"

          if options[:"dry-run"]
            puts command
          else
            `#{command}`
          end
        end
      end
    end
  end
end
