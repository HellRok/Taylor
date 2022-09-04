require "json"
require "fileutils"
require "rake/clean"
require 'rake/loaders/makefile'

PLATFORMS = %w(linux windows osx web android)
VARIANTS = %w(debug release)

if File.exist?('/app/game/taylor-config.json')
  options = JSON.parse(File.read('/app/game/taylor-config.json'))
else
  options = {}
end

name = options.fetch('name', "taylor")
platform = ""
cxx = ""
variant = "debug"
cxxflags = "-std=c++17 -no-pie -Wall -Wextra"
ldflags = "-l pthread"
includes = "-I ./include/ -I ./vendor/ -I ./vendor/raylib/include/ -I ./vendor/mruby/"
static_links = ""
SRC_FOLDER = "src"
SRC = Rake::FileList["#{SRC_FOLDER}/**/*.cpp"]
objects_folder = "build"
objects = ->(objects_folder){ SRC.ext('.o').map { |file| file.gsub(SRC_FOLDER, objects_folder) } }
depends = ->(objects_folder){ SRC.ext('.mf').map { |file| file.gsub(SRC_FOLDER, objects_folder) } }

defines = ''
defines << '-DEXPORT' if ENV['EXPORT']

VERSION = File.read("./include/version.hpp").each_line.to_a.last.split('"')[1]

CLEAN.include("./build/*")
CLEAN.include("./dist/*")
CLEAN.include("./releases/*")

task :default => "linux:build"

def source_for(o_file)
  SRC.detect{ |file|
    file.ext('').gsub(SRC_FOLDER, '') == o_file.ext('').gsub(/^build\/(#{PLATFORMS.join('|')})\/(#{VARIANTS.join('|')})/, '')
  }
end

namespace :linux do
  task :setup_variables do
    objects_folder = "build/linux/debug"
    cxx = "g++"
    platform = "linux"
    ldflags = "-l dl -l pthread"
    static_links = <<-EOS.chomp
      #{static_links} \
      ./vendor/linux/libmruby.a \
      ./vendor/linux/raylib/lib/libraylib.a
    EOS
  end

  task :build => "linux:setup_variables"
  multitask :build_depends => depends.call("build/linux/debug")
  multitask :build_objects => objects.call("build/linux/debug")
  task :build => [:build_depends, :build_objects]
  task :build => "build:linux:debug"

  namespace :release do
    task :setup_variables do
      objects_folder = "build/linux/release"
      variant = "release"
      cxxflags += " -O3"
    end

    task :strip do
      sh "strip \"./dist/#{platform}/#{variant}/#{name}\""
    end

    task :build => "linux:setup_variables"
    task :build => "linux:release:setup_variables"
    multitask :build_depends => depends.call("build/linux/release")
    multitask :build_objects => objects.call("build/linux/release")
    task :build => [:build_depends, :build_objects]
    task :build => "build:linux:release"
    task :build => "linux:release:strip"
  end
end

namespace :windows do
  task :setup_variables do
    name = "#{name}.exe"
    objects_folder = "build/windows/debug"
    cxx = "x86_64-w64-mingw32-g++"
    platform = "windows"
    ldflags = "-L ./vendor/windows/raylib/lib/ -static -lwsock32 -lws2_32 -lwinmm -l raylib #{ldflags}"
    cxxflags += " -mwindows -static-libstdc++"

    static_links = <<-EOS.chomp
      #{static_links} \
      ./vendor/windows/libmruby.a \
      ./vendor/windows/raylib/lib/libraylib.a
    EOS
  end

  task :build => "windows:setup_variables"
  multitask :build_depends => depends.call("build/windows/debug")
  multitask :build_objects => objects.call("build/windows/debug")
  task :build => [:build_depends, :build_objects]
  task :build => "build:windows:debug"
  task :build => "windows:debug:copy_dlls"

  namespace :release do
    task :setup_variables do
      objects_folder = "build/windows/release"
      variant = "release"
      cxxflags += " -O3"
    end

    task :strip do
      sh "x86_64-w64-mingw32-strip \"./dist/#{platform}/#{variant}/#{name}\""
    end

    task :build => "windows:setup_variables"
    task :build => "windows:release:setup_variables"
    multitask :build_depends => depends.call("build/windows/release")
    multitask :build_objects => objects.call("build/windows/release")
    task :build => [:build_depends, :build_objects]
    task :build => "build:windows:release"
    task :build => "windows:release:copy_dlls"
    task :build => "windows:release:strip"
  end
end

namespace :osx do
  task :setup_variables do
    objects_folder = "build/osx/debug"
    cxx = "x86_64-apple-darwin19-clang++"
    cxxflags = " -Oz -mmacosx-version-min=10.11 -stdlib=libc++"
    platform = "osx"
    ldflags = <<-EOS.chomp
      -l dl \
      -l pthread \
      -framework CoreVideo \
      -framework IOKit \
      -framework Cocoa \
      -framework GLUT \
      -framework OpenGL
    EOS
    includes += " -I /opt/osxcross/target/SDK/MacOSX10.15.sdk/System/Library/Frameworks/OpenGL.framework/Headers"
    static_links = <<-EOS.chomp
      #{static_links} \
      ./vendor/osx/libmruby.a \
      ./vendor/osx/raylib/lib/libraylib.a
    EOS
  end

  task :build => "osx:setup_variables"
  multitask :build_depends => depends.call("build/osx/debug")
  multitask :build_objects => objects.call("build/osx/debug")
  task :build => [:build_depends, :build_objects]
  task :build => "build:osx:debug"

  namespace :release do
    task :setup_variables do
      objects_folder = "build/osx/release"
      variant = "release"
      cxxflags += " -Oz -mmacosx-version-min=10.11 -stdlib=libc++"
    end

    task :strip do
      sh "x86_64-apple-darwin19-strip \"./dist/#{platform}/#{variant}/#{name}\""
    end

    task :build => "osx:setup_variables"
    task :build => "osx:release:setup_variables"
    multitask :build_depends => depends.call("build/osx/release")
    multitask :build_objects => objects.call("build/osx/release")
    task :build => [:build_depends, :build_objects]
    task :build => "build:osx:release"
    task :build => "osx:release:strip"
  end
end

namespace :web do
  task :setup_variables do
    name = "#{name}.html"
    objects_folder = "build/web/debug"
    cxx = "emcc"
    cxxflags.gsub!("-no-pie", '')
    ldflags = ""
    if options.dig('web', 'shell_path')
      static_links = "--shell-file #{File.join('/', 'app', 'game', options['web']['shell_path'])}"
    else
      static_links = "--shell-file ./scripts/export/emscripten_shell.html"
    end
    options.fetch('copy_paths', []).each { |path|
      static_links += " --preload-file #{File.join('/', 'app', 'game', path)}@#{path}"
    }
    platform = "web"
    static_links = <<-EOS.chomp
      -s USE_GLFW=3 \
      -s ASYNCIFY \
      -s ALLOW_MEMORY_GROWTH \
      #{static_links} \
      ./vendor/web/libmruby.a \
      ./vendor/web/raylib/lib/libraylib.a \
      -s EXPORTED_RUNTIME_METHODS=['UTF8ToString','stringToUTF8','lengthBytesUTF8']
    EOS
  end

  task :build => "web:setup_variables"
  multitask :build_depends => depends.call("build/web/debug")
  multitask :build_objects => objects.call("build/web/debug")
  task :build => [:build_depends, :build_objects]
  task :build => "build:web:debug"

  namespace :release do
    task :setup_variables do
      objects_folder = "build/web/release"
      variant = "release"
      cxxflags += " -O3"
    end

    task :build => "web:setup_variables"
    task :build => "web:release:setup_variables"
    multitask :build_depends => depends.call("build/web/release")
    multitask :build_objects => objects.call("build/web/release")
    task :build => [:build_depends, :build_objects]
    task :build => "build:web:release"
  end
end

namespace :android do
  task :setup_variables do
    name = "libmain.so"
    objects_folder = "build/android/debug"
    cxx = "aarch64-linux-android29-clang++"
    cxxflags = <<-EOS.chomp
      -Oz \
      -stdlib=libc++ \
      -fPIC \
      -ffunction-sections -funwind-tables -fstack-protector-strong \
      -no-canonical-prefixes \
      -static-libstdc++ \
      -D ANRDOID \
      -D ANDROID_API__29
    EOS
    includes += " -I /ndk/android-ndk-r25b/sources/android/native_app_glue/"
    platform = "android"
    ldflags = ""
    static_links = <<-EOS.chomp
      -shared \
      -l log \
      -l android \
      -l EGL \
      -l GLESv2 \
      -l OpenSLES \
      -l atomic \
      -u ANativeActivity_onCreate \
      -Wl,-soname,libmain.so \
      #{static_links} \
      ./vendor/android/libmruby.a \
      ./vendor/android/raylib/lib/libraylib.a \
      /ndk/android-ndk-r25b/sources/android/native_app_glue/android_native_app_glue.a
    EOS
  end

  task :build => "android:setup_variables"
  multitask :build_depends => depends.call("build/android/debug")
  multitask :build_objects => objects.call("build/android/debug")
  task :build => [:build_depends, :build_objects]
  task :build => "build:android:debug"

  namespace :release do
    task :setup_variables do
      objects_folder = "build/android/release"
      variant = "release"
      cxxflags += " -O3"
    end

    task :strip do
      sh "/ndk/android-ndk-r25b/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-strip \"./dist/#{platform}/#{variant}/#{name}\""
    end

    task :build => "android:setup_variables"
    task :build => "android:release:setup_variables"

    task :native_app_glue do
      sh "aarch64-linux-android29-clang -c /ndk/android-ndk-r25b/sources/android/native_app_glue/android_native_app_glue.c -o /ndk/android-ndk-r25b/sources/android/native_app_glue/native_app_glue.o -ffunction-sections -funwind-tables -fstack-protector-strong -fPIC -Wall -Wformat -Werror=format-security -no-canonical-prefixes -DANDROID -DPLATFORM_ANDROID -D__ANDROID_API__=29"
      sh "llvm-ar rcs /ndk/android-ndk-r25b/sources/android/native_app_glue/android_native_app_glue.a /ndk/android-ndk-r25b/sources/android/native_app_glue/native_app_glue.o"
    end
    task :build => :native_app_glue

    multitask :build_depends => depends.call("build/android/release")
    multitask :build_objects => objects.call("build/android/release")
    task :build => [:build_depends, :build_objects]
    task :build => "build:android:release"

    task :build_apk do
      sh <<-CMD
        mkdir -p android/build/dex
        mkdir -p android/build/res
        mkdir -p android/build/res/drawable-ldpi/
        mkdir -p android/build/src
        mkdir -p android/build/lib/arm64-v8a/
      CMD

      sh <<-CMD
        #keytool -genkeypair -validity 1000 -dname "CN=raylib,O=Android,C=ES" -keystore raylib.keystore -storepass 'raylib' -keypass 'raylib' -alias projectKey -keyalg RSA
        #keytool -genkey -v -keystore /app/raylib.keystore -storepass buttsbuttsbutts -keyalg RSA -keysize 2048 -validity 10000 -alias app
      CMD

      sh <<-CMD
        cp scripts/android/check.png android/build/res/drawable-ldpi/icon.png
        aapt package -f -m \
          -S android/build/res \
          -J android/build/src \
          -M /app/taylor/scripts/android/AndroidManifest.xml \
          -I /sdk/platforms/android-29/android.jar
      CMD

      sh <<-CMD
        javac -verbose -source 1.8 -target 1.8 -d android/build/obj \
          -bootclasspath jre/lib/rt.jar \
          -classpath /sdk/platforms/android-29/android.jar:android/build/obj \
          -sourcepath src android/build/src/com/raylib/game/R.java \
          /app/taylor/scripts/android/NativeLoader.java

      CMD

      sh <<-CMD
        dx --verbose --dex --output=android/build/dex/classes.dex android/build/obj
      CMD

      sh <<-CMD
        aapt package -f \
          -M /app/taylor/scripts/android/AndroidManifest.xml -S android/build/res -A /app/game/assets \
          -I /sdk/platforms/android-29/android.jar -F /app/game/exports/game.apk android/build/dex

        #aapt add /app/game/exports/game.apk /app/taylor/dist/android/release/libmain.so
        mv /app/taylor/dist/android/release/libmain.so /app/taylor/android/build/lib/arm64-v8a/

        cd /app/taylor/android/build
        aapt add /app/game/exports/game.apk lib/arm64-v8a/libmain.so
        cd -
      CMD

      sh <<-CMD
        #jarsigner -keystore android/raylib.keystore -storepass raylib -keypass raylib \
        #  -signedjar game.apk game.apk projectKey

        zipalign -f 4 /app/game/exports/game.apk /app/game/exports/game.zip.apk
      CMD

      sh <<-CMD
        apksigner sign --ks-key-alias app --ks /app/game/raylib.keystore --ks-pass pass:buttsbuttsbutts --key-pass pass:buttsbuttsbutts /app/game/exports/game.zip.apk
      CMD
    end

    task :build => :build_apk
  end
end

VARIANTS.each { |variant|
  task "windows:#{variant}:copy_dlls" do
    sh "cp -rv ./vendor/windows/*.dll ./dist/windows/#{variant}"
  end
}

rule ".o" => ->(file){ source_for(file) } do |task|
  FileUtils.mkdir_p(File.dirname(task.name))
  sh <<-CMD.squeeze(' ').strip
    #{cxx} #{cxxflags} #{includes} #{defines} -c #{task.source} \
      -o #{task.name} \
      #{ldflags}
  CMD
end

rule ".mf" => ->(file){ source_for(file) } do |task|
  data = `#{<<-CMD.squeeze(' ').strip}`
    #{cxx} #{cxxflags} #{includes} #{defines} -c #{task.source} \
      #{ldflags} \
      -MM \
      -MT #{task.name.gsub(SRC_FOLDER, objects_folder).ext('.o')}
  CMD

  file, deps = data.split(':')
  deps = deps.split.select{ |dep| File.exist? dep }

  Rake::Task[file].enhance deps
end

PLATFORMS.each { |platform|
  VARIANTS.each { |variant|
    task "build:#{platform}:#{variant}" do |task|
      FileUtils.mkdir_p("./dist/#{platform}/#{variant}")
      sh <<-CMD.squeeze(' ').strip
        #{cxx} \
          -o \"./dist/#{platform}/#{variant}/#{name}\" \
          #{cxxflags} \
          #{defines} \
          #{includes} \
          #{objects.call(objects_folder).join ' '} \
          #{static_links} \
          #{ldflags}
      CMD
    end
  }
}

def build_docker(file, tag:, export: false)
  if export
    sh "DOCKER_BUILDKIT=1 docker build --output ./ . --file #{file} --tag #{tag}"
  else
    sh "docker build . --file #{file} --pull --tag #{tag}"
  end
end


namespace :docker do
  namespace :build do
    task :android do; build_docker("./scripts/docker/Dockerfile.android", tag: "taylor/build-android"); end
    task :linux do;   build_docker("./scripts/docker/Dockerfile.linux",   tag: "taylor/build-linux"); end
    task :windows do; build_docker("./scripts/docker/Dockerfile.windows", tag: "taylor/build-windows"); end
    task :osx do;     build_docker("./scripts/docker/Dockerfile.osx",     tag: "taylor/build-osx"); end
    task :web do;     build_docker("./scripts/docker/Dockerfile.web",     tag: "taylor/build-web"); end
    multitask :all => [:android, :linux, :windows, :osx, :web]

    task :mruby do |task|
      sh "rm -rf ./vendor/mruby"
      build_docker("./scripts/mruby/Dockerfile.mruby", tag: "taylor/mruby", export: true)
    end

    task :raylib do |task|
      build_docker("./scripts/raylib/Dockerfile.raylib", tag: "taylor/raylib", export: true)
    end
  end
end
