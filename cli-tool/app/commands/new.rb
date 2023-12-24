module Taylor
  module Commands
    class New
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
            taylor new [options] <folder>


          Options:
            -h, --help\t\t\tDisplays this message
            -n, --name name\t\t\tWhat to name your new game (defaults to taylor_game)
            -v, --version version\t\tWhat version is your game (defaults to v0.0.1)
            -i, --input input\t\t\tWhat is the name of the entrypoint file (defaults to game.rb)
            -d, --export-directory directory\tWhat directory do you want your exports (defaults to ./exports)
            -t, --export-targets targets\tWhat exports do you want (defaults to linux,windows,osx/apple,osx/intel,web)
            -l, --load-paths directories\tWhat directories do you want in your load path (defaults to ./,./vendor)
            -c, --copy-paths directories\tWhat directories do you want copied into your exports (defaults to ./assets)
            folder\t\t\tThe folder to create the new game in (defaults to the name value)
        STR
      end

      def call
        create_directory!
        create_config
        setup_game_structure

        puts "Successfully created #{options[:name]}"
      end

      private

      def setup_options(argv, options)
        parser = OptParser.new do |opts|
          opts.on(:help, :bool, default: false, short: :h)
          opts.on(:name, :string, default: options.fetch("name", "taylor_game"), short: :n)
          opts.on(:version, :string, default: options.fetch("version", "v0.0.1"), short: :v)
          opts.on(:input, :string, default: options.fetch("input", "game.rb"), short: :i)
          opts.on(:"export-directory", :string, default: options.fetch("export_directory", "./exports"), short: :d)
          opts.on(:"export-targets", :string, default: options.fetch("export_targets", "linux,windows,osx/apple,osx/intel,web"), short: :t)
          opts.on(:"load-paths", :string, default: options.fetch("load_paths", "./,./vendor"), short: :l)
          opts.on(:"copy-paths", :string, default: options.fetch("copy_paths", "./assets"), short: :c)
        end
        parser.parse(argv)

        @options = parser.opts
        @options[:folder] = parser.tail.first || @options[:name]
        @options[:"load-paths"] = @options[:"load-paths"].split(",") unless @options[:"load-paths"].is_a?(Array)
        @options[:"copy-paths"] = @options[:"copy-paths"].split(",") unless @options[:"copy-paths"].is_a?(Array)
        @options[:"export-targets"] = @options[:"export-targets"].split(",") unless @options[:"export-targets"].is_a?(Array)
      end

      def create_directory!
        if File.exist?(@options[:folder])
          raise "#{options[:folder]} directory already exists! Did you mean to run this again?"
        end

        Dir.mkdir(options[:folder])
      end

      def setup_game_structure
        (@options[:"load-paths"] + @options[:"copy-paths"]).each { |path|
          unless path == "./"
            Dir.mkdir(path_for(path))
            File.open(File.join(path_for(path), ".keep"), "w").close
          end
        }

        game = File.open(path_for(options[:input]), "w")
        game.write(
          game_template
            .gsub("$NAME", options[:name])
            .gsub("$LOAD_PATHS", load_paths_code)
        )
        game.close
      end

      def create_config
        config_options = options.dup
        config_options.delete(:help)
        config_options.delete(:folder)

        config = File.open(path_for("taylor-config.json"), "w")
        config.write(JSON.generate(config_options, {pretty_print: true, indent_width: 2}))
        config.close
      end

      def path_for(file)
        File.join(options[:folder], file)
      end

      def load_paths_code
        output = ""

        options[:"load-paths"].each { |path|
          next if path == "./" || path == "."
          output << "$: << '#{path}'\n"
        }

        output.chomp
      end
    end
  end
end
