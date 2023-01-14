require_relative 'builder.rb'
require_relative 'helpers.rb'

class WindowsBuilder < Builder
  def initialize
    @platform = 'windows'
    @cxx = 'x86_64-w64-mingw32-g++'
    @ldflags = '-L ./vendor/windows/raylib/lib/ -static -lwsock32 -lws2_32 -lwinmm -l raylib -l pthread'
    @static_links = './vendor/windows/libmruby.a ./vendor/windows/raylib/lib/libraylib.a'
    @release_flags = '-03'
    @cxxflags =  '-std=c++17 -no-pie -Wall -Wextra -mwindows -static-libstdc++'

    after_initialize
  end

  def name
    "#{@options['name']}.exe"
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
  multitask :build_depends => depends("build/windows/debug")
  multitask :build_objects => objects("build/windows/debug")
  task :build => [:build_depends, :build_objects]
  task :build => "build:windows:debug"
  desc "Build for windows in debug mode"
  task :build => "windows:debug:copy_dlls"

  namespace :release do
    task :strip do
      sh "x86_64-w64-mingw32-strip \"./dist/#{builder.platform}/#{builder.variant}/#{builder.name}\""
    end

    multitask :build_depends => depends("build/windows/release")
    multitask :build_objects => objects("build/windows/release")
    task :build => [:build_depends, :build_objects]
    task :build => "build:windows:release"
    task :build => "windows:release:copy_dlls"
    desc "Build for windows in release mode"
    task :build => "windows:release:strip"
  end
end
