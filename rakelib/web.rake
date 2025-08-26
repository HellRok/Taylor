require_relative "builder"
require_relative "helpers"

class WebBuilder < Builder
  def setup_platform
    @platform = "web"
    @cxx = "emcc"
    @cxxflags = "-std=c++17 -Wall -Wextra"

    @debug_optimisation = "-O0"

    generate_static_links
  end

  def shell_path
    if @options.dig("web", "shell_path")
      " --shell-file #{File.join("/", "app", "game", @options["web"]["shell_path"])}"
    else
      " --shell-file ./scripts/export/emscripten_shell.html"
    end
  end

  def generate_static_links
    @static_links << "-s USE_GLFW=3"

    total_memory = @options.dig("web", "total_memory")
    @static_links << if total_memory.nil?
      " -s TOTAL_MEMORY=64MB"
    elsif total_memory == -1
      " -s ALLOW_MEMORY_GROWTH"
    else
      " -s TOTAL_MEMORY=#{total_memory}MB"
    end

    @static_links << shell_path
    @options.fetch("copy_paths", []).each { |path|
      @static_links << "--preload-file #{File.join("/", "app", "game", path)}@#{path}"
    }
    @static_links << "-s EXPORT_ALL"
    @static_links << "-s EXPORTED_RUNTIME_METHODS=UTF8ToString,stringToUTF8,lengthBytesUTF8,HEAPF32"
  end

  def name
    "#{@options["name"]}.html"
  end
end

builder = WebBuilder.new
Builder.register(builder)

namespace :web do
  multitask build_depends: builder.depends
  multitask build_objects: builder.objects
  task build: builder.build_dependencies
  desc "Build for web in debug mode"
  task build: "build:web:debug"

  namespace :release do
    multitask build_depends: builder.depends("release")
    multitask build_objects: builder.objects("release")
    task build: builder.build_dependencies
    desc "Build for web in release mode"
    task build: "build:web:release"
  end
end
