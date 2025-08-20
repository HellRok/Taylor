require_relative "builder/commands"

class Builder
  def self.base
    @@base ||= new
  end

  def self.builders
    @@builders ||= {}
  end

  def self.register(builder)
    @@builders ||= {}
    @@builders[builder.platform] = builder
  end

  def self.mf_command_for(task)
    variant, platform, arch = task.name.split("/")
    platform += "/#{arch}" unless arch.nil? || %w[debug release].include?(arch)

    @@builders[platform].variant = variant
    @@builders[platform].generate_mf_for(task)
  end

  def self.o_command_for(task)
    variant, platform, arch = task.name.split("/")
    platform += "/#{arch}" unless arch.nil? || %w[debug release].include?(arch)

    @@builders[platform].variant = variant
    @@builders[platform].generate_o_for(task)
  end

  attr_accessor :variant, :platform, :cxx, :cxxflags, :ldflags

  def initialize
    @variant = :debug

    @includes = []
    @defines = []
    @defines << " -DEXPORT" if ENV["EXPORT"]
    @static_links = []

    @debug_optimisation = "-Og"
    @release_optimisation = "-O2"

    setup_options

    if mock_raylib?
      @defines << " -DMOCK_RAYLIB"
    end

    setup_platform
    setup_includes
    setup_static_links
  end

  def setup_includes
    @includes << "-I ./include/"
    @includes << "-I ./vendor/"
    @includes << "-I ./vendor/raylib/include/" unless mock_raylib?
    @includes << "-I ./vendor/mruby/"
  end

  def setup_static_links
    @static_links << "./vendor/#{@platform}/libmruby.a"
    @static_links << "./vendor/#{@platform}/raylib/lib/libraylib.a" unless mock_raylib?
  end

  def build_dependencies
    [
      (mock_raylib? ? "raylib:mock" : "raylib:unmock"),
      :setup_ephemeral_files,
      :build_depends,
      :build_objects
    ]
  end

  def setup_platform
    nil
  end

  def defines
    @defines.join(" ")
  end

  def includes
    @includes.join(" ")
  end

  def static_links
    @static_links.join(" ")
  end

  def setup_options
    @options ||= File.exist?("/app/game/taylor-config.json") ?
      JSON.parse(File.read("/app/game/taylor-config.json")) : {
        "name" => "taylor"
      }
  end

  def name
    @options["name"]
  end

  def mock_raylib?
    @options.dig("debugging", "raylib", "mock_implementation") || ENV.key?("MOCK_RAYLIB")
  end
end
