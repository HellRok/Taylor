require_relative 'builder.rb'
require_relative 'helpers.rb'

class WebBuilder < Builder
  def initialize
    setup_options
    @platform = 'web'
    @cxx = 'emcc'
    @cxxflags = '-std=c++17 -Wall -Wextra'
    @release_flags = '-O3'

    generate_static_links

    after_initialize
  end

  def shell_path
    if @options.dig('web', 'shell_path')
      " --shell-file #{File.join('/', 'app', 'game', @options['web']['shell_path'])}"
    else
      " --shell-file ./scripts/export/emscripten_shell.html"
    end
  end

  def generate_static_links
    @static_links = <<-EOS.chomp
      -s USE_GLFW=3
    EOS

    total_memory = @options.dig('web', 'total_memory')
    if total_memory.nil?
      @static_links += " -s TOTAL_MEMORY=64MB"
    elsif total_memory == -1
      @static_links += " -s ALLOW_MEMORY_GROWTH"
    else
      @static_links += " -s TOTAL_MEMORY=#{total_memory}MB"
    end

    @static_links += shell_path
    @options.fetch('copy_paths', []).each { |path|
      @static_links += " --preload-file #{File.join('/', 'app', 'game', path)}@#{path}"
    }
    @static_links += <<-EOS.chomp
      ./vendor/web/libmruby.a \
      ./vendor/web/raylib/lib/libraylib.a \
      -s EXPORTED_RUNTIME_METHODS=['UTF8ToString','stringToUTF8','lengthBytesUTF8']
    EOS
  end

  def name
    "#{@options['name']}.html"
  end
end

Builder.register(WebBuilder.new)

namespace :web do
  multitask :build_depends => depends("build/web/debug")
  multitask :build_objects => objects("build/web/debug")
  task :build => [:build_depends, :build_objects]
  desc "Build for web in debug mode"
  task :build => "build:web:debug"

  namespace :release do
    multitask :build_depends => depends("build/web/release")
    multitask :build_objects => objects("build/web/release")
    task :build => [:build_depends, :build_objects]
    desc "Build for web in release mode"
    task :build => "build:web:release"
  end
end