module Taylor
  module Commands
    class New
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
            taylor new [options] <folder>


          Options:
            --help\t\t\tDisplays this message
            --name name\t\t\tWhat to name your new game (defaults to taylor_game)
            --version version\t\tWhat version is your game (defaults to v0.0.1)
            --input input\t\t\tWhat is the name of the entrypoint file (defaults to game.rb)
            --export_directory directory\tWhat directory do you want your exports (defaults to ./exports)
            --export_targets targets\tWhat exports do you want (defaults to linux,windows,osx,web)
            --load_paths directories\tWhat directories do you want in your load path (defaults to ./,./vendor)
            --copy_paths directories\tWhat directories do you want copied into your exports (defaults to ./assets)
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
          opts.on(:help,             :bool,   false)
          opts.on(:name,             :string, options.fetch('name',             'taylor_game'))
          opts.on(:version,          :string, options.fetch('version',          'v0.0.1'))
          opts.on(:input,            :string, options.fetch('input',            'game.rb'))
          opts.on(:export_directory, :string, options.fetch('export_directory', './exports'))
          opts.on(:export_targets,   :string, options.fetch('export_targets',   'linux,windows,osx,web'))
          opts.on(:load_paths,       :string, options.fetch('load_paths',       './,./vendor'))
          opts.on(:copy_paths,       :string, options.fetch('copy_paths',       './assets'))
        end
        parser.parse(argv, true)

        @options = parser.opts
        @options[:folder] = parser.tail.first || @options[:name]
        @options[:load_paths] = @options[:load_paths].split(',')
        @options[:copy_paths] = @options[:copy_paths].split(',')
        @options[:export_targets] = @options[:export_targets].split(',')
      end

      def create_directory!
        if File.exists?(@options[:folder])
          raise "#{options[:folder]} directory already exists! Did you mean to run this again?"
        end

        Dir.mkdir(options[:folder])
      end

      def setup_game_structure
        (@options[:load_paths] + @options[:copy_paths]).each { |path|
          unless path == './'
            Dir.mkdir(path_for(path))
            File.open(File.join(path_for(path), '.keep'), 'w').close
          end
        }

        game = File.open(path_for(options[:input]), 'w')
        game.write(
          game_template.
            gsub('$NAME', options[:name]).
            gsub('$LOAD_PATHS', load_paths_code)
        )
        game.close
      end

      def create_config
        config_options = options.dup
        config_options.delete(:help)
        config_options.delete(:folder)

        config = File.open(path_for('taylor-config.json'), 'w')
        config.write(JSON.generate(config_options, { pretty_print: true, indent_width: 2 }))
        config.close
      end

      def path_for(file)
        File.join(options[:folder], file)
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
