require_relative 'builder.rb'
require_relative 'helpers.rb'

class OSXIntelBuilder < Builder
  def initialize
    @platform = 'osx/intel'
    @cxx = 'x86_64-apple-darwin20.4-clang++'
    @cxxflags = ' -Oz -mmacosx-version-min=11.3 -stdlib=libc++'
    @ldflags = <<-EOS.chomp
      -l dl \
      -l pthread \
      -framework CoreVideo \
      -framework IOKit \
      -framework Cocoa \
      -framework GLUT \
      -framework OpenGL
    EOS
    @includes = '-I /opt/osxcross/target/SDK/MacOSX11.4.sdk/System/Library/Frameworks/OpenGL.framework/Headers'
    @static_links = './vendor/osx_intel/libmruby.a ./vendor/osx_intel/raylib/lib/libraylib.a'
    @release_flags = '-03'

    after_initialize
  end

  def name
    "#{@options['name']}-intel"
  end
end

builder = OSXIntelBuilder.new
Builder.register(builder)

namespace 'osx/intel' do
  multitask :build_depends => depends("build/osx/intel/debug")
  multitask :build_objects => objects("build/osx/intel/debug")
  task :build => [:setup_ephemeral_files, :build_depends, :build_objects]
  desc "Build for osx in debug mode"
  task :build => "build/osx:debug"

  namespace :release do
    task :strip do
      sh "x86_64-apple-darwin20.4-strip \"./dist/#{builder.platform}/#{builder.variant}/#{builder.name}\""
    end

    multitask :build_depends => depends("build/osx/intel/release")
    multitask :build_objects => objects("build/osx/intel/release")
    task :build => [:setup_ephemeral_files, :build_depends, :build_objects]
    task :build => "build:osx/intel:release"
    desc "Build for osx in release mode"
    task :build => "osx/intel:release:strip"
  end
end
