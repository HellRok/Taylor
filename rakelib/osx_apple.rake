require_relative "builder"
require_relative "helpers"

class OSXAppleBuilder < Builder
  def initialize
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
    @includes = "-I /opt/osxcross/target/SDK/MacOSX11.4.sdk/System/Library/Frameworks/OpenGL.framework/Headers"
    @static_links = "./vendor/osx_apple/libmruby.a ./vendor/osx_apple/raylib/lib/libraylib.a"
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
  multitask build_depends: depends("build/osx/apple/debug")
  multitask build_objects: objects("build/osx/apple/debug")
  task build: [:setup_ephemeral_files, :build_depends, :build_objects]
  desc "Build for osx/apple in debug mode"
  task build: "build:osx/apple:debug"

  namespace :release do
    multitask build_depends: depends("build/osx/apple/release")
    multitask build_objects: objects("build/osx/apple/release")
    task build: [:setup_ephemeral_files, :build_depends, :build_objects]
    desc "Build for osx/apple in release mode"
    task build: "build:osx/apple:release"
    # We do not strip the OSX Apple binary as it breaks the binary signature
  end
end
