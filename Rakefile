require "json"
require "fileutils"
require "rake/clean"
require 'rake/loaders/makefile'

supported_platforms = %w(linux windows osx web)
supported_variants = %w(debug release)

if File.exist?('/app/game/taylor-config.json')
  options = JSON.parse(File.read('/app/game/taylor-config.json'))
else
  options = {}
end

name = options.fetch('name', "taylor")
platform = ""
cxx = ""
variant = "debug"
cxxflags = "-std=c++2a -no-pie -Wall -Wextra"
ldflags = "-l pthread"
includes = "-I ./include/ -I ./vendor/ -I ./vendor/raygui/ -I ./vendor/mruby/"
static_links = ""
SRC_FOLDER = "src"
SRC = Rake::FileList["#{SRC_FOLDER}/**/*.cpp"]
objects_folder = "build"
objects = ->(objects_folder){ SRC.ext('.o').map { |file| file.gsub(SRC_FOLDER, objects_folder) } }
depends = ->(objects_folder){ SRC.ext('.mf').map { |file| file.gsub(SRC_FOLDER, objects_folder) } }

defines = ''
defines << '-DEXPORT' if ENV['EXPORT']

VERSION = File.read("./include/version.hpp").each_line.to_a.last.split('"')[1]

CLEAN.include("./build/*")
CLEAN.include("./dist/*")
CLEAN.include("./releases/*")

task :default => "linux:build"

def source_for(o_file)
  SRC.detect{ |file|
    file.ext('').gsub(SRC_FOLDER, '') == o_file.ext('').gsub(/^build\/(windows|linux|osx|web)\/(debug|release)/, '')
  }
end

namespace :linux do
  task :setup_variables do
    objects_folder = "build/linux/debug"
    cxx = "g++"
    platform = "linux"
    ldflags = "-l dl -l pthread"
    includes += " -I ./vendor/linux/raylib/include/"
    static_links = "#{static_links} ./vendor/linux/libmruby.a ./vendor/linux/raylib/lib/libraylib.a"
  end

  task :build => "linux:setup_variables"
  multitask :build => depends.call("build/linux/debug")
  multitask :build => objects.call("build/linux/debug")
  task :build => "build:linux:debug"

  namespace :release do
    task :setup_variables do
      objects_folder = "build/linux/release"
      variant = "release"
      cxxflags += " -O3"
    end

    task :strip do
      sh "strip \"./dist/#{platform}/#{variant}/#{name}\""
    end

    task :build => "linux:setup_variables"
    task :build => "linux:release:setup_variables"
    multitask :build => depends.call("build/linux/release")
    multitask :build => objects.call("build/linux/release")
    task :build => "build:linux:release"
    task :build => "linux:release:strip"
  end
end

namespace :windows do
  task :setup_variables do
    name = "#{name}.exe"
    objects_folder = "build/windows/debug"
    cxx = "x86_64-w64-mingw32-g++"
    platform = "windows"
    ldflags = "-L ./vendor/windows/raylib/lib/ -static -lwsock32 -lws2_32 -lwinmm -l raylib #{ldflags}"
    cxxflags += " -mwindows -static-libstdc++"
    includes += " -I ./vendor/windows/raylib/include/"

    static_links = "#{static_links} ./vendor/windows/libmruby.a ./vendor/windows/raylib/lib/libraylib.a"
  end

  task :build => "windows:setup_variables"
  multitask :build => depends.call("build/windows/debug")
  multitask :build => objects.call("build/windows/debug")
  task :build => "build:windows:debug"
  task :build => "windows:debug:copy_dlls"

  namespace :release do
    task :setup_variables do
      objects_folder = "build/windows/release"
      variant = "release"
      cxxflags += " -O3"
    end

    task :strip do
      sh "x86_64-w64-mingw32-strip \"./dist/#{platform}/#{variant}/#{name}\""
    end

    task :build => "windows:setup_variables"
    task :build => "windows:release:setup_variables"
    multitask :build => depends.call("build/windows/release")
    multitask :build => objects.call("build/windows/release")
    task :build => "build:windows:release"
    task :build => "windows:release:copy_dlls"
    task :build => "windows:release:strip"
  end
end

namespace :osx do
  task :setup_variables do
    objects_folder = "build/osx/debug"
    cxx = "x86_64-apple-darwin19-clang++"
    cxxflags = " -Oz -mmacosx-version-min=10.11 -stdlib=libc++"
    platform = "osx"
    ldflags = "-l dl -l pthread -framework CoreVideo -framework IOKit -framework Cocoa -framework GLUT -framework OpenGL"
    includes += " -I ./vendor/osx/raylib/include/ -I /opt/osxcross/target/SDK/MacOSX10.15.sdk/System/Library/Frameworks/OpenGL.framework/Headers"
    static_links = "#{static_links} ./vendor/osx/libmruby.a ./vendor/osx/raylib/lib/libraylib.a"
  end

  task :build => "osx:setup_variables"
  multitask :build => depends.call("build/osx/debug")
  multitask :build => objects.call("build/osx/debug")
  task :build => "build:osx:debug"

  namespace :release do
    task :setup_variables do
      objects_folder = "build/osx/release"
      variant = "release"
      cxxflags += " -Oz -mmacosx-version-min=10.11 -stdlib=libc++"
    end

    task :strip do
      sh "x86_64-apple-darwin19-strip \"./dist/#{platform}/#{variant}/#{name}\""
    end

    task :build => "osx:setup_variables"
    task :build => "osx:release:setup_variables"
    multitask :build => depends.call("build/osx/release")
    multitask :build => objects.call("build/osx/release")
    task :build => "build:osx:release"
    task :build => "osx:release:strip"
  end
end

namespace :web do
  task :setup_variables do
    name = "#{name}.html"
    objects_folder = "build/web/debug"
    cxx = "emcc"
    cxxflags += " -s USE_GLFW=3 -s ASYNCIFY --shell-file ./scripts/export/emscripten_shell.html"
    options.fetch('copy_paths', []).each { |path|
      cxxflags += " --preload-file #{File.join('/', 'app', 'game', path)}@#{path}"
    }
    platform = "web"
    ldflags = "-l dl -l pthread"
    includes += " -I ./vendor/web/raylib/include/"
    static_links = "#{static_links} ./vendor/web/libmruby.a ./vendor/web/raylib/lib/libraylib.a"
  end

  task :build => "web:setup_variables"
  multitask :build => depends.call("build/web/debug")
  multitask :build => objects.call("build/web/debug")
  task :build => "build:web:debug"

  namespace :release do
    task :setup_variables do
      objects_folder = "build/web/release"
      variant = "release"
      cxxflags += " -O3"
    end

    task :build => "web:setup_variables"
    task :build => "web:release:setup_variables"
    multitask :build => depends.call("build/web/release")
    multitask :build => objects.call("build/web/release")
    task :build => "build:web:release"
  end
end

supported_variants.each { |variant|
  task "windows:#{variant}:copy_dlls" do
    sh "cp -rv ./vendor/windows/*.dll ./dist/windows/#{variant}"
  end
}

rule ".o" => ->(file){ source_for(file) } do |task|
  FileUtils.mkdir_p(File.dirname(task.name))
  sh <<-CMD.squeeze(' ').strip
    #{cxx} #{cxxflags} #{includes} #{defines} -c #{task.source} \
      -o #{task.name} \
      #{ldflags}
  CMD
end

rule ".mf" => ->(file){ source_for(file) } do |task|
  data = `#{<<-CMD.squeeze(' ').strip}`
    #{cxx} #{cxxflags} #{includes} #{defines} -c #{task.source} \
      #{ldflags} \
      -MM \
      -MT #{task.name.gsub(SRC_FOLDER, objects_folder).ext('.o')}
  CMD

  file, deps = data.split(':')
  deps = deps.split.select{ |dep| File.exist? dep }

  Rake::Task[file].enhance deps
end

supported_platforms.each { |platform|
  supported_variants.each { |variant|
    task "build:#{platform}:#{variant}" do |task|
      FileUtils.mkdir_p("./dist/#{platform}/#{variant}")
      sh <<-CMD.squeeze(' ').strip
        #{cxx} \
          -o \"./dist/#{platform}/#{variant}/#{name}\" \
          #{cxxflags} \
          #{defines} \
          #{includes} \
          #{objects.call(objects_folder).join ' '} \
          #{static_links} \
          #{ldflags}
      CMD
    end
  }
}

task 'mruby:build' do |task|
  sh "rm -rf ./vendor/mruby"
  sh "DOCKER_BUILDKIT=1 docker build --output ./ . --file ./scripts/mruby/Dockerfile.mruby --pull --tag taylor_mruby"
end

task 'raylib:build' do |task|
  sh "DOCKER_BUILDKIT=1 docker build --output ./ . --file ./scripts/raylib/Dockerfile.raylib --pull --tag taylor_raylib"
end

task 'docker:build' do |task|
  sh "DOCKER_BUILDKIT=1 docker build --output ./ . --file ./Dockerfile.build --pull --tag taylor_build"
end
