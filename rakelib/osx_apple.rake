require_relative "builder"
require_relative "helpers"

class OSXAppleBuilder < Builder
  def setup_platform
    @platform = "osx/apple"
    @cxx = "arm64-apple-darwin20.4-clang++"
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

    after_initialize
  end

  def name
    "#{@options["name"]}-apple"
  end
end

builder = OSXAppleBuilder.new
Builder.register(builder)

namespace "osx/apple" do
  multitask build_depends: builder.depends
  multitask build_objects: builder.objects
  task build: builder.build_dependencies
  desc "Build for osx/apple in debug mode"
  task build: "build:osx/apple:debug"

  namespace :release do
    multitask build_depends: builder.depends("release")
    multitask build_objects: builder.objects("release")
    task build: builder.build_dependencies
    desc "Build for osx/apple in release mode"
    task build: "build:osx/apple:release"
    # We do not strip the OSX Apple binary as it breaks the binary signature
  end
end
