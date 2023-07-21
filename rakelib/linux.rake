require_relative 'builder.rb'
require_relative 'helpers.rb'

class LinuxBuilder < Builder
  def initialize
    @platform = 'linux'
    @cxx = 'g++'
    @cxxflags = '-std=c++17'
    @ldflags = '-l dl -l pthread'
    @static_links = './vendor/linux/libmruby.a ./vendor/linux/raylib/lib/libraylib.a'
    @release_flags = '-03'

    after_initialize
  end
end

builder = LinuxBuilder.new
Builder.register(builder)

namespace :linux do
  multitask :build_depends => depends('build/linux/debug')
  multitask :build_objects => objects('build/linux/debug')
  task :build => [:setup_ephemeral_files, :build_depends, :build_objects]
  desc "Build for linux in debug mode"
  task :build => 'build:linux:debug'

  namespace :release do
    task :strip do
      sh "strip \"./dist/#{builder.platform}/#{builder.variant}/#{builder.name}\""
    end

    multitask :build_depends => depends('build/linux/release')
    multitask :build_objects => objects('build/linux/release')
    task :build => [:setup_ephemeral_files, :build_depends, :build_objects]
    task :build => 'build:linux:release'
    desc "Build for linux in release mode"
    task :build => 'linux:release:strip'
  end
end
