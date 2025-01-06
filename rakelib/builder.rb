class Builder
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

  attr_accessor :variant, :platform,
    :cxx, :cxxflags, :defines, :includes, :static_links, :ldflags

  def after_initialize
    @variant = :debug

    @includes ||= ""
    @includes << " -I ./include/ -I ./vendor/ -I ./vendor/raylib/include/ -I ./vendor/mruby/"

    @defines ||= ""
    @defines << " -DEXPORT" if ENV["EXPORT"]

    setup_options
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

  def objects_folder
    "build/#{@platform}/#{@variant}"
  end

  def generate_mf_for(task)
    <<-CMD.squeeze(" ").strip
      #{@cxx} #{@cxxflags} #{@includes} #{@defines} -c #{task.source} \
        #{@ldflags} \
        -MM \
        -MT #{task.name.gsub(SRC_FOLDER, objects_folder).ext(".o")}
    CMD
  end

  def generate_o_for(task)
    <<-CMD.squeeze(" ").strip
    #{@cxx} #{@cxxflags} #{@includes} #{@defines} -c #{task.source} \
      -o #{task.name} \
      #{@ldflags}
    CMD
  end

  def lint(fix: false)
    if fix
      <<~CMD
        find . -type f -name "*.[c,h]pp" |
        xargs -P$(nproc) -I{} \
        clang-tidy \
          --fix-errors \
          {} \
          -- -std=c++17 #{@includes} #{@defines} \
          2>/dev/null
      CMD
    else
      <<~CMD
        find . -type f -name "*.[c,h]pp" |
        xargs -P$(nproc) -I{} \
        clang-tidy \
          --warnings-as-errors=* \
          {} \
          -- -std=c++17 #{@includes} #{@defines} \
          2>/dev/null
      CMD
    end
  end

  def compile
    <<-CMD.squeeze(" ").strip
      #{@cxx} \
        -o "./dist/#{@platform}/#{@variant}/#{name}" \
        #{@cxxflags} \
        #{(variant == :release) ? @release_flags : ""} \
        #{@defines} \
        #{@includes} \
        #{objects(objects_folder).join " "} \
        #{@static_links} \
        #{@ldflags}
    CMD
  end
end
