require "fileutils"
require "rake/clean"
require 'rake/loaders/makefile'

supported_platforms = %w(linux windows)
supported_variants = %w(debug release)

name = "game"
platform = ""
cxx = ""
variant = "debug"
cxxflags = "-std=c++2a -no-pie -Wall -Wextra" # -pedantic-errors"
ldflags = "-l pthread"
includes = "-I ./include/ -I ./vendor/ -I ./vendor/raygui/ -I ../includes/mruby-3.0.0/include/"
static_links = "./vendor/libmruby.a"
SRC_FOLDER = "src"
SRC = Rake::FileList["#{SRC_FOLDER}/**/*.cpp"]
objects_folder = "build"
objects = ->(objects_folder){ SRC.ext('.o').map { |file| file.gsub(SRC_FOLDER, objects_folder) } }
depends = ->(objects_folder){ SRC.ext('.mf').map { |file| file.gsub(SRC_FOLDER, objects_folder) } }

VERSION = File.read("./include/version.hpp").each_line.to_a.last.split('"')[1]

CLEAN.include("./build/*")
CLEAN.include("./dist/*")
CLEAN.include("./releases/*")

task :default => "linux:build"

def source_for(o_file)
  SRC.detect{ |file|
    file.ext('').gsub(SRC_FOLDER, '') == o_file.ext('').gsub(/^build\/(windows|linux)\/(debug|release)/, '')
  }
end

namespace :linux do
  task :setup_variables do
    objects_folder = "build/linux/debug"
    cxx = "g++"
    platform = "linux"
    ldflags = "-l dl -l pthread"
    includes += " -I ../includes/raylib-3.5.0_linux_amd64/include/"
    static_links = "#{static_links} ./vendor/linux/libraylib.a"
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

    task :build => "linux:setup_variables"
    task :build => "linux:release:setup_variables"
    multitask :build => depends.call("build/linux/release")
    multitask :build => objects.call("build/linux/release")
    task :build => "build:linux:release"
    task :build => "zip:linux"
  end
end

namespace :windows do
  task :setup_variables do
    name = "#{name}.exe"
    objects_folder = "build/windows/debug"
    cxx = "x86_64-w64-mingw32-g++"
    platform = "windows"
    ldflags = "-L ../includes/raylib-3.5.0_win64_mingw-w64/lib/ -static -l raylib #{ldflags}"
    cxxflags += " -mwindows -static-libstdc++"
    includes += " -I ../includes/raylib-3.5.0_win64_mingw-w64/include/"

    static_links = "#{static_links} ./vendor/windows/libraylibdll.a ./vendor/windows/libraylib.a"
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

    task :build => "windows:setup_variables"
    task :build => "windows:release:setup_variables"
    multitask :build => depends.call("build/windows/release")
    multitask :build => objects.call("build/windows/release")
    task :build => "build:windows:release"
    task :build => "windows:release:copy_dlls"
    task :build => "zip:windows"
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
    #{cxx} #{cxxflags} #{includes} -c #{task.source} \
      -o #{task.name} \
      #{ldflags}
  CMD
end

rule ".mf" => ->(file){ source_for(file) } do |task|
  data = `#{<<-CMD.squeeze(' ').strip}`
    #{cxx} #{cxxflags} #{includes} -c #{task.source} \
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
          -o ./dist/#{platform}/#{variant}/#{name} \
          #{cxxflags} \
          #{includes} \
          #{objects.call(objects_folder).join ' '} \
          #{static_links} \
          #{ldflags}
      CMD
    end
  }
}

supported_platforms.each { |platform|
  task "zip:#{platform}" do |task|
    FileUtils.mkdir_p("./releases")
    sh "zip -9r releases/#{name}-#{platform}-#{VERSION}.zip ./dist/#{platform}/release"
  end
}

task :release => supported_platforms.map { |platform| "#{platform}:release:build" }
task :all => supported_platforms.flat_map { |platform| ["#{platform}:build", "#{platform}:release:build"] }
