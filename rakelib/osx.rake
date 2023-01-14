require_relative 'builder.rb'
require_relative 'helpers.rb'

class OSXBuilder < Builder
  def initialize
    @platform = 'osx'
    @cxx = 'x86_64-apple-darwin19-clang++'
    @cxxflags = ' -Oz -mmacosx-version-min=10.11 -stdlib=libc++'
    @ldflags = <<-EOS.chomp
      -l dl \
      -l pthread \
      -framework CoreVideo \
      -framework IOKit \
      -framework Cocoa \
      -framework GLUT \
      -framework OpenGL
    EOS
    @includes = '-I /opt/osxcross/target/SDK/MacOSX10.15.sdk/System/Library/Frameworks/OpenGL.framework/Headers'
    @static_links = './vendor/osx/libmruby.a ./vendor/osx/raylib/lib/libraylib.a'
    @release_flags = '-03'

    after_initialize
  end
end

builder = OSXBuilder.new
Builder.register(builder)

namespace :osx do
  multitask :build_depends => depends("build/osx/debug")
  multitask :build_objects => objects("build/osx/debug")
  task :build => [:build_depends, :build_objects]
  desc "Build for osx in debug mode"
  task :build => "build:osx:debug"

  namespace :release do
    task :strip do
      sh "x86_64-apple-darwin19-strip \"./dist/#{builder.platform}/#{builder.variant}/#{builder.name}\""
    end

    multitask :build_depends => depends("build/osx/release")
    multitask :build_objects => objects("build/osx/release")
    task :build => [:build_depends, :build_objects]
    task :build => "build:osx:release"
    desc "Build for osx in release mode"
    task :build => "osx:release:strip"
  end
end
