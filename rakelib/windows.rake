require_relative "builder"
require_relative "helpers"

class WindowsBuilder < Builder
  def setup_platform
    @platform = "windows"
    @cxx = "x86_64-w64-mingw32-g++"
    @cxxflags = "-std=c++17 -no-pie -Wall -Wextra -mwindows -static-libstdc++"
    @ldflags = "-L ./vendor/windows/raylib/lib/ -static -lwsock32 -lws2_32 -lwinmm -l raylib -l pthread"
    @release_flags = "-03"
  end

  def name
    "#{@options["name"]}.exe"
  end
end

builder = WindowsBuilder.new
Builder.register(builder)

VARIANTS.each { |variant|
  task "windows:#{variant}:copy_dlls" do
    sh "cp -rv ./vendor/windows/*.dll ./dist/windows/#{variant}"
  end
}

namespace :windows do
  multitask build_depends: builder.depends
  multitask build_objects: builder.objects
  task build: builder.build_dependencies
  task build: "build:windows:debug"
  desc "Build for windows in debug mode"
  task build: "windows:debug:copy_dlls"

  namespace :release do
    task :strip do
      sh %(x86_64-w64-mingw32-strip "./dist/#{builder.platform}/#{builder.variant}/#{builder.name}")
    end

    multitask build_depends: builder.depends("release")
    multitask build_objects: builder.objects("release")
    task build: builder.build_dependencies
    task build: "build:windows:release"
    task build: "windows:release:copy_dlls"
    desc "Build for windows in release mode"
    task build: "windows:release:strip"
  end
end
