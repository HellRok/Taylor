class Squasher
  REQUIRE_REGEX = /.*require\s+['"](.*)['"].*/
  attr_reader :options

  def self.call(options)
    new(options)
  end

  def initialize(options)
    @options = options
    @files = options['load_paths'].flat_map { |dir|
      Dir.glob(File.join(dir, '**/*.rb'))
    }
    @processed_files = []
    @data = ""

    process_file('./game.rb')

    File.write('../export/output.rb', @data)
  end

  def process_file(file, indent: 0)
    print "Squashing "
    print "#{"\t" * indent}↳ " if indent.positive?
    puts file
    File.readlines(file).each do |line|
      process_line(line, indent: indent + 1)
    end
  end

  def process_line(line, indent:)
    required_file_name = required_file_from(line)

    @data << line and return unless required_file_name

    file_name = find_file(required_file_name)

    process_file(file_name, indent: indent) and return if file_name

    @data << line
  end

  def find_file(file_name)
    file_name = "#{file_name}.rb" unless file_name[-3..] == '.rb'
    file_name = file_name.gsub(/[.]+[\/]+/, '')

    options['load_paths'].each { |dir|
      file = File.join(dir, file_name)

      return file if File.exist?(file)
    }

    raise "No matching file for #{file_name}"
  end

  def required_file_from(line)
    lib = Squasher::REQUIRE_REGEX.match(line)
    return lib[1] if lib
  end
end
