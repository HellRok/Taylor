require_relative "builder"
require_relative "helpers"

class OSXIntelBuilder < Builder
  def setup_platform
    @platform = "osx/intel"
    @cxx = "x86_64-apple-darwin20.4-clang++"
    @cxxflags = " -Oz -mmacosx-version-min=11.3 -stdlib=libc++"
    @ldflags = <<-EOS.chomp
      -l dl \
      -l pthread \
      -framework CoreVideo \
      -framework IOKit \
      -framework Cocoa \
      -framework GLUT \
      -framework OpenGL
    EOS
    @includes << "-I /opt/osxcross/target/SDK/MacOSX11.4.sdk/System/Library/Frameworks/OpenGL.framework/Headers"
    @release_flags = "-03"
  end

  def name = "#{@options["name"]}-intel"
end

builder = OSXIntelBuilder.new
Builder.register(builder)

namespace "osx/intel" do
  multitask build_depends: builder.depends
  multitask build_objects: builder.objects
  task build: builder.build_dependencies
  desc "Build for osx/intel in debug mode"
  task build: "build:osx/intel:debug"

  namespace :release do
    task :strip do
      sh "x86_64-apple-darwin20.4-strip \"./dist/#{builder.platform}/#{builder.variant}/#{builder.name}\""
    end

    multitask build_depends: builder.depends("release")
    multitask build_objects: builder.objects("release")
    task build: builder.build_dependencies
    task build: "build:osx/intel:release"
    desc "Build for osx/intel in release mode"
    task build: "osx/intel:release:strip"
  end
end
