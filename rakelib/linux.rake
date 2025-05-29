require_relative "builder"
require_relative "helpers"

class LinuxBuilder < Builder
  def setup_platform
    @platform = "linux"
    @cxx = "g++"
    @cxxflags = "-std=c++17"
    @ldflags = "-l dl -l pthread"
  end
end

builder = LinuxBuilder.new
Builder.register(builder)

namespace :linux do
  multitask build_depends: builder.depends
  multitask build_objects: builder.objects
  task build: builder.build_dependencies
  desc "Build for linux in debug mode"
  task build: "build:linux:debug"

  namespace :release do
    task :strip do
      sh "strip \"./dist/#{builder.platform}/#{builder.variant}/#{builder.name}\""
    end

    multitask build_depends: builder.depends("release")
    multitask build_objects: builder.objects("release")
    task build: builder.build_dependencies
    task build: "build:linux:release"
    desc "Build for linux in release mode"
    task build: "linux:release:strip"
  end
end
